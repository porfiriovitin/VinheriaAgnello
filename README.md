# Project Architecture & Developer Guide

> Este documento descreve os padrões arquiteturais, estruturas de diretórios e componentes principais de nossa aplicação Web Java. Utilizamos uma arquitetura **MVC (Model-View-Controller)** moderna, construída sobre o padrão de design **Front Controller**, para garantir escalabilidade, código limpo e separação de preocupações.

---

## 1. The Front Controller (DispatcherServlet)

O `DispatcherServlet` atua como o ponto de entrada único para todas as requisições HTTP recebidas. Em vez de múltiplos Servlets espalhados pelo projeto, este intercepta a requisição e a roteia para a lógica de negócio apropriada.

* **The Action Registry:** Dentro do método `init()`, o Servlet mantém um `Map<String, Action>` chamado *Action Registry*.
* **Routing Logic:** Quando uma requisição chega (ex: `controller?action=ShowCatalog`), o Servlet busca a string "ShowCatalog" no registro, recupera a instância da `Action` correspondente e chama seu método `execute()`.
* **Thread Safety:** As instâncias de Action no registro são **Singletons** (criadas apenas uma vez no início do servidor). Portanto, **nunca utilize variáveis de instância** em classes Action para armazenar dados do usuário.

---

## 2. Actions (`br.com.yourcompany.action`)

As Actions contêm a lógica de negócio central. Elas recuperam dados do banco, aplicam regras e decidem o que o usuário verá a seguir. Toda classe Action deve implementar a interface `Action`.

### Tipos de Retorno
* **Retornando um JSP (Navegação):** Se a Action retorna uma `String` (ex: `return "WEB-INF/catalog.jsp";`), o `DispatcherServlet` realiza um *forward* no servidor para renderizar a página.
* **Retornando Null (AJAX/APIs):** Se a Action lida com requisições assíncronas e já escreveu uma resposta JSON via `JsonUtil`, ela deve retornar `null`. Isso interrompe o processamento e evita redirecionamentos.

### Padrão "Package by Feature"
As Actions são agrupadas estritamente por domínio (funcionalidade), mantendo o código relacionado unido:
* `action/auth/`: `ShowLogin`, `ProcessSignup`, etc.
* `action/product/`: `ShowCatalog`, `ShowProductDetails`, etc.
* `action/cart/`: `ShowCart`, `AddToCart`, etc.

---

## 3. Data Models & DTOs

Separamos estritamente as entidades do banco de dados dos objetos de comunicação com o frontend.

| Camada | Pacote | Descrição |
| :--- | :--- | :--- |
| **Models** | `br.com.yourcompany.model` | Representam tabelas do banco (ex: `Wine.java` com campos id, nome, safra). |
| **DTOs** | `br.com.yourcompany.dto` | *Data Transfer Objects* formatam os dados para o cliente. O `ApiResponse.java` é a base padrão para garantir JSONs previsíveis. |

---

## 4. Utility Classes (`br.com.yourcompany.util`)

Códigos de infraestrutura repetitivos são abstraídos em utilitários:
* **`JsonUtil.java`:** Encapsula a biblioteca **Gson**. Em vez de configurar headers HTTP manualmente em cada endpoint, as Actions chamam `JsonUtil.sendJson(response, dataObject);`, que serializa o objeto automaticamente.

---

## 5. Frontend Architecture (`webapp/resources/js`)

A arquitetura JavaScript espelha a separação de preocupações do backend:

* **`api-client.js`:** Uma camada de abstração para a API nativa `fetch`. Formata query strings, manipula headers e centraliza o tratamento de erros (HTTP 400/500). **Não contém código de UI.**
* **`ui-actions.js`:** Contém funções disparadas por interações do usuário (ex: `onclick="addToFavorites(15)"`). Elas chamam o `ApiClient.request()`, aguardam o JSON e manipulam o DOM conforme o resultado.

---

## 6. Reusable Views (`webapp/snippets`)

