<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>

<html class="light" lang="pt-br"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Vinheria Agnello - Catálogo de Vinhos</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
  </head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
<!-- Header -->
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
<!-- Hero/Breadcrumb Section -->
<div class="px-4 py-8 text-center border-b border-accent-gold/20">
<p class="text-xs uppercase tracking-widest text-accent-gold mb-2">Coleção Exclusiva</p>
<h2 class="text-3xl font-display text-primary dark:text-slate-100 italic">Vinhos Tintos &amp; Brancos</h2>
</div>
<!-- Filter Bar -->
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
<!-- Product Grid -->
<div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 p-4 md:p-8">
<!-- Card 1 -->
<div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
<div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
<img alt="Vinho Tinto Brunello" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Elegante garrafa de vinho tinto Brunello di Montalcino" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBFmhn7_eFS8LG7wX_RbHDiaCt0VjBBKn3Qo5oD75X5djCwzFHizW-uIii9nJMiHVPzdfbBh242NpCQqJYp7VVTx-N6N9pkolvdneU2Wc3UmijxOl3dwi4nK5TEWw-zkvBZ4utQHJiynDij0-HMrKQPuAOaz-Ifsy5bxl0HMPL9NV2gg35irbpPC8u_23v8H_MTRIVscrbydjb5m7HQFf9EvtT7TbmGABIywX2CE1Jneedz7_ZFCRJSK068IFZBGYbtchb_Be0BeEQ-"/>
<div class="absolute top-2 right-2">
<span class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">favorite</span>
</div>
</div>
<div class="p-4 flex flex-col flex-1">
<h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">Brunello di Montalcino</h3>
<p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">Toscana, Itália</p>
<div class="mt-auto">
<p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ 450,00</p>
<button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                            Ver Detalhes
                        </button>
</div>
</div>
</div>
<!-- Card 2 -->
<div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
<div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
<img alt="Vinho Tinto Barolo" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Garrafa de vinho Barolo reserva especial" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCSJOvFoV30RcYoA3C35iLNOta9_5sCOdolkVhkYvYPynb33pnucjkCi3Qla3v2kd-yPJ2gWm-OXjTa1DuFk8ug3l5zkLAyISjY3U1D-qNfhTeI6yhFta8PkybHxDiuRyQiY_njO659VCHYGqsAC7gE5a9RXbhYtOkYnf5p9UEzFT5w01qpkZmieHuI5al-EW_LM5ZSesr9G3OQ_OlMpWe4_o2ELXynICySA7yz_MY0qBNOKV8g4XL1K6VBSyhJID0dCHH3--deVn3P"/>
<div class="absolute top-2 right-2">
<span class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">favorite</span>
</div>
</div>
<div class="p-4 flex flex-col flex-1">
<h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">Barolo DOCG</h3>
<p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">Piemonte, Itália</p>
<div class="mt-auto">
<p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ 380,00</p>
<button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                            Ver Detalhes
                        </button>
</div>
</div>
</div>
<!-- Card 3 -->
<div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
<div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
<img alt="Chianti Classico" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Garrafa de vinho Chianti clássico italiano" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDBVU4cM5ejM16DbrwL3b_P1dHqGnkyNIhYv2748v157mWinqFCERaUokP4U11fZPF9tjnz2kpWHyYUrm_Wsn1VXwNmPCJKRCpvr9d0a0wFEYzFPrmfB1ZCysmVRnyIrHfTikR6oLQTLZys4uqGI9bL98Du5XcI1hZ8emkFIymwY4xAJwzQKXjOgBMMU0AawRWxjiewgv7WX8OlOm2eI1oKIXZkMTxxuh0hCTUnBkNjpb7FR91RRLTUkt4aaRAl135Da24RPXI2SbVr"/>
<div class="absolute top-2 right-2">
<span class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">favorite</span>
</div>
</div>
<div class="p-4 flex flex-col flex-1">
<h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">Chianti Classico</h3>
<p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">Toscana, Itália</p>
<div class="mt-auto">
<p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ 120,00</p>
<button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                            Ver Detalhes
                        </button>
