<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="pt-br">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Vinheria Agnello - Entrega</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&amp;family=Noto+Sans:wght@400;500;600&amp;display=swap"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
          rel="stylesheet"/>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#490e0e",
                        "background-light": "#f8f6f6",
                        "background-dark": "#201212",
                    },
                    fontFamily: {
                        "display": ["Noto Serif", "serif"],
                        "sans": ["Noto Sans", "sans-serif"]
                    },
                    borderRadius: {"DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px"},
                },
            },
        }
    </script>
    <style>
        body {
            font-family: 'Noto Sans', sans-serif;
        }

        h1, h2, h3, .font-display {
            font-family: 'Noto Serif', serif;
        }

        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }

        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
    </style>
    <%@ include file="./snippets/app-scripts.jsp"%>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen pb-28"
      data-context-path="${pageContext.request.contextPath}">
<header class="sticky top-0 z-50 bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-sm border-b border-primary/10 px-4 py-3">
    <div class="grid grid-cols-[2.5rem_1fr_2.5rem] items-center">
        <button class="w-10 h-10 flex items-center justify-center rounded-full text-primary hover:bg-primary/5 transition-colors"
                onclick="window.location.href='${pageContext.request.contextPath}/controller?action=ShowCartCheckout&returnTo=home'"
                type="button">
            <span class="material-symbols-outlined">arrow_back</span>
        </button>
        <h1 class="font-display text-lg font-bold tracking-tight text-center">Vinheria Agnello</h1>
        <span aria-hidden="true" class="w-10 h-10 flex items-center justify-center text-primary">
            <span class="material-symbols-outlined">favorite</span>
        </span>
    </div>
</header>

<nav class="max-w-2xl mx-auto px-6 py-6">
    <div class="flex items-center justify-between relative">
        <div class="absolute top-1/2 left-0 w-full h-px bg-primary/20 -translate-y-1/2 -z-10"></div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark pr-4">
            <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center">
                <span class="material-symbols-outlined text-sm">check</span>
            </div>
            <span class="text-xs font-medium text-primary uppercase tracking-wider">Carrinho</span>
        </div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark px-4">
            <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center text-sm font-bold">2</div>
            <span class="text-xs font-medium text-primary uppercase tracking-wider">Entrega</span>
        </div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark pl-4">
            <div class="w-8 h-8 rounded-full border border-primary/30 text-primary/50 flex items-center justify-center text-sm font-bold">3</div>
            <span class="text-xs font-medium text-primary/40 uppercase tracking-wider">Pagamento</span>
        </div>
    </div>
</nav>

