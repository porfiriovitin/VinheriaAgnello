<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html lang="pt-br">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <%@ include file="./snippets/favicon.jsp" %>
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
                        "accent-gold": "#C5A059",
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
    <title>Vinheria Agnello | Premium Wine E-commerce</title>
    <style>
        body {
            min-height: max(884px, 100dvh);
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-sans text-slate-900 dark:text-slate-100">
<!-- Header Navigation -->
<header class="sticky top-0 z-50 bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-md border-b border-primary/10 px-4 py-3 flex items-center justify-between">
    <button id="open-menu-btn" aria-label="Abrir menu" class="p-2 text-primary dark:text-slate-100">
        <span class="material-symbols-outlined text-3xl">menu</span>
    </button>
    <div class="text-center">
        <h1 class="font-display text-2xl font-bold tracking-tighter text-primary dark:text-slate-100">VINHERIA
            AGNELLO</h1>
        <p class="text-[10px] uppercase tracking-[0.2em] text-accent-gold font-bold">Dal 1994</p>
    </div>
    <div class="flex items-center gap-2">
        <a href="${pageContext.request.contextPath}/controller?action=ShowCartCheckout" class="p-2 text-primary dark:text-slate-100 relative">
            <span class="material-symbols-outlined text-2xl">shopping_bag</span>
            <!--
            <span class="absolute top-1 right-1 bg-accent-gold text-white text-[10px] font-bold rounded-full w-4 h-4 flex items-center justify-center"></span>
            -->
        </a>
    </div>
</header>
<main class="max-w-md mx-auto pb-24">
    <!-- Hero Storytelling Section -->
    <section class="relative h-[500px] w-full overflow-hidden">
        <div class="absolute inset-0 bg-cover bg-center" data-alt="Atmospheric dark wine cellar with wooden barrels"
             style="background-image: linear-gradient(to bottom, rgba(73, 14, 14, 0.4), rgba(32, 18, 18, 0.8)), url('https://lh3.googleusercontent.com/aida-public/AB6AXuD4o1SXh_8ZS-PgI-zajxJDltM8IJLGcDOGnQpwwhTmdgp7GUi3XvkIHXlESeebJYKhNR0mn1Dy75OOAoNCXQyeMaIMOc0lzGOl-csEes2z91i6tQcWPWeM2pvHS_zxLQe0lJyMdgN5y70jDMulMDNMKv8Vi7jtfi8AjQEqRQdjDV0JRdBCPFSgcon8CcgLulUTdOhfmr4bEXgwov52n8roHVxsIS0czq111Y3xYBHUNqX7sVQ-MDRN3pmipyJpypDQ0VjbwdeJ-hEm');"></div>
        <div class="relative h-full flex flex-col items-center justify-center px-8 text-center">
            <span class="text-accent-gold font-display italic text-lg mb-2">Tradição &amp; Excelência</span>
            <h2 class="text-white font-display text-4xl font-bold leading-tight mb-6">Há 30 anos selecionando vinhos com
                paixão</h2>
            <div class="w-12 h-[2px] bg-accent-gold mb-6"></div>
            <a href="${pageContext.request.contextPath}/controller?action=ShowCatalog"
               class="bg-primary hover:bg-primary/90 text-white px-8 py-3 rounded-lg font-display tracking-wide border border-accent-gold/30 transition-all inline-flex items-center justify-center">
                Explorar Coleção
            </a>
        </div>
    </section>
    <!-- Interactive Wine Finder CTA -->
    <!--
    <section class="px-4 -mt-12 relative z-10">
        <div class="bg-white dark:bg-slate-800 rounded-xl shadow-xl p-6 border border-primary/5">
            <div class="flex items-center gap-4 mb-3">
                <div class="bg-primary/10 p-3 rounded-full">
                    <span class="material-symbols-outlined text-primary text-3xl">temp_preferences_custom</span>
                </div>
                <div>
                    <h3 class="font-display text-xl font-bold text-primary dark:text-slate-100">Descubra seu vinho
                        ideal</h3>
                    <p class="text-sm text-slate-500 dark:text-slate-400">O sommelier digital Agnello ajuda você.</p>
                </div>
            </div>
            <p class="text-slate-600 dark:text-slate-300 text-sm mb-5 leading-relaxed">
                Responda 3 perguntas simples e receba recomendações personalizadas baseadas no seu paladar.
            </p>
            <button class="w-full bg-primary text-white py-3 rounded-lg font-bold flex items-center justify-center gap-2 group">
                Começar Quiz
                <span class="material-symbols-outlined text-sm group-hover:translate-x-1 transition-transform">arrow_forward</span>
            </button>
        </div>
    </section>
    -->
    <!-- Categories Grid -->
    <section class="px-4 pt-12">
        <div class="flex items-end justify-between mb-6">
            <h3 class="font-display text-2xl font-bold text-primary dark:text-slate-100">Categorias</h3>
            <a class="text-accent-gold text-sm font-bold uppercase tracking-wider" href="${pageContext.request.contextPath}/controller?action=ShowCatalog">Ver Todas</a>
        </div>
        <div class="grid grid-cols-2 gap-4">
            <div class="group relative h-40 rounded-lg overflow-hidden border border-primary/10">
                <div class="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-110"
                     data-alt="Pouring glass of deep red wine"
                     style="background-image: linear-gradient(0deg, rgba(73, 14, 14, 0.7) 0%, rgba(0, 0, 0, 0) 60%), url('https://lh3.googleusercontent.com/aida-public/AB6AXuAMVlexAWe7R36RmQc1d2plKJtl-NXUmtSdemXKxikChOeOY-y4E_ydFWnwQBAshBorUw6i4ZG1O9EMPsg103Y3Y61pVbdN_0_TBzAEAbiFwM-F6QOYCYvb4X72Qbi2DHjavdnXkdNwgWt01QpuVH-NDROL16qfCQ77l73qGLlsN-DC1iOfJBajGRKfqg0YRWetGvsvCH4Slb1jKsIh66UefRvAbW6UtRB0SgfMQxeQ_2BGnAw2tjAuMS7KfhECRXmcurQre2DIhxkV');"></div>
                <div class="absolute bottom-3 left-3">
                    <span class="text-white font-display font-bold text-lg">Tinto</span>
                </div>
            </div>
            <div class="group relative h-40 rounded-lg overflow-hidden border border-primary/10">
                <div class="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-110"
                     data-alt="Chilled glass of white wine"
                     style="background-image: linear-gradient(0deg, rgba(73, 14, 14, 0.7) 0%, rgba(0, 0, 0, 0) 60%), url('https://lh3.googleusercontent.com/aida-public/AB6AXuDlksvatAglB3BuhyORR0UACZEZmFkz27-44HDv2dtDhodT3zrSNSKa7Wff1lk3jDwrJld6PPrIVI6Y2vNDSPAKDEsBFsw67wwjSTKm1zK6lYNDPlLktZlx0INPlviIVIxS3cSLPbsI6xarbaRJ-4uatWc3RHuk7P6VbqXuCp6wAcXi_Y3dqYLA6KNkv19WudWMCoEI8foAZL1m7_Hx6zakalAxPvX3YnAELa2wIwa1VNVgBalfeMGwpVRHbtQhsgm6nJ5r8PHs3c2b');"></div>
                <div class="absolute bottom-3 left-3">
                    <span class="text-white font-display font-bold text-lg">Branco</span>
                </div>
            </div>
            <div class="group relative h-40 rounded-lg overflow-hidden border border-primary/10">
                <div class="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-110"
                     data-alt="Fresh glass of rose wine"
                     style="background-image: linear-gradient(0deg, rgba(73, 14, 14, 0.7) 0%, rgba(0, 0, 0, 0) 60%), url('https://lh3.googleusercontent.com/aida-public/AB6AXuDSuC2NV05Jk9cMf-Bxfzrkgn-d1pYIHYraUUuTwoMBwgCccoK9ki4DveZ5R0fseINoIVpwhv5LgrbHUgpHO2mAbsM928hSJZW3BvrWyDci1cyjd4tokWKqjS3Vliv-Ai_2GGPKsUIBe7ZHkDrU02JeIQI_rX9s_uimwRGX2xw7zQCcFcyT5f1WRs1pEmmlNdbgfHsZ5CFT4Zi4tQc7UILLNtDT9EKswaIEo9FqHoRp_xb6lWbmbTtTuP7DjvFCY9MbJammy-Pd7mON');"></div>
                <div class="absolute bottom-3 left-3">
                    <span class="text-white font-display font-bold text-lg">Rosé</span>
                </div>
            </div>
            <div class="group relative h-40 rounded-lg overflow-hidden border border-primary/10">
                <div class="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-110"
                     data-alt="Bubbling glass of sparkling wine"
                     style="background-image: linear-gradient(0deg, rgba(73, 14, 14, 0.7) 0%, rgba(0, 0, 0, 0) 60%), url('https://lh3.googleusercontent.com/aida-public/AB6AXuBn3Hzvd6R-jYsqHYzokjkhSCM2yWNbWSNLTi26xBulEaRUFmpqNYABEgQ5zowk-lz1zGuxID7B07r7nMdZd34BXqiLb8PqFd_3QfVBuBkXHA2nEqs8E2HyRJp-IH5b3bzF5kM0ZJOznigGeqiWKL1jeI-Do4suDLV2luvgg4jDm2ljKBEZgw0WCIwPiOEtdUiKdD7L8mYc0LMylGgdrsYwyli__NRA8V0QRnrgrrewzBH8HzHq_ZeJoXanw37KU-nYGEYl2cG1SsY4');"></div>
                <div class="absolute bottom-3 left-3">
                    <span class="text-white font-display font-bold text-lg">Espumante</span>
                </div>
            </div>
        </div>
    </section>
    <!-- Curated Selection: Seleção do Giulio -->
    <section class="pt-12">
        <div class="px-4 mb-6">
            <h3 class="font-display text-2xl font-bold text-primary dark:text-slate-100">Seleção do Giulio</h3>
            <p class="text-slate-500 text-sm italic">Curadoria exclusiva do nosso fundador</p>
        </div>
        <div class="flex overflow-x-auto gap-4 px-4 pb-4 no-scrollbar">
            <c:forEach var="wine" items="${shopWindow.wines}">

                    <a href="${pageContext.request.contextPath}/controller?action=ShowProductDetails&id=${wine.id}" class="min-w-[200px] block bg-white dark:bg-slate-800 rounded-lg overflow-hidden border border-primary/5 shadow-sm">
                        <div class="h-64 bg-background-light dark:bg-slate-900 flex items-center justify-center p-4 relative">
                                <span class="absolute top-2 left-2 bg-accent-gold text-white text-[10px] font-bold px-2 py-1 rounded">PREMIUM</span>
                            <img alt="${wine.name}" class="h-full object-contain" src="${wine.imageURL}"/>
                        </div>
                        <div class="p-4">
                            <p class="text-[10px] text-slate-400 uppercase font-bold">${wine.region}, ${wine.country}</p>
                            <h4 class="font-display font-bold text-slate-800 dark:text-slate-100 truncate">${wine.name}</h4>
                            <c:set var="userRating" value="${wine.userRatings != null ? wine.userRatings : 0}" />
                            <div class="flex items-center gap-1 my-2">
                                <c:forEach var="starIndex" begin="1" end="5">
                                    <span class="material-symbols-outlined text-accent-gold text-xs ${starIndex <= userRating ? 'fill-1' : ''}">star</span>
                                </c:forEach>
                            </div>
                            <div class="flex items-baseline gap-2 mt-2">
                                <span class="text-primary font-bold">
                                    R$ <fmt:formatNumber value="${wine.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                </span>
                            </div>
                        </div>
                    </a>

            </c:forEach>
        </div>
    </section>
    <!-- Subscription Club Section -->
    <section class="px-4 pt-12">
        <div class="bg-primary rounded-xl overflow-hidden text-white relative">
            <div class="absolute right-0 top-0 w-32 h-32 bg-accent-gold/10 rounded-full -translate-y-1/2 translate-x-1/2"></div>
            <div class="p-8 relative z-10">
                <h3 class="font-display text-3xl font-bold mb-2">Club Agnello</h3>
                <p class="text-accent-gold text-sm font-bold uppercase tracking-widest mb-6">A experiência completa</p>
                <ul class="space-y-4 mb-8">
                    <li class="flex items-start gap-3 text-sm">
                        <span class="material-symbols-outlined text-accent-gold">check_circle</span>
                        <span>3 a 6 garrafas selecionadas mensalmente</span>
                    </li>
                    <li class="flex items-start gap-3 text-sm">
                        <span class="material-symbols-outlined text-accent-gold">check_circle</span>
                        <span>Frete grátis em todas as compras</span>
                    </li>
                    <li class="flex items-start gap-3 text-sm">
                        <span class="material-symbols-outlined text-accent-gold">check_circle</span>
                        <span>Acesso a rótulos raros e pré-lançamentos</span>
                    </li>
                </ul>
                <button class="w-full bg-accent-gold text-primary font-bold py-3 rounded-lg hover:bg-white transition-colors">
                    Em breve...
                </button>
            </div>
        </div>
    </section>
    <!-- Heritage Section -->
    <section class="px-4 py-16 text-center">
        <h4 class="font-display text-2xl font-bold text-primary mb-4 italic">Nossa Herança</h4>
        <p class="text-slate-600 dark:text-slate-400 text-sm leading-relaxed max-w-xs mx-auto">
            Desde 1994, a família Agnello percorre as vinícolas mais remotas do mundo para trazer à sua mesa garrafas
            que contam histórias. Cada vinho em nossa adega é provado e aprovado por nossa curadoria técnica.
        </p>
        <div class="mt-8 flex justify-center opacity-30">
            <span class="material-symbols-outlined text-primary text-6xl">wine_bar</span>
        </div>
    </section>
</main>
<%@ include file="./snippets/menu.jsp" %>
<!-- Bottom Navigation Bar -->
<%@ include file="./snippets/bottom-nav.jsp" %>
<style>
    .no-scrollbar::-webkit-scrollbar {
        display: none;
    }

    .no-scrollbar {
        -ms-overflow-style: none;
        scrollbar-width: none;
    }

    .fill-1 {
        font-variation-settings: 'FILL' 1;
    }
</style>
<script>
    (function () {
        const openBtn = document.getElementById("open-menu-btn");
        const closeBtn = document.getElementById("close-menu-btn");
        const menu = document.getElementById("mobile-menu");
        const overlay = document.getElementById("menu-overlay");

        if (!openBtn || !closeBtn || !menu || !overlay) {
            return;
        }

        function openMenu() {
            overlay.classList.remove("hidden");
            menu.classList.remove("-translate-x-full");
            document.body.classList.add("overflow-hidden");
        }

        function closeMenu() {
            overlay.classList.add("hidden");
            menu.classList.add("-translate-x-full");
            document.body.classList.remove("overflow-hidden");
        }

        openBtn.addEventListener("click", openMenu);
        closeBtn.addEventListener("click", closeMenu);
        overlay.addEventListener("click", closeMenu);

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                closeMenu();
            }
        });
    })();
</script>
</body>
</html>