Para aderir ao princípio **DRY (Don't Repeat Yourself)**, componentes HTML repetitivos (navbar, footer, meta tags) são extraídos para arquivos JSP isolados.

**Uso:** Injetar snippets nas páginas principais via diretiva de inclusão:
```jsp
<jsp:include page="snippets/navbar.jsp" />
```

## 7. Taglibs and .jar Dependencies

Para lógica dinâmica em JSPs (loops, condicionais) sem usar código Java bruto (<% %>), utilizamos a JSTL (JavaServer Pages Standard Tag Library).

* **Requisito:** TA aplicação exige os arquivos .jar da JSTL (ex: jstl-1.2.jar e javax.servlet.jsp.jstl-api).
* **Configuração:** Gerenciado via Maven no pom.xml. Se ausentes, tags como <c:forEach> ou <c:if> causarão erros de renderização no servidor.

# Exemplo de fluxo

Para entender o funcionamento da nossa funcionalidade de favoritos, vamos acompanhar o caminho completo que os dados fazem, desde a busca inicial dos produtos até a interação do usuário na tela. Esse é um padrão que se repetirá bastante na aplicação.

### 1. Carregando o Catálogo (Backend)
Tudo começa quando o usuário acessa a URL do catálogo (`<domain>/controller?action=ShowCatalog`). A requisição cai na action `ShowCatalog`, que é responsável por buscar os dados que serão exibidos.

Aqui, criamos uma lista mocada de objetos `Wine` (representando nossos vinhos) e a adicionamos ao parâmetro `wineList` da requisição. Em seguida, redirecionamos o usuário para a página JSP, levando essa lista junto:

```java
public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Wine> mocWineList = new ArrayList<>(Arrays.asList(
                new Wine(1, "Brunello di Montalcino", "Itália", "Toscana", 450.00, "Sangiovese", ""),
                new Wine(2, "Barolo DOCG", "Itália", "Piemonte", 380.00, "Nebbiolo", ""),
                new Wine(3, "Chianti Classico", "Itália", "Toscana", 120.00, "Sangiovese", ""),
                new Wine(4, "Amarone DOCG", "Itália", "Vêneto", 520.00, "Corvina", ""),
                new Wine(5, "Chardonnay Reserve", "EUA", "Napa Valley", 290.00, "Chardonnay", ""),
                new Wine(6, "Malbec Gran Reserva", "Argentina", "Mendoza", 215.00, "Malbec", "")
        ));
        request.setAttribute("wineList", mocWineList);

        return "catalog.jsp";
    }
```

### 2. Renderizando a Página (Frontend - JSP)
Com os dados em mãos, a `catalog.jsp` entra em ação. No topo do arquivo, configuramos a página para aceitar a Expression Language (EL) forçando o `isELIgnored="false"` e importamos a taglib `core`, que será essencial para iterar sobre a nossa lista:

```jsp
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
```

```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
```

Ainda no cabeçalho, incluímos o bloco de código que faz o setup dos nossos scripts JS:

```jsp
<%@ include file="./snippets/app-scripts.jsp"%>
```

No corpo da página, usamos a tag `<c:forEach>` para percorrer a `wineList` que o backend nos enviou. Para cada vinho, a página injeta dinamicamente as informações (como imagem, nome, região e preço) usando EL.

Note que, dentro de cada card, já deixamos preparado um ícone de favorito amarrado ao `id` específico de cada vinho:

```html
<div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 p-4 md:p-8">
            <c:forEach var="wine" items="${wineList}">
                <div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
                    <div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
                        <img alt="Vinho Tinto Brunello" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Elegante garrafa de vinho tinto Brunello di Montalcino" src="${wine.imageURL}"/>
                        <div class="absolute top-2 right-2">
                            <span id="fav-icon-${wine.id}"
                                onclick="addToFavorites(${wine.id})"
                                class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">
                                favorite
                            </span>
                        </div>
                    </div>
                    <div class="p-4 flex flex-col flex-1">
                        <h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">${wine.name}</h3>
                        <p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">${wine.region}, ${wine.country}</p>
                        <div class="mt-auto">
                            <p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ ${wine.price }</p>
                            <button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                                Ver Detalhes
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
```

Para fechar a renderização da página, incluímos o menu lateral e a barra de navegação inferior:

```jsp
 <%@ include file="./snippets/menu.jsp"%>
```
```jsp
 <%@ include file="./snippets/bottom-nav.jsp"%>
```

### 3. Disparando a Ação de Favoritar (Frontend - JS)
Quando o usuário clica no ícone de coração de um produto, o evento `onclick` aciona a função `addToFavorites`, passando o `id` daquele vinho:

```html
<span id="fav-icon-${wine.id}"
                                onclick="addToFavorites(${wine.id})"
                                class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">
                                favorite
</span>
```

Essa função vive no arquivo `ui-actions.js` (que importamos lá no início). Ela faz uma requisição assíncrona ao servidor solicitando a adição do item aos favoritos, usando a abstração `ApiClient`:

```javascript
const responseData = await ApiClient.request('AddFavorite', { id: productId });
```

### 4. Processando o Favorito (Backend)
A requisição do nosso JS bate na action `AddFavorite` (`.../controller?action=AddFavorite`). O primeiro passo dela é capturar o ID que enviamos no corpo da requisição:

```java
String productId = request.getParameter("id");
```

Em seguida, fazemos as validações necessárias (se o ID está vazio, por exemplo) e simulamos a persistência disso no banco. Construímos então uma `ApiResponse` (nossa DTO base) contendo o status da operação:

```java
if (productId == null || productId.trim().isEmpty()) {
            ApiResponse error = new ApiResponse("error", "Product ID is missing.");
            JsonUtil.sendJson(response, error, HttpServletResponse.SC_BAD_REQUEST);

            return null;
        }

        System.out.println("Saving product " + productId + " to favorites...");

        ApiResponse apiResponse = new ApiResponse("success", "Item added to your favorites!");
```

Como não queremos recarregar a página, usamos o `JsonUtil` para enviar essa resposta de volta ao frontend no formato JSON com o código de sucesso (200, por padrão). Retornamos `null` no execute para garantir que nenhum redirecionamento ocorra:

```java
JsonUtil.sendJson(response, apiResponse);
```

### 5. Atualizando a Interface (Frontend - JS)
De volta ao `ui-actions.js`, a execução que estava pausada no `await` é retomada com a resposta do backend. Se tudo deu certo (`status === 'success'`), atualizamos o visual do ícone para mostrar que ele foi favoritado (vermelho e preenchido).

Por fim, alteramos o evento de clique do ícone para apontar para a função `removeFromFavorites`, permitindo que o usuário desfaça a ação no futuro:

```javascript
if (responseData.status === 'success') {
            // :: Find the specific span that was clicked
            const icon = document.getElementById(`fav-icon-${productId}`);

            // :: Update visual state to "Favorited" (Red and filled)
            icon.classList.remove('text-primary/30', 'group-hover:text-primary');
            icon.classList.add('text-red-500');
            icon.style.fontVariationSettings = "'FILL' 1";

            // :: Change the click event to trigger the Remove function
            icon.setAttribute('onclick', `removeFromFavorites(${productId})`);

        }
```