</div>
</div>
</div>
<!-- Card 4 -->
<div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
<div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
<img alt="Amarone della Valpolicella" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Vinho premium Amarone della Valpolicella" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCv6Ztz3HGMyc8AAa00KV7B6TWvg8k_I3mXpp1Cm0Yn7K7wdzJjJvqt50CWF5sDzsgylGWapmLf0TRx8a5TvREemjR02Ri4dBEn7LTIRrq5B0XPqrGqV6Arj3hpUC6WMYUC-bNgNhqFaRcjq-warDthWVwLd-MHUBG-l3i4Amd2u0JX2A5r_Eq11Gpzh0Q1PRwLVGJIxFFj6SftoqZfTqeF3rQJTJdwDFIhkLcqKF8hfyEPFpFQ2812T-y76M-A5uHVKDddi2wZMv4Q"/>
<div class="absolute top-2 right-2">
<span class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">favorite</span>
</div>
</div>
<div class="p-4 flex flex-col flex-1">
<h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">Amarone DOCG</h3>
<p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">Vêneto, Itália</p>
<div class="mt-auto">
<p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ 520,00</p>
<button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                            Ver Detalhes
                        </button>
</div>
</div>
</div>
<!-- Card 5 (Additional Item) -->
<div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
<div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
<img alt="Chardonnay Reserve" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Garrafa de vinho branco Chardonnay Reserva" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBDkvCcimKztR-dmlHPbyE20UWpWc3JBiw7eq7_p5cQTGuLheQilJWsXPyQx0Yy-4NQjm_cqBmoq32qKeirG5UF7cySeFoBtXMatzq0Z52IYgqkWwu9gfCK0ymYM03IvRgLTquvTrwwK4dmia5X3vjyFHznnNg75QzNAVeQU428HOS5qh0S7XNMdFxaT9CD75KvpaBlKwyqX8BWo2mM9WBAieU23rbEXfu0OSWzHvSgNBRGmyeGXz3iackJ2Kg5Sxkr-EvzNvSe2dC2"/>
<div class="absolute top-2 right-2">
<span class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">favorite</span>
</div>
</div>
<div class="p-4 flex flex-col flex-1">
<h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">Chardonnay Reserve</h3>
<p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">Napa Valley, EUA</p>
<div class="mt-auto">
<p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ 290,00</p>
<button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                            Ver Detalhes
                        </button>
</div>
</div>
</div>
<!-- Card 6 (Additional Item) -->
<div class="group flex flex-col bg-white dark:bg-background-dark/50 rounded-lg overflow-hidden border border-primary/5 shadow-sm hover:shadow-md transition-shadow">
<div class="relative aspect-[3/4] overflow-hidden bg-[#f4f1f1] flex items-center justify-center p-4">
<img alt="Malbec Gran Reserva" class="h-full w-full object-cover transition-transform duration-500 group-hover:scale-105" data-alt="Vinho Malbec Gran Reserva Argentino" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDGu4c04T53qh-WdhBAf3YX1JhOz3_G39fpgH5n89w0wPuUVtbuNDa0P2QInJAwmL2pJxEUVPhUjBYRRFU9ZuEUD2oepQKszV5hTsl--5_op_NVAC_5nYi2xEVNleCkUu2FHCEyPT2RzVkqVHWc335jT92t3t-uuWAsbVwK8lZzTAnj16LIA1_pxgNqPd92vA2vrbs8t0-7TqJ-DCnkBqPx3P3SzFqKH0JdCgLdRPeJBqJi7CeVDvR8YMeCT3LjC8hLDdUxPQ3qIPJz"/>
<div class="absolute top-2 right-2">
<span class="material-symbols-outlined text-primary/30 group-hover:text-primary transition-colors cursor-pointer">favorite</span>
</div>
</div>
<div class="p-4 flex flex-col flex-1">
<h3 class="text-primary dark:text-slate-100 text-base font-bold leading-tight mb-1">Malbec Gran Reserva</h3>
<p class="text-slate-500 dark:text-slate-400 text-xs italic mb-2">Mendoza, Argentina</p>
<div class="mt-auto">
<p class="text-primary dark:text-accent-gold font-bold text-lg mb-3">R$ 215,00</p>
<button class="w-full bg-primary hover:bg-primary/90 text-white text-xs font-bold py-3 rounded uppercase tracking-widest transition-colors">
                            Ver Detalhes
                        </button>
