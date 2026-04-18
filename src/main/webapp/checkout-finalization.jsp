<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="pt-br">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Vinheria Agnello - Finalização</title>
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
        <c:choose>
            <c:when test="${checkoutPreviewConfirmed}">
                <a href="${pageContext.request.contextPath}/controller?action=ShowIndex"
                   class="w-10 h-10 flex items-center justify-center rounded-full text-primary hover:bg-primary/5 transition-colors">
                    <span class="material-symbols-outlined">arrow_back</span>
                </a>
            </c:when>
            <c:otherwise>
                <button class="w-10 h-10 flex items-center justify-center rounded-full text-primary hover:bg-primary/5 transition-colors"
                        onclick="window.history.back()"
                        type="button">
                    <span class="material-symbols-outlined">arrow_back</span>
                </button>
            </c:otherwise>
        </c:choose>
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
            <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center">
                <span class="material-symbols-outlined text-sm">check</span>
            </div>
            <span class="text-xs font-medium text-primary uppercase tracking-wider">Entrega</span>
        </div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark pl-4">
            <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center text-sm font-bold">3</div>
            <span class="text-xs font-medium text-primary uppercase tracking-wider">Pagamento</span>
        </div>
    </div>
</nav>

<form action="${pageContext.request.contextPath}/controller?action=ShowCheckoutFinalize" method="post">
    <input type="hidden" name="deliveryName" value="${deliveryName}"/>
    <input type="hidden" name="deliveryEmail" value="${deliveryEmail}"/>
    <input type="hidden" name="deliveryPhone" value="${deliveryPhone}"/>
    <input type="hidden" name="deliveryCep" value="${deliveryCep}"/>
    <input type="hidden" name="deliveryStreet" value="${deliveryStreet}"/>
    <input type="hidden" name="deliveryNumber" value="${deliveryNumber}"/>
    <input type="hidden" name="deliveryComplement" value="${deliveryComplement}"/>
    <input type="hidden" name="deliveryNeighborhood" value="${deliveryNeighborhood}"/>
    <input type="hidden" name="deliveryCity" value="${deliveryCity}"/>
    <input type="hidden" name="deliveryState" value="${deliveryState}"/>
    <input type="hidden" name="deliveryReference" value="${deliveryReference}"/>
    <input type="hidden" name="shippingMethod" value="${shippingMethod}"/>

    <main class="max-w-2xl mx-auto px-4 space-y-8 pb-10">
        <c:set var="summaryCart" value="${orderSummaryCart}" />
        <c:if test="${checkoutPreviewConfirmed}">
            <section class="rounded-xl border border-green-200 bg-green-50 px-5 py-4 text-green-900">
                <div class="flex items-start gap-3">
                    <span class="material-symbols-outlined text-green-700 mt-0.5">check_circle</span>
                    <div>
                        <p class="font-bold">Compra finalizada com sucesso.</p>
                        <p class="text-sm mt-1">
                            Seu pedido foi confirmado e já seguiu para separação.
                        </p>
                    </div>
                </div>
            </section>
        </c:if>

        <section>
            <div class="flex items-center justify-between gap-4 mb-4">
                <h2 class="text-lg font-bold flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary">location_on</span>
                    Entrega Confirmada
                </h2>
                <button type="submit"
                        formaction="${pageContext.request.contextPath}/controller?action=ShowCheckoutAddress"
                        formmethod="post"
                        formnovalidate
                        class="inline-flex items-center gap-2 rounded-full border border-primary/15 px-4 py-2 text-sm font-semibold text-primary hover:bg-primary/5">
                    <span class="material-symbols-outlined text-base">edit_square</span>
                    Editar
                </button>
            </div>

            <div class="bg-white dark:bg-primary/5 p-6 rounded-xl border border-primary/10 shadow-sm space-y-4">
                <div class="grid sm:grid-cols-2 gap-4">
                    <div class="rounded-lg bg-background-light dark:bg-background-dark p-4">
                        <p class="text-xs font-bold uppercase tracking-widest text-primary mb-2">Destinatário</p>
                        <p class="font-display font-bold text-primary">${deliveryName}</p>
                        <p class="text-sm text-slate-600 dark:text-slate-300 mt-2">${deliveryPhone}</p>
                        <p class="text-sm text-slate-600 dark:text-slate-300">${deliveryEmail}</p>
                    </div>
                    <div class="rounded-lg bg-background-light dark:bg-background-dark p-4">
                        <p class="text-xs font-bold uppercase tracking-widest text-primary mb-2">Endereço</p>
                        <p class="font-display font-bold text-primary">${deliveryStreet}, ${deliveryNumber}</p>
                        <p class="text-sm text-slate-600 dark:text-slate-300 mt-2">${deliveryNeighborhood} - ${deliveryCity}/${deliveryState}</p>
                        <p class="text-sm text-slate-600 dark:text-slate-300">CEP ${deliveryCep}</p>
                        <c:if test="${not empty deliveryComplement}">
                            <p class="text-sm text-slate-600 dark:text-slate-300">${deliveryComplement}</p>
                        </c:if>
                    </div>
                </div>

                <div class="rounded-lg border border-primary/10 bg-primary/5 p-4 flex items-center justify-between gap-4">
                    <div>
                        <p class="text-xs font-bold uppercase tracking-widest text-primary mb-1">Modalidade</p>
                        <p class="text-sm font-semibold text-primary">
                            <c:choose>
                                <c:when test="${shippingMethod == 'scheduled'}">Janela agendada</c:when>
                                <c:when test="${shippingMethod == 'cellar'}">Rota climatizada premium</c:when>
                                <c:otherwise>Entrega expressa Agnello</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="text-right">
                        <p class="text-xs text-green-700 font-bold uppercase">Frete grátis</p>
                        <p class="text-sm text-slate-600">
                            <c:choose>
                                <c:when test="${shippingMethod == 'scheduled'}">Amanhã</c:when>
                                <c:when test="${shippingMethod == 'cellar'}">48h</c:when>
                                <c:otherwise>Hoje / 24h</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <c:if test="${not empty deliveryReference}">
                    <div class="rounded-lg border border-dashed border-primary/20 p-4">
                        <p class="text-xs font-bold uppercase tracking-widest text-primary mb-2">Ponto de Referência</p>
                        <p class="text-sm text-slate-600 dark:text-slate-300">${deliveryReference}</p>
                    </div>
                </c:if>
            </div>
        </section>

        <section>
            <h2 class="text-lg font-bold mb-4 flex items-center gap-2">
                <span class="material-symbols-outlined text-primary">shopping_bag</span>
                Resumo do Pedido
            </h2>
            <div class="space-y-3">
                <c:forEach var="item" items="${summaryCart.wines}">
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

                <c:forEach var="item" items="${summaryCart.accessories}">
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

                <c:if test="${not empty summaryCart.gifts and summaryCart.gifts[0].applied}">
                    <div class="flex items-center gap-4 bg-white dark:bg-primary/5 p-3 rounded-xl border border-dashed border-primary/20 shadow-sm">
                        <div class="rounded-lg size-20 shrink-0 bg-primary/5 flex items-center justify-center text-primary">
                            <span class="material-symbols-outlined text-3xl">redeem</span>
                        </div>
                        <div class="flex flex-col flex-1 min-w-0">
                            <p class="text-slate-900 dark:text-slate-100 font-display font-medium text-base leading-tight">Embalagem para presente</p>
                            <p class="text-primary/70 text-sm font-normal mb-2 truncate">${summaryCart.gifts[0].letterText}</p>
                            <p class="text-primary font-bold">
                                R$ <fmt:formatNumber value="${orderSummaryGiftTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <c:if test="${not checkoutPreviewConfirmed}">
            <section class="bg-white dark:bg-primary/5 p-6 rounded-xl border-2 border-dashed border-primary/20">
                <h2 class="text-lg font-display font-bold text-primary mb-2">Forma de Pagamento</h2>
                <p class="text-sm text-slate-600 dark:text-slate-300 mb-6">
                    Escolha como deseja pagar e preencha os dados abaixo para concluir a compra.
                </p>
                <div class="space-y-3">
                    <label class="cursor-pointer block">
                        <input type="radio" name="paymentMethod" value="pix" class="peer sr-only" data-payment-method="pix" <c:if test="${paymentMethod == 'pix'}">checked="checked"</c:if> />
                        <span class="flex items-center gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 transition-all peer-checked:border-primary peer-checked:bg-primary peer-checked:text-white">
                            <span class="material-symbols-outlined">qr_code_2</span>
                            <span class="flex-1">
                                <span class="block font-bold text-sm">Pix imediato</span>
                                <span class="block text-xs opacity-80 mt-1">Confirmação rápida para despacho prioritário.</span>
                            </span>
                        </span>
                    </label>
                    <label class="cursor-pointer block">
                        <input type="radio" name="paymentMethod" value="card" class="peer sr-only" data-payment-method="card" <c:if test="${paymentMethod == 'card'}">checked="checked"</c:if> />
                        <span class="flex items-center gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 transition-all peer-checked:border-primary peer-checked:bg-primary peer-checked:text-white">
                            <span class="material-symbols-outlined">credit_card</span>
                            <span class="flex-1">
                                <span class="block font-bold text-sm">Cartão de crédito</span>
                                <span class="block text-xs opacity-80 mt-1">Pagamento com dados do cartão e opção de parcelamento.</span>
                            </span>
                        </span>
                    </label>
                    <label class="cursor-pointer block">
                        <input type="radio" name="paymentMethod" value="boleto" class="peer sr-only" data-payment-method="boleto" <c:if test="${paymentMethod == 'boleto'}">checked="checked"</c:if> />
                        <span class="flex items-center gap-4 rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 transition-all peer-checked:border-primary peer-checked:bg-primary peer-checked:text-white">
                            <span class="material-symbols-outlined">receipt_long</span>
                            <span class="flex-1">
                                <span class="block font-bold text-sm">Boleto bancário</span>
                                <span class="block text-xs opacity-80 mt-1">Pagamento tradicional com compensação posterior.</span>
                            </span>
                        </span>
                    </label>
                </div>

                <div class="mt-6 space-y-4">
                    <div class="rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4" data-payment-panel="pix">
                        <div class="flex items-start gap-3">
                            <span class="material-symbols-outlined text-primary mt-0.5">bolt</span>
                            <div>
                                <p class="font-bold text-primary">Pix para confirmação imediata</p>
                                <p class="text-sm text-slate-600 dark:text-slate-300 mt-1">
                                    Após finalizar, o QR Code e a chave copia e cola apareceriam aqui para o pagamento.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 hidden" data-payment-panel="card">
                        <div class="rounded-2xl bg-gradient-to-br from-primary via-primary to-[#6f2a22] p-5 text-white shadow-lg shadow-primary/20">
                            <div class="flex items-center justify-between">
                                <span class="text-xs uppercase tracking-[0.3em] text-white/70">Cartão</span>
                                <span class="material-symbols-outlined">credit_card</span>
                            </div>
                            <p class="mt-8 text-xl sm:text-2xl font-semibold tracking-[0.2em]" data-card-preview-number>0000 0000 0000 0000</p>
                            <div class="mt-6 flex items-end justify-between gap-4">
                                <div>
                                    <p class="text-[10px] uppercase tracking-[0.3em] text-white/60">Nome no cartão</p>
                                    <p class="mt-1 text-sm font-semibold uppercase" data-card-preview-name>SEU NOME</p>
                                </div>
                                <div class="text-right">
                                    <p class="text-[10px] uppercase tracking-[0.3em] text-white/60">Validade</p>
                                    <p class="mt-1 text-sm font-semibold" data-card-preview-expiry>MM/AA</p>
                                </div>
                            </div>
                        </div>

                        <div class="grid gap-4 mt-5 sm:grid-cols-2">
                            <label class="block sm:col-span-2">
                                <span class="block text-xs font-bold uppercase tracking-widest text-primary mb-2">Nome no cartão</span>
                                <input type="text"
                                       name="cardHolderName"
                                       value="${cardHolderName}"
                                       data-card-input="name"
                                       data-card-field
                                       autocomplete="cc-name"
                                       placeholder="Como está impresso no cartão"
                                       class="w-full rounded-xl border border-primary/15 bg-white px-4 py-3 text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-primary/20"/>
                            </label>

                            <label class="block sm:col-span-2">
                                <span class="block text-xs font-bold uppercase tracking-widest text-primary mb-2">Número do cartão</span>
                                <input type="text"
                                       name="cardNumber"
                                       value="${cardNumber}"
                                       data-card-input="number"
                                       data-card-field
                                       autocomplete="cc-number"
                                       inputmode="numeric"
                                       maxlength="19"
                                       placeholder="0000 0000 0000 0000"
                                       class="w-full rounded-xl border border-primary/15 bg-white px-4 py-3 text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-primary/20"/>
                            </label>

                            <label class="block">
                                <span class="block text-xs font-bold uppercase tracking-widest text-primary mb-2">Validade</span>
                                <input type="text"
                                       name="cardExpiry"
                                       value="${cardExpiry}"
                                       data-card-input="expiry"
                                       data-card-field
                                       autocomplete="cc-exp"
                                       inputmode="numeric"
                                       maxlength="5"
                                       placeholder="MM/AA"
                                       class="w-full rounded-xl border border-primary/15 bg-white px-4 py-3 text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-primary/20"/>
                            </label>

                            <label class="block">
                                <span class="block text-xs font-bold uppercase tracking-widest text-primary mb-2">CVV</span>
                                <input type="text"
                                       name="cardCvv"
                                       value="${cardCvv}"
                                       data-card-field
                                       autocomplete="cc-csc"
                                       inputmode="numeric"
                                       maxlength="4"
                                       placeholder="123"
                                       class="w-full rounded-xl border border-primary/15 bg-white px-4 py-3 text-sm text-slate-900 placeholder:text-slate-400 focus:border-primary focus:ring-primary/20"/>
                            </label>

                            <label class="block sm:col-span-2">
                                <span class="block text-xs font-bold uppercase tracking-widest text-primary mb-2">Parcelamento</span>
                                <select name="cardInstallments"
                                        data-card-field
                                        class="w-full rounded-xl border border-primary/15 bg-white px-4 py-3 text-sm text-slate-900 focus:border-primary focus:ring-primary/20">
                                    <option value="1" <c:if test="${cardInstallments == '1'}">selected="selected"</c:if>>1x sem juros</option>
                                    <option value="2" <c:if test="${cardInstallments == '2'}">selected="selected"</c:if>>2x sem juros</option>
                                    <option value="3" <c:if test="${cardInstallments == '3'}">selected="selected"</c:if>>3x sem juros</option>
                                    <option value="4" <c:if test="${cardInstallments == '4'}">selected="selected"</c:if>>4x sem juros</option>
                                </select>
                            </label>
                        </div>
                    </div>

                    <div class="rounded-xl border border-primary/10 bg-background-light dark:bg-background-dark p-4 hidden" data-payment-panel="boleto">
                        <div class="flex items-start gap-3">
                            <span class="material-symbols-outlined text-primary mt-0.5">description</span>
                            <div>
                                <p class="font-bold text-primary">Boleto gerado após a confirmação</p>
                                <p class="text-sm text-slate-600 dark:text-slate-300 mt-1">
                                    Assim que a compra for concluída, o boleto ficaria disponível com vencimento e linha digitável.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="bg-white dark:bg-background-dark border border-primary/10 rounded-xl p-6 shadow-sm">
                <div class="flex justify-between items-end">
                    <div class="space-y-2">
                        <p class="text-xs text-slate-500 uppercase font-bold tracking-widest">Fechamento do Pedido</p>
                        <div class="space-y-1 text-sm text-slate-500">
                            <div class="flex items-center gap-2">
                                <span>Subtotal</span>
                                <strong class="text-primary">R$ <fmt:formatNumber value="${cartSubtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong>
                            </div>
                            <div class="flex items-center gap-2">
                                <span>Presente</span>
                                <strong class="text-primary">R$ <fmt:formatNumber value="${giftTotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong>
                            </div>
                            <div class="flex items-center gap-2">
                                <span>Pagamento</span>
                                <strong class="text-primary">
                                    <c:choose>
                                        <c:when test="${paymentMethod == 'card'}">Cartão</c:when>
                                        <c:when test="${paymentMethod == 'boleto'}">Boleto</c:when>
                                        <c:otherwise>Pix</c:otherwise>
                                    </c:choose>
                                </strong>
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
                        name="simulateConfirm"
                        value="true"
                        class="mt-5 w-full bg-primary hover:bg-primary/90 text-white font-display font-bold py-4 rounded-xl text-lg shadow-xl shadow-primary/20 flex items-center justify-center gap-3 transition-colors">
                    Finalizar compra
                    <span class="material-symbols-outlined">check_circle</span>
                </button>
            </section>
        </c:if>

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
    (() => {
        const paymentMethods = Array.from(document.querySelectorAll('[data-payment-method]'));
        const paymentPanels = Array.from(document.querySelectorAll('[data-payment-panel]'));
        const cardFields = Array.from(document.querySelectorAll('[data-card-field]'));
        const cardNameInput = document.querySelector('[data-card-input="name"]');
        const cardNumberInput = document.querySelector('[data-card-input="number"]');
        const cardExpiryInput = document.querySelector('[data-card-input="expiry"]');
        const previewName = document.querySelector('[data-card-preview-name]');
        const previewNumber = document.querySelector('[data-card-preview-number]');
        const previewExpiry = document.querySelector('[data-card-preview-expiry]');

        const digitsOnly = (value) => value.replace(/\D/g, '');

        const formatCardNumber = (value) => digitsOnly(value).slice(0, 16).replace(/(\d{4})(?=\d)/g, '$1 ').trim();
        const formatExpiry = (value) => {
            const digits = digitsOnly(value).slice(0, 4);
            if (digits.length <= 2) return digits;
            return digits.slice(0, 2) + '/' + digits.slice(2);
        };

        const updateCardPreview = () => {
            if (previewName && cardNameInput) {
                previewName.textContent = cardNameInput.value.trim() || 'SEU NOME';
            }

            if (previewNumber && cardNumberInput) {
                previewNumber.textContent = cardNumberInput.value.trim() || '0000 0000 0000 0000';
            }

            if (previewExpiry && cardExpiryInput) {
                previewExpiry.textContent = cardExpiryInput.value.trim() || 'MM/AA';
            }
        };

        const syncPaymentPanels = () => {
            const selected = paymentMethods.find((input) => input.checked)?.value || 'pix';

            paymentPanels.forEach((panel) => {
                const isActive = panel.dataset.paymentPanel === selected;
                panel.classList.toggle('hidden', !isActive);
            });

            cardFields.forEach((field) => {
                const isCardActive = selected === 'card';
                field.disabled = !isCardActive;
                if (field.tagName === 'INPUT') {
                    field.required = isCardActive;
                }
            });
        };

        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', () => {
                cardNumberInput.value = formatCardNumber(cardNumberInput.value);
                updateCardPreview();
            });
        }

        if (cardExpiryInput) {
            cardExpiryInput.addEventListener('input', () => {
                cardExpiryInput.value = formatExpiry(cardExpiryInput.value);
                updateCardPreview();
            });
        }

        const cardCvvInput = document.querySelector('input[name="cardCvv"]');
        if (cardCvvInput) {
            cardCvvInput.addEventListener('input', () => {
                cardCvvInput.value = digitsOnly(cardCvvInput.value).slice(0, 4);
            });
        }

        if (cardNameInput) {
            cardNameInput.addEventListener('input', updateCardPreview);
        }

        paymentMethods.forEach((input) => input.addEventListener('change', syncPaymentPanels));

        updateCardPreview();
        syncPaymentPanels();
    })();
</script>
</body>
</html>
