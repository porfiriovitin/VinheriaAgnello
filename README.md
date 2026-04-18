# Vinheria Agnello - Architecture & Developer Guide

> Este documento descreve a arquitetura atual do projeto, os fluxos principais e as convenções que precisam ser preservadas durante manutenção e evolução da aplicação.

---

## 1. Visão Geral

A aplicação é uma Web App Java baseada em:

- `JSP` para renderização de páginas
- `Servlet` com padrão **Front Controller**
- `MongoDB` para persistência
- `Tailwind CSS` no frontend
- `JavaScript` separado em camadas de API e UI

O projeto segue arquitetura **MVC (Model-View-Controller)** com organização por funcionalidade.

---

## 2. Front Controller

O ponto de entrada da aplicação é o [DispatcherServlet.java](src/main/java/br/com/fiap/server/DispatcherServlet.java).

Ele é responsável por:

- receber todas as requisições em `/controller`
- ler o parâmetro `action`
- buscar a implementação correspondente no `actionRegistry`
- executar a `Action`
- fazer `forward` para JSP quando a action retorna uma view
- encerrar o fluxo quando a action já respondeu diretamente com redirect ou JSON

Exemplo de rota:

```text
/controller?action=ShowCatalog
```

As instâncias de `Action` são registradas uma vez no `init()`, então devem continuar **sem estado por usuário**.

---

## 3. Estrutura por Feature

As actions estão organizadas por domínio em `src/main/java/br/com/fiap/action`:

- `br.com.fiap.action.auth`
  - `ShowLogin`
  - `ShowSignup`
  - `Login`
  - `SignUp`
  - `AuthFlowSupport`
- `br.com.fiap.action.cart`
  - `ShowCartCheckout`
  - `AddToCart`
  - `RemoveFromCart`
- `br.com.fiap.action.checkout`
  - `CheckoutFlowSupport`
  - `ShowCheckoutAddress`
  - `ShowCheckoutFinalize`
- `br.com.fiap.action.product`
  - `ShowCatalog`
  - `ShowProductDetails`
- `br.com.fiap.action.home`
  - `ShowIndex`
- `br.com.fiap.action.club`
  - `ShowClub`
- `br.com.fiap.action.favorite`
  - `AddFavorite`
  - `RemoveFavorite`

Essa organização mantém leitura e manutenção mais simples do que separar tudo apenas por “controller”, “service” ou “view”.

---

## 4. Modelos, DTOs e Persistência

### Models

Os modelos ficam em `br.com.fiap.model` e representam entidades da aplicação, como:

- `User`
- `Wine`
- `Accessory`
- `Gift`

### DTOs

Os DTOs ficam em `br.com.fiap.dto` e padronizam troca de dados entre backend e frontend.

Exemplos:

- `ApiResponse`
- `Cart`
- `CartRequest`
- `CartResponse`
- `CartWineItem`
- `CartAccessoryItem`

### DAOs

Os acessos ao banco ficam em `br.com.fiap.dao`.

Exemplos:

- `UserDAO`
- `WineDAO`
- `AccessoryDAO`
- `GiftDAO`

O carrinho é persistido dentro do documento do usuário e serializado pelo `UserDAO`. Isso permite renderizar checkout e carrinho sem precisar recompor tudo em tempo real a partir do catálogo.

---

## 5. Frontend

### JSPs

As páginas principais ficam em `src/main/webapp`:

- `home.jsp`
- `catalog.jsp`
- `product-details.jsp`
- `cart-checkout.jsp`
- `checkout-address.jsp`
- `checkout-finalization.jsp`
- `login.jsp`
- `signup.jsp`
- `club.jsp`

### Snippets reutilizáveis

Blocos compartilhados ficam em `src/main/webapp/snippets`:

- `app-scripts.jsp`
- `bottom-nav.jsp`
- `menu.jsp`
- `favicon.jsp`

### JavaScript

Os scripts seguem separação de responsabilidade:

- [api-client.js](src/main/webapp/resources/js/api-client.js)
  - centraliza chamadas HTTP
  - abstrai `fetch`
  - concentra tratamento de erro

- [ui-actions.js](src/main/webapp/resources/js/ui-actions.js)
  - reage às interações do usuário
  - chama a camada de API
  - atualiza DOM e comportamento visual

---

## 6. Navegação e `contextPath`

### Regra importante

Sempre que a aplicação montar links ou redirects internos, deve usar:

- `request.getContextPath()` no backend
- `${pageContext.request.contextPath}` no JSP

### Por que isso é importante

O WAR gerado pelo projeto tem `finalName` igual a `api`, então no ambiente local o contexto da aplicação fica:

```text
http://localhost:8080/api
```

Isso significa que uma rota correta não é apenas:

```text
/controller?action=ShowIndex
```

e sim:

```text
/api/controller?action=ShowIndex
```

Ao usar `contextPath`, o código continua funcionando mesmo se:

- o nome do WAR mudar
- a aplicação sair de `/api`
- a app for publicada em outro servidor
- a porta mudar

### Impacto prático

Essa padronização foi importante para estabilizar:

- navegação entre home, catálogo, clube, login e cadastro
- fluxo de checkout
- redirecionamentos depois de login
- links do menu e bottom-nav
- retorno para home no fechamento do checkout

Também evita bugs de URL quebrada e 404.

### `window.APP_CONTEXT`

No frontend, o snippet [app-scripts.jsp](src/main/webapp/snippets/app-scripts.jsp) injeta o contexto em:

```javascript
window.APP_CONTEXT
```

Isso permite que o JavaScript também monte URLs sem hardcode.

---

## 7. Fluxo de Autenticação

### Login manual

Quando a pessoa entra por `ShowLogin` de forma normal:

- o fluxo limpa redirects pendentes
- depois do login com sucesso, vai para `ShowIndex`

### Login disparado por fluxo protegido

Quando a pessoa tenta abrir carrinho/checkout sem estar logada:

- o sistema salva a action protegida via [AuthFlowSupport.java](src/main/java/br/com/fiap/action/auth/AuthFlowSupport.java)
- redireciona para `ShowLogin&loginContext=checkout`
- após autenticar, volta para o fluxo protegido original

### Cadastro

O cadastro em [SignUp.java](src/main/java/br/com/fiap/action/auth/SignUp.java) hoje:

- cria o usuário
- autentica automaticamente na sessão
- limpa qualquer redirect antigo
- manda direto para `ShowIndex`

Ou seja, não passa mais pela tela de login após criar conta.

---

## 8. Fluxo de Checkout

O checkout foi estruturado em 3 etapas:

1. `Carrinho`
   - [ShowCartCheckout.java](src/main/java/br/com/fiap/action/cart/ShowCartCheckout.java)
   - [cart-checkout.jsp](src/main/webapp/cart-checkout.jsp)
2. `Endereço`
   - [ShowCheckoutAddress.java](src/main/java/br/com/fiap/action/checkout/ShowCheckoutAddress.java)
   - [checkout-address.jsp](src/main/webapp/checkout-address.jsp)
3. `Pagamento`
   - [ShowCheckoutFinalize.java](src/main/java/br/com/fiap/action/checkout/ShowCheckoutFinalize.java)
   - [checkout-finalization.jsp](src/main/webapp/checkout-finalization.jsp)

### Comportamentos importantes desse fluxo

- O carrinho é uma rota protegida: sem login, redireciona para autenticação.
- A etapa de endereço reaproveita os dados do usuário autenticado como base.
- A etapa de pagamento mantém os dados de entrega via campos hidden e post.
- O botão `Editar` no step 3 volta corretamente para a edição do endereço.
- Quando a compra é confirmada (`simulateConfirm=true`), o carrinho persistido do usuário é limpo.
- Mesmo com o carrinho limpo, a tela final continua mostrando o resumo daquele pedido recém-concluído usando uma cópia em memória (`orderSummaryCart`).

### Navegação de retorno

O carrinho possui lógica específica para lembrar sua origem e evitar retornos ruins dentro do fluxo.

Exemplos de comportamento ajustado:

- `Home -> Carrinho -> voltar` retorna para `Home`
- `Entrega -> Carrinho -> voltar` retorna para `Home`
- `Pagamento aprovado -> voltar` retorna para `Home`

---

## 9. Taglibs e Dependências JSP

As páginas usam JSTL para condicionais e loops, evitando scriptlets Java na view.

Exemplo:

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
```

As dependências são gerenciadas via Maven no `pom.xml`.

Se essas libs não estiverem disponíveis no build, tags como `c:if`, `c:forEach` e `fmt:formatNumber` quebram a renderização.

---

## 10. Banco de Dados (MongoDB)

A aplicação usa **MongoDB** como banco principal.

O projeto já possui [docker-compose.yaml](docker-compose.yaml) para subir o banco localmente.

### Setup rápido

```bash
docker-compose up -d
```

### Arquivos de ambiente

O projeto espera configuração por `.env`:

- um arquivo na raiz do projeto
- outro em `src/main/resources`

Os dois devem estar coerentes entre si para evitar falhas de conexão.

Para inspeção manual do banco, pode ser usado o MongoDB Compass com a connection string configurada no ambiente.

---

## 11. Build e Deploy

O projeto é empacotado como `war`.

No [pom.xml](pom.xml), o `finalName` está configurado como:

```xml
<finalName>api</finalName>
```

Então o build gera:

```text
target/api.war
```

Em um Tomcat local, isso normalmente publica a aplicação em:

```text
http://localhost:8080/api
```

### Build local

```bash
mvn clean package
```

---

## 12. Exemplo de Fluxo Assíncrono

Um fluxo que continua servindo como referência é o de favoritos:

1. o catálogo renderiza os produtos
2. cada card expõe um ícone com o `id` do vinho
3. o clique chama uma função em `ui-actions.js`
4. essa função usa `api-client.js` para chamar `AddFavorite`
5. a action responde com JSON
6. o frontend atualiza o estado visual do ícone

Esse padrão também inspira outros fluxos assíncronos do projeto, como atualização de carrinho.

---

## 13. Convenções de Manutenção

Ao evoluir o projeto, preserve estas regras:

- não usar URL interna hardcoded quando `contextPath` resolver o problema
- manter actions sem estado por usuário
- preferir organização por feature
- separar persistência (`DAO`), fluxo (`Action`) e renderização (`JSP`)
- manter scripts de API separados de scripts de UI
- ao mexer em checkout/autenticação, validar redirecionamentos e contexto da aplicação

---

## 14. Arquivos-Chave

Arquivos especialmente importantes para entender o projeto:

- [DispatcherServlet.java](src/main/java/br/com/fiap/server/DispatcherServlet.java)
- [UserDAO.java](src/main/java/br/com/fiap/dao/UserDAO.java)
- [AuthFlowSupport.java](src/main/java/br/com/fiap/action/auth/AuthFlowSupport.java)
- [CheckoutFlowSupport.java](src/main/java/br/com/fiap/action/checkout/CheckoutFlowSupport.java)
- [cart-checkout.jsp](src/main/webapp/cart-checkout.jsp)
- [checkout-address.jsp](src/main/webapp/checkout-address.jsp)
- [checkout-finalization.jsp](src/main/webapp/checkout-finalization.jsp)
- [api-client.js](src/main/webapp/resources/js/api-client.js)
- [ui-actions.js](src/main/webapp/resources/js/ui-actions.js)