<form action="${pageContext.request.contextPath}/controller?action=ShowCheckoutFinalize" method="post">
    <main class="max-w-2xl mx-auto px-4 space-y-8 pb-10">
        <section>
            <h2 class="text-lg font-bold mb-4 flex items-center gap-2">
                <span class="material-symbols-outlined text-primary">person</span>
                Dados do Destinatário
            </h2>
            <div class="bg-white dark:bg-primary/5 p-6 rounded-xl border border-primary/10 shadow-sm space-y-4">
                <p class="text-sm text-slate-600 dark:text-slate-300">
                    Preencha as informações de contato para acompanhamento do pedido e suporte da equipe Agnello.
                </p>
                <div class="space-y-4">
                    <div>
                        <label for="deliveryName" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Nome Completo</label>
                        <input id="deliveryName" name="deliveryName" type="text" required autocomplete="name"
                               value="${deliveryName}"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="grid sm:grid-cols-2 gap-4">
                        <div>
                            <label for="deliveryPhone" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Celular</label>
                            <input id="deliveryPhone" name="deliveryPhone" type="tel" required autocomplete="tel"
                                   value="${deliveryPhone}"
                                   placeholder="(11) 99999-9999"
                                   class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"
                                   oninput="this.value = this.value.replace(/[^0-9]/g, '')"/>
                        </div>
                        <div>
                            <label for="deliveryEmail" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">E-mail</label>
                            <input id="deliveryEmail" name="deliveryEmail" type="email" required autocomplete="email"
                                   value="${deliveryEmail}"
                                   class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section>
            <h2 class="text-lg font-bold mb-4 flex items-center gap-2">
                <span class="material-symbols-outlined text-primary">local_shipping</span>
                Endereço de Entrega
            </h2>
            <div class="bg-white dark:bg-primary/5 p-6 rounded-xl border border-primary/10 shadow-sm space-y-4">
                <div class="grid sm:grid-cols-6 gap-4">
                    <div class="sm:col-span-2">
                        <label for="deliveryCep" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">CEP</label>
                        <input id="deliveryCep" name="deliveryCep" type="text" required inputmode="numeric" autocomplete="postal-code"
                               value="${deliveryCep}"
                               placeholder="00000-000"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-4">
                        <label for="deliveryStreet" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Rua / Avenida</label>
                        <input id="deliveryStreet" name="deliveryStreet" type="text" required autocomplete="address-line1"
                               value="${deliveryStreet}"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-2">
                        <label for="deliveryNumber" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Número</label>
                        <input id="deliveryNumber" name="deliveryNumber" type="text" required autocomplete="address-line2"
                               value="${deliveryNumber}"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-4">
                        <label for="deliveryComplement" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Complemento</label>
                        <input id="deliveryComplement" name="deliveryComplement" type="text"
                               value="${deliveryComplement}"
                               placeholder="Apartamento, bloco, conjunto..."
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-3">
                        <label for="deliveryNeighborhood" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Bairro</label>
                        <input id="deliveryNeighborhood" name="deliveryNeighborhood" type="text" required autocomplete="address-level3"
                               value="${deliveryNeighborhood}"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-2">
                        <label for="deliveryCity" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Cidade</label>
                        <input id="deliveryCity" name="deliveryCity" type="text" required autocomplete="address-level2"
                               value="${deliveryCity}"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-1">
                        <label for="deliveryState" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">UF</label>
                        <input id="deliveryState" name="deliveryState" type="text" required maxlength="2" autocomplete="address-level1"
                               value="${deliveryState}"
                               class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm uppercase focus:ring-primary focus:border-primary"/>
                    </div>
                    <div class="sm:col-span-6">
                        <label for="deliveryReference" class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Ponto de Referência</label>
                        <textarea id="deliveryReference" name="deliveryReference" rows="3"
                                  placeholder="Algo que facilite a entrega, como portaria, prédio ou instrução especial."
                                  class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary">${deliveryReference}</textarea>
                    </div>
                </div>
            </div>
        </section>

        <section class="bg-white dark:bg-primary/5 p-6 rounded-xl border-2 border-dashed border-primary/20">
            <h2 class="text-lg font-display font-bold text-primary mb-2">Forma de Entrega</h2>
            <p class="text-sm text-slate-600 dark:text-slate-300 mb-6">
                Escolha a modalidade que melhor combina com o momento do pedido.
            </p>
            <div class="space-y-3">
                <label class="cursor-pointer block">
                    <input type="radio" name="shippingMethod" value="express" class="peer sr-only" <c:if test="${shippingMethod == 'express'}">checked="checked"</c:if> />
                    <span class="flex items-center gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 transition-all peer-checked:border-primary peer-checked:bg-primary peer-checked:text-white">
                        <span class="material-symbols-outlined">bolt</span>
                        <span class="flex-1">
                            <span class="block font-bold text-sm">Entrega expressa Agnello</span>
                            <span class="block text-xs opacity-80 mt-1">Hoje / 24h para pedidos prioritários.</span>
                        </span>
                    </span>
                </label>
                <label class="cursor-pointer block">
                    <input type="radio" name="shippingMethod" value="scheduled" class="peer sr-only" <c:if test="${shippingMethod == 'scheduled'}">checked="checked"</c:if> />
                    <span class="flex items-center gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 transition-all peer-checked:border-primary peer-checked:bg-primary peer-checked:text-white">
                        <span class="material-symbols-outlined">event_available</span>
                        <span class="flex-1">
                            <span class="block font-bold text-sm">Janela agendada</span>
                            <span class="block text-xs opacity-80 mt-1">Entrega planejada para amanhã.</span>
                        </span>
                    </span>
                </label>
                <label class="cursor-pointer block">
                    <input type="radio" name="shippingMethod" value="cellar" class="peer sr-only" <c:if test="${shippingMethod == 'cellar'}">checked="checked"</c:if> />
                    <span class="flex items-center gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 transition-all peer-checked:border-primary peer-checked:bg-primary peer-checked:text-white">
                        <span class="material-symbols-outlined">ac_unit</span>
                        <span class="flex-1">
                            <span class="block font-bold text-sm">Rota climatizada premium</span>
                            <span class="block text-xs opacity-80 mt-1">Cuidado extra para rótulos mais sensíveis.</span>
                        </span>
                    </span>
                </label>
            </div>
        </section>

        <section>
            <h2 class="text-lg font-bold mb-4 flex items-center gap-2">
                <span class="material-symbols-outlined text-primary">shopping_bag</span>
                Resumo do Pedido
            </h2>
            <div class="space-y-3">
                <c:forEach var="item" items="${cart.wines}">
                    <div class="flex items-center gap-4 bg-white dark:bg-primary/5 p-3 rounded-xl border border-primary/5 shadow-sm">
                        <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-lg size-20 shrink-0"
                             style='background-image: url("${item.imageUrl}");'></div>
                        <div class="flex flex-col flex-1 min-w-0">
                            <p class="text-slate-900 dark:text-slate-100 font-display font-medium text-base leading-tight truncate">${item.name}</p>
                            <p class="text-primary/70 text-sm font-normal mb-2">Qtd ${item.quantity}</p>
                            <p class="text-primary font-bold">
                                R$ <fmt:formatNumber value="${item.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                        </div>
                    </div>
                </c:forEach>

                <c:forEach var="item" items="${cart.accessories}">
                    <div class="flex items-center gap-4 bg-white dark:bg-primary/5 p-3 rounded-xl border border-primary/5 shadow-sm">
                        <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-lg size-20 shrink-0"
                             style='background-image: url("${item.imageURL}");'></div>
                        <div class="flex flex-col flex-1 min-w-0">
                            <p class="text-slate-900 dark:text-slate-100 font-display font-medium text-base leading-tight truncate">${item.name}</p>
                            <p class="text-primary/70 text-sm font-normal mb-2">Qtd ${item.quantity}</p>
                            <p class="text-primary font-bold">
                                R$ <fmt:formatNumber value="${item.price * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${not empty cart.gifts and cart.gifts[0].applied}">
                    <div class="flex items-center gap-4 bg-white dark:bg-primary/5 p-3 rounded-xl border border-dashed border-primary/20 shadow-sm">
                        <div class="rounded-lg size-20 shrink-0 bg-primary/5 flex items-center justify-center text-primary">
                            <span class="material-symbols-outlined text-3xl">redeem</span>
                        </div>
                        <div class="flex flex-col flex-1 min-w-0">
                            <p class="text-slate-900 dark:text-slate-100 font-display font-medium text-base leading-tight">Embalagem para presente</p>
                            <p class="text-primary/70 text-sm font-normal mb-2 truncate">${cart.gifts[0].letterText}</p>
                            <p class="text-primary font-bold">
                                R$ <fmt:formatNumber value="${giftTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <section class="bg-white dark:bg-background-dark border border-primary/10 rounded-xl p-6 shadow-sm">
            <div class="flex justify-between items-end">
                <div class="space-y-2">
                    <p class="text-xs text-slate-500 uppercase font-bold tracking-widest">Total do Pedido</p>
                    <div class="space-y-1 text-sm text-slate-500">
                        <div class="flex items-center gap-2">
                            <span>Subtotal</span>
                            <strong class="text-primary">R$ <fmt:formatNumber value="${cartSubtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong>
                        </div>
                        <div class="flex items-center gap-2">
                            <span>Presente</span>
                            <strong class="text-primary">R$ <fmt:formatNumber value="${giftTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong>
                        </div>
                    </div>
                    <span class="text-2xl font-display font-bold text-primary">
                        R$ <fmt:formatNumber value="${cartTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
                <div class="text-right">
                    <p class="text-[10px] text-green-600 font-bold uppercase">Frete Grátis Ativado</p>
                </div>
            </div>
            <button type="submit"
                    class="mt-5 w-full bg-primary hover:bg-primary/90 text-white font-display font-bold py-4 rounded-xl text-lg shadow-xl shadow-primary/20 flex items-center justify-center gap-3 transition-colors">
                Continuar para Pagamento
                <span class="material-symbols-outlined">arrow_forward</span>
            </button>
        </section>

        <section class="flex flex-col items-center gap-4 py-4 text-primary/60 border-t border-primary/10">
            <div class="flex items-center gap-6">
                <div class="flex flex-col items-center gap-1">
                    <span class="material-symbols-outlined text-2xl">shield_lock</span>
                    <span class="text-[10px] uppercase font-bold tracking-tighter">Compra Segura</span>
                </div>
                <div class="flex flex-col items-center gap-1">
                    <span class="material-symbols-outlined text-2xl">verified</span>
                    <span class="text-[10px] uppercase font-bold tracking-tighter">Originalidade</span>
                </div>
                <div class="flex flex-col items-center gap-1">
                    <span class="material-symbols-outlined text-2xl">local_shipping</span>
                    <span class="text-[10px] uppercase font-bold tracking-tighter">Entrega Expressa</span>
                </div>
            </div>
        </section>
    </main>
</form>

<%@ include file="./snippets/bottom-nav.jsp"%>
<script>
        document.getElementById('deliveryPhone').addEventListener('input', function(e) {
            let v = e.target.value.replace(/\D/g, '');
            if (v.length > 11) v = v.slice(0, 11);
            v = v.replace(/^(\d{2})(\d)/g, '($1) $2');
            v = v.replace(/(\d{5})(\d)/, '$1-$2');
            e.target.value = v;
            });
    </script>
</body>
</html>
