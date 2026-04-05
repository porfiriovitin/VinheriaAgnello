<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>

<html class="light" lang="pt-br">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Vinheria Agnello - Catálogo de Vinhos</title>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#490e0e",
                        "accent-gold": "#D4AF37",
                        "background-light": "#f8f6f6",
                        "background-dark": "#201212",
                    },
                    fontFamily: {
                        "display": ["Noto Serif", "serif"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>

    <style>
        body {
            font-family: 'Noto Serif', serif;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>

    <style>
        body {
            min-height: max(884px, 100dvh);
        }
    </style>

    <%@ include file="./snippets/app-scripts.jsp"%>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
    <header class="sticky top-0 z-50 bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-sm border-b border-primary/10 px-4 py-4 flex items-center justify-between">
        <button id="open-menu-btn" aria-label="Abrir menu" class="p-2 text-primary dark:text-slate-100">
            <span class="material-symbols-outlined">menu</span>
        </button>
        <h1 class="text-2xl font-bold tracking-tight text-primary dark:text-slate-100 uppercase italic">Vinheria Agnello</h1>
        <button class="p-2 text-primary dark:text-slate-100">
            <span class="material-symbols-outlined">search</span>
        </button>
    </header>

    <main class="flex-1 max-w-7xl mx-auto w-full">
        <div class="px-4 py-8 text-center border-b border-accent-gold/20">
            <p class="text-xs uppercase tracking-widest text-accent-gold mb-2">Coleção Exclusiva</p>
            <h2 class="text-3xl font-display text-primary dark:text-slate-100 italic">Vinhos Tintos & Brancos</h2>
        </div>

        <div class="flex gap-3 p-4 overflow-x-auto no-scrollbar items-center border-b border-primary/5 sticky top-[65px] bg-background-light dark:bg-background-dark z-40">
            <button class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg border border-accent-gold/30 bg-white dark:bg-slate-800 px-4 transition-all hover:border-accent-gold">
                <p class="text-primary dark:text-slate-100 text-sm font-medium">País</p>
                <span class="material-symbols-outlined text-accent-gold text-lg">expand_more</span>
            </button>
            <button class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg border border-accent-gold/30 bg-white dark:bg-slate-800 px-4 transition-all hover:border-accent-gold">
                <p class="text-primary dark:text-slate-100 text-sm font-medium">Uva</p>
                <span class="material-symbols-outlined text-accent-gold text-lg">expand_more</span>
            </button>
            <button class="flex h-10 shrink-0 items-center justify-center gap-x-2 rounded-lg border border-accent-gold/30 bg-white dark:bg-slate-800 px-4 transition-all hover:border-accent-gold">
                <p class="text-primary dark:text-slate-100 text-sm font-medium">Preço</p>
                <span class="material-symbols-outlined text-accent-gold text-lg">expand_more</span>
            </button>
            <div class="ml-auto flex items-center gap-2 pl-4 border-l border-primary/10">
                <span class="material-symbols-outlined text-primary dark:text-slate-100">tune</span>
            </div>
        </div>

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
                            <p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">
                                R$ <fmt:formatNumber value="${wine.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </p>
                            <a href="controller?action=ShowProductDetails&id=${wine.id}" class=" flex justify-center mx-auto w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold p-3 rounded uppercase tracking-widest transition-colors">
                                Ver Detalhes
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="flex flex-col items-center px-4 py-12 gap-4">
            <button class="flex min-w-[200px] cursor-pointer items-center justify-center rounded border-2 border-primary text-primary hover:bg-primary hover:text-white px-8 h-12 text-sm font-bold uppercase tracking-widest transition-all">
                Carregar mais
            </button>
            <p class="text-slate-400 text-xs italic">Exibindo 6 de 142 rótulos</p>
        </div>
    </main>

    <%@ include file="./snippets/menu.jsp"%>

    <%@ include file="./snippets/bottom-nav.jsp"%>

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