</div>
</div>
</div>
</div>
<!-- Load More Section -->
<div class="flex flex-col items-center px-4 py-12 gap-4">
<button class="flex min-w-[200px] cursor-pointer items-center justify-center rounded border-2 border-primary text-primary hover:bg-primary hover:text-white px-8 h-12 text-sm font-bold uppercase tracking-widest transition-all">
                Carregar mais
            </button>
<p class="text-slate-400 text-xs italic">Exibindo 6 de 142 rótulos</p>
</div>
</main>
<div id="menu-overlay" class="fixed inset-0 bg-black/40 z-[60] hidden"></div>
<aside id="mobile-menu" class="fixed top-0 left-0 h-full w-80 max-w-[85vw] bg-background-light border-r border-primary/10 shadow-2xl z-[70] -translate-x-full transition-transform duration-300">
<div class="p-5 border-b border-primary/10 flex items-center justify-between">
<div>
<p class="font-display text-xl font-bold text-primary">Vinheria Agnello</p>
<p class="text-[10px] uppercase tracking-[0.22em] text-accent-gold font-bold">Navegacao</p>
</div>
<button id="close-menu-btn" aria-label="Fechar menu" class="w-9 h-9 rounded-full hover:bg-primary/5 flex items-center justify-center text-primary">
<span class="material-symbols-outlined">close</span>
</button>
</div>
<nav class="p-3 space-y-1">
<a href="index.html" class="flex items-center gap-3 px-3 py-3 rounded-lg text-slate-700 hover:bg-primary/5 transition-colors">
<span class="material-symbols-outlined">home</span>Início
</a>
<a href="products.html" class="flex items-center gap-3 px-3 py-3 rounded-lg text-slate-700 hover:bg-primary/5 transition-colors">
<span class="material-symbols-outlined">liquor</span>Todos os Vinhos
</a>
<a href="categories.html" class="flex items-center gap-3 px-3 py-3 rounded-lg text-primary bg-primary/5 font-semibold">
<span class="material-symbols-outlined">category</span>Categorias
</a>
<a href="sommelier.html" class="flex items-center gap-3 px-3 py-3 rounded-lg text-slate-700 hover:bg-primary/5 transition-colors">
<span class="material-symbols-outlined">stars</span>Sommelier Digital
</a>
<a href="cart-checkout.html" class="flex items-center gap-3 px-3 py-3 rounded-lg text-slate-700 hover:bg-primary/5 transition-colors">
<span class="material-symbols-outlined">shopping_bag</span>Carrinho
</a>
<a href="login.html" class="flex items-center gap-3 px-3 py-3 rounded-lg text-slate-700 hover:bg-primary/5 transition-colors">
<span class="material-symbols-outlined">person</span>Entrar
</a>
</nav>
</aside>
<!-- Bottom Navigation -->
<nav class="sticky bottom-0 w-full border-t border-primary/10 bg-background-light dark:bg-background-dark px-4 pb-6 pt-2 flex items-center justify-around z-50">
<a class="flex flex-col items-center gap-1 text-slate-400 hover:text-primary dark:hover:text-accent-gold transition-colors" href="#">
<span class="material-symbols-outlined">home</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Início</span>
</a>
<a class="flex flex-col items-center gap-1 text-primary dark:text-accent-gold" href="#">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1">liquor</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Catálogo</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400 hover:text-primary dark:hover:text-accent-gold transition-colors" href="#">
<span class="material-symbols-outlined">favorite</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Desejos</span>
</a>
<a class="flex flex-col items-center gap-1 text-slate-400 hover:text-primary dark:hover:text-accent-gold transition-colors" href="#">
<span class="material-symbols-outlined">person</span>
<span class="text-[10px] font-bold uppercase tracking-tighter">Perfil</span>
</a>
</nav>
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
</body></html>