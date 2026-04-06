<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html class="light" lang="pt-br">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Vinheria Agnello - Meu Carrinho</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&amp;family=Noto+Sans:wght@400;500;600&amp;display=swap"
          rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
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
    <style>
        body {
            min-height: max(884px, 100dvh);
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen pb-32">
<!-- Header / Navigation -->
<header class="sticky top-0 z-50 bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-sm border-b border-primary/10 px-4 py-4">
    <div class="max-w-2xl mx-auto flex items-center justify-between">
        <button class="flex items-center text-primary">
            <span class="material-symbols-outlined">arrow_back</span>
        </button>
        <h1 class="text-xl font-bold text-primary tracking-tight">Vinheria Agnello</h1>
        <div class="w-6"></div> <!-- Spacer for balance -->
    </div>
</header>
<!-- Checkout Steps Progress -->
<nav class="max-w-2xl mx-auto px-6 py-6">
    <div class="flex items-center justify-between relative">
        <div class="absolute top-1/2 left-0 w-full h-px bg-primary/20 -translate-y-1/2 -z-10"></div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark pr-4">
            <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center text-sm font-bold">
                1
            </div>
            <span class="text-xs font-medium text-primary uppercase tracking-wider">Carrinho</span>
        </div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark px-4">
            <div class="w-8 h-8 rounded-full border border-primary/30 text-primary/50 flex items-center justify-center text-sm font-bold">
                2
            </div>
            <span class="text-xs font-medium text-primary/40 uppercase tracking-wider">Entrega</span>
        </div>
        <div class="flex flex-col items-center gap-2 bg-background-light dark:bg-background-dark pl-4">
            <div class="w-8 h-8 rounded-full border border-primary/30 text-primary/50 flex items-center justify-center text-sm font-bold">
                3
            </div>
            <span class="text-xs font-medium text-primary/40 uppercase tracking-wider">Pagamento</span>
        </div>
    </div>
</nav>
<main class="max-w-2xl mx-auto px-4 space-y-8">
    <!-- Cart Items Section -->
    <section>
        <h2 class="text-lg font-bold mb-4 flex items-center gap-2">
            <span class="material-symbols-outlined text-primary">shopping_bag</span>
            Itens Selecionados
        </h2>
        <div class="space-y-3">
            <c:forEach var="item" items="${cartItems}">
                <div class="flex items-center gap-4 bg-white dark:bg-primary/5 p-3 rounded-xl border border-primary/5 shadow-sm">
                    <div class="bg-center bg-no-repeat aspect-square bg-cover rounded-lg size-20 shrink-0"
                         data-alt="Garrafa de vinho tinto Brunello di Montalcino"
                         style='background-image: url("${item.wine.imageURL}");'></div>
                    <div class="flex flex-col flex-1 min-w-0">
                        <p class="text-slate-900 dark:text-slate-100 font-display font-medium text-base leading-tight line-clamp-1">
                            ${item.wine.name}</p>
                        <p class="text-primary/70 text-sm font-normal mb-2">${item.wine.region}, ${item.wine.country}</p>
                        <div class="flex items-center justify-between">
                            <p class="text-primary font-bold">
                                R$ <fmt:formatNumber value="${item.wine.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                            <div class="flex items-center gap-3 bg-primary/5 rounded-full px-2 py-1">
                                <button onclick="(${item.wine.id})" class="text-primary hover:bg-primary/10 rounded-full w-6 h-6 flex items-center justify-center">
                                    -
                                </button>
                                <span class="text-sm font-bold w-4 text-center">${item.quantity}</span>
                                <button  onclick="(${item.wine.id})" class="text-primary hover:bg-primary/10 rounded-full w-6 h-6 flex items-center justify-center">
                                    +
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
    <!-- Upsell Section -->
    <section class="bg-primary/5 -mx-4 px-4 py-8">
        <div class="max-w-2xl mx-auto">
            <h2 class="text-lg font-display italic text-primary mb-4">Que tal incluir uma taça especial?</h2>
            <div class="flex gap-4 overflow-x-auto no-scrollbar pb-2">
                <!-- Accessory 1 -->
                <div class="bg-white dark:bg-background-dark p-3 rounded-xl border border-primary/10 shrink-0 w-48 shadow-sm">
                    <div class="bg-center bg-no-repeat aspect-[4/5] bg-cover rounded-lg mb-3"
                         data-alt="Taça de cristal Riedel para vinhos tintos"
                         style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuBUvJn35OtrrMTwEDR2AsKEQlCa4-KyLDZXe5pUHfFbi8CggEJEapjRBUpLwTRIq_vt2rs2ofFqHjuRnWjKeD5LOmi4582D4XSKFhL8H1aXrqeV74du3z0ZakxyD213xaa752LA-Fu5IuuQlzF3QZY3A25adkdV3zFTsV9tXv0JdFjE7mYV1wAPNRlLrmeIavchmAWQNKxgyIAuDCiu_zJVCXpbLeFxYlB55kPq51soSjqbmQzsG5UZ2Q2ALtmOicJJuzceTvVuQ5Vm");'></div>
                    <p class="font-display text-sm font-medium mb-1 line-clamp-1">Taça Riedel Crystal</p>
                    <p class="text-primary font-bold text-sm mb-3">

                    </p>
                    <button class="w-full py-2 bg-primary text-white text-xs font-bold rounded-lg uppercase tracking-widest">
                        Adicionar
                    </button>
                </div>
                <!-- Accessory 2 -->
                <div class="bg-white dark:bg-background-dark p-3 rounded-xl border border-primary/10 shrink-0 w-48 shadow-sm">
                    <div class="bg-center bg-no-repeat aspect-[4/5] bg-cover rounded-lg mb-3"
                         data-alt="Saca-rolhas profissional em madeira e metal"
                         style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDoXZHUjuCMLqz31K88WObuEelKe-JZ_snF_MyROLSj2yg5UJt9D42LgHJy7lym3ZE4Q43v7hBxS89LqCdRMud3B77ztIcCuI025-ViOGLy6MDpjLiqo1YYPTL9qzdWH6JYfyVP3ZSeQs4Vr56OdVArPW6P0Sis6c7enX7833yb83DAuOoEl2YsknKtQEtwzOEN1DKqcB_jbace97wxHEjpF7VdqZWebXKgaM68Bn5o8a9n_U7MkLM-kS6OyRNJwcPHZ91XJPt7lIlO");'></div>
                    <p class="font-display text-sm font-medium mb-1 line-clamp-1">Saca-rolhas Sommelier</p>
                    <p class="text-primary font-bold text-sm mb-3">R$ 89,00</p>
                    <button class="w-full py-2 bg-primary text-white text-xs font-bold rounded-lg uppercase tracking-widest">
                        Adicionar
                    </button>
                </div>
                <!-- Accessory 3 -->
                <div class="bg-white dark:bg-background-dark p-3 rounded-xl border border-primary/10 shrink-0 w-48 shadow-sm">
                    <div class="bg-center bg-no-repeat aspect-[4/5] bg-cover rounded-lg mb-3"
                         data-alt="Decanter de cristal aerador para vinhos"
                         style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuCsCTQqp3PlE7dWUCTFxZGuBr2IZfzKa8uZR43rw8pGVqgHXmLZV882YCRQNJeG6tS0AR6tv2gr7q617B9IuJhHwsykccQEwYGeNVHY1A7nSnvm3ATB4vtZgbnnTljKwfgNjzPN6YodJueipJ_JV07w3-ptjDNtZ84Oi4CE1tyZ0jjt59yXCmKmxFuOf8pjvtBD6UID40hpV0eDOxJw6Yu_NQ0Ws_VXXGdbFTJSW22ZPranslj9-3vyCnNCJWIrj4Nr62DLLVKdmq-k");'></div>
                    <p class="font-display text-sm font-medium mb-1 line-clamp-1">Decanter Aerador</p>
                    <p class="text-primary font-bold text-sm mb-3">R$ 210,00</p>
                    <button class="w-full py-2 bg-primary text-white text-xs font-bold rounded-lg uppercase tracking-widest">
                        Adicionar
                    </button>
                </div>
            </div>
        </div>
    </section>
    <!-- Gifting Section -->
    <section class="bg-white dark:bg-primary/5 p-6 rounded-xl border-2 border-dashed border-primary/20">
        <div class="flex items-start gap-4">
            <div class="flex items-center h-6">
                <input checked=""
                       class="h-5 w-5 rounded border-primary/30 text-primary focus:ring-primary cursor-pointer"
                       id="is_gift" type="checkbox"/>
            </div>
            <div class="flex-1">
                <label class="text-base font-display font-bold text-primary cursor-pointer" for="is_gift">É um
                    presente?</label>
                <p class="text-sm text-slate-600 dark:text-slate-400 mt-1">Adicione embalagem especial e uma mensagem
                    escrita à mão por nossa equipe.</p>
                <div class="mt-6 space-y-4">
                    <div>
                        <label class="block text-xs font-bold text-primary uppercase tracking-widest mb-2">Mensagem do
                            Cartão</label>
                        <textarea
                                class="w-full bg-background-light dark:bg-background-dark border-primary/10 rounded-lg p-3 text-sm focus:ring-primary focus:border-primary placeholder:italic"
                                placeholder="Escreva sua mensagem aqui..." rows="3"></textarea>
                    </div>
                    <div class="flex items-center gap-4 p-3 bg-primary/5 rounded-lg border border-primary/10">
                        <div class="bg-center bg-no-repeat aspect-square bg-cover rounded size-12"
                             data-alt="Embalagem de presente luxuosa bordô"
                             style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDBNe8NF2u_QdG7hwhw2RdE08GAjFjmC0D2dBYkCHWfLQuuZiQ2sHJseF_UORLbJe6ZCM4t_Yw74DSyPAtE-k2IxpcXDkAIwX7lmcPUuj5Zp-xqt9sDgKO4I2Vuda20_hpv_Mh0LmD6FUWwB2aCndfFd7zGhvDzv3nJKp5qnn0cpbVTK1YSKMPcxlSN6kQdfydihvM1ZtE5o6wVf5J5QRkoI41Klgn5DOVLdgwIxDJ15JSqVkJuQsCIhU3uII1YCwP6i3zH3a1nswhh");'></div>
                        <div class="text-sm">
                            <p class="font-bold">Embalagem Premium</p>
                            <p class="text-xs text-primary/70">+ R$ 25,00</p>
                        </div>
                        <span class="material-symbols-outlined ml-auto text-green-600">check_circle</span>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Trust Signals -->
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
<!-- Sticky Footer Summary -->
<footer class="fixed bottom-0 left-0 w-full bg-white dark:bg-background-dark border-t border-primary/10 px-4 py-6 z-50">
    <div class="max-w-2xl mx-auto space-y-4">
        <div class="flex justify-between items-end">
            <div class="space-y-1">
                <p class="text-xs text-slate-500 uppercase font-bold tracking-widest">Total do Carrinho</p>
                <c:set var="totalCart" value="0" />

                <c:forEach var="item" items="${cartItems}">
                    <c:set var="totalCart" value="${totalCart + (item.wine.price * item.quantity)}" />
                </c:forEach>
                <div class="flex items-baseline gap-2">
                    <span class="text-2xl font-display font-bold text-primary">
                        R$ <fmt:formatNumber value="${totalCart}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                    <span class="text-xs text-slate-400 line-through">
                        R$ <fmt:formatNumber value="${totalCart*1.10}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
            </div>
            <div class="text-right">
                <p class="text-[10px] text-green-600 font-bold uppercase">Frete Grátis Ativado</p>
            </div>
        </div>
        <button class="w-full bg-primary hover:bg-primary/90 text-white font-display font-bold py-4 rounded-xl text-lg shadow-xl shadow-primary/20 flex items-center justify-center gap-3 transition-colors">
            Finalizar Compra
            <span class="material-symbols-outlined">arrow_forward</span>
        </button>
    </div>
</footer>
<!-- Bottom Nav Bar (Optional Component Logic) -->
<div class="fixed bottom-0 left-0 w-full flex gap-2 border-t border-primary/5 bg-background-light dark:bg-background-dark px-4 pb-3 pt-2 hidden">
    <a class="flex flex-1 flex-col items-center justify-end gap-1 text-primary/60" href="#">
        <span class="material-symbols-outlined">wine_bar</span>
        <p class="text-xs font-medium leading-normal tracking-tight">Vinhos</p>
    </a>
    <a class="flex flex-1 flex-col items-center justify-end gap-1 text-primary" href="#">
        <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1">shopping_bag</span>
        <p class="text-xs font-medium leading-normal tracking-tight">Carrinho</p>
    </a>
    <a class="flex flex-1 flex-col items-center justify-end gap-1 text-primary/60" href="#">
        <span class="material-symbols-outlined">person</span>
        <p class="text-xs font-medium leading-normal tracking-tight">Perfil</p>
    </a>
</div>
</body>
</html>