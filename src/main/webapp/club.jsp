<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<%@ include file="./snippets/favicon.jsp" %>
	<title>Vinheria Agnello | Club Agnello</title>

	<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&family=Noto+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />

	<script id="tailwind-config">
		tailwind.config = {
			darkMode: "class",
			theme: {
				extend: {
					colors: {
						"primary": "#490e0e",
						"accent-gold": "#C5A059",
						"background-light": "#f8f6f6",
						"background-dark": "#201212"
					},
					fontFamily: {
						"display": ["Noto Serif", "serif"],
						"sans": ["Noto Sans", "sans-serif"]
					},
					boxShadow: {
						"wine": "0 20px 45px -14px rgba(73, 14, 14, 0.35)"
					}
				}
			}
		};
	</script>

	<style>
		body {
			min-height: max(884px, 100dvh);
			font-family: "Noto Sans", sans-serif;
			background:
				radial-gradient(circle at 12% 8%, rgba(197, 160, 89, 0.2), transparent 30%),
				radial-gradient(circle at 82% 78%, rgba(73, 14, 14, 0.15), transparent 36%),
				#f8f6f6;
		}

		h1,
		h2,
		h3,
		.font-display {
			font-family: "Noto Serif", serif;
		}

		.fade-up {
			opacity: 0;
			transform: translateY(14px);
			animation: fadeUp 0.5s ease forwards;
		}

		.fade-up-delay {
			animation-delay: 0.14s;
		}

		@keyframes fadeUp {
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
	</style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">
	<header class="sticky top-0 z-50 bg-background-light/95 dark:bg-background-dark/95 backdrop-blur-md border-b border-primary/10 px-4 py-3 flex items-center justify-between">
		<button id="open-menu-btn" aria-label="Abrir menu" class="p-2 text-primary dark:text-slate-100">
			<span class="material-symbols-outlined text-3xl">menu</span>
		</button>

		<div class="text-center">
			<h1 class="font-display text-2xl font-bold tracking-tighter text-primary dark:text-slate-100">VINHERIA AGNELLO</h1>
			<p class="text-[10px] uppercase tracking-[0.2em] text-accent-gold font-bold">Dal 1994</p>
		</div>

		<a href="${pageContext.request.contextPath}/controller?action=ShowCartCheckout" class="p-2 text-primary dark:text-slate-100 relative" aria-label="Ver carrinho">
			<span class="material-symbols-outlined text-2xl">shopping_bag</span>
			<span class="absolute top-1 right-1 bg-accent-gold text-white text-[10px] font-bold rounded-full w-4 h-4 flex items-center justify-center">0</span>
		</a>
	</header>

	<main class="max-w-md mx-auto px-4 pb-24 pt-8">
		<section class="relative overflow-hidden rounded-2xl bg-primary text-white shadow-wine fade-up">
			<div class="absolute -top-20 -right-16 w-52 h-52 rounded-full bg-accent-gold/15"></div>
			<div class="absolute -bottom-16 -left-12 w-40 h-40 rounded-full bg-black/10"></div>

			<div class="relative p-7">
				<p class="text-xs uppercase tracking-[0.24em] text-accent-gold font-bold mb-3">Club Agnello</p>
				<h2 class="font-display text-3xl font-bold leading-tight mb-4">Estamos preparando algo especial</h2>
				<p class="text-sm text-slate-100/90 leading-relaxed mb-6">
					O clube de assinatura será iniciado em breve com selecoes mensais exclusivas, beneficios para membros
					e acesso antecipado aos melhores rotulos.
				</p>

				<button type="button" class="w-full bg-accent-gold text-primary font-bold py-3 rounded-lg hover:bg-white transition-colors inline-flex items-center justify-center gap-2">
					Entrar na lista de espera
					<span class="material-symbols-outlined text-base">notifications_active</span>
				</button>
			</div>
		</section>

		<section class="mt-8 bg-white/95 border border-primary/10 rounded-xl p-5 fade-up fade-up-delay">
			<h3 class="font-display text-xl text-primary font-bold mb-2">O que vem por ai</h3>
			<ul class="space-y-3 text-sm text-slate-600">
				<li class="flex items-start gap-2">
					<span class="material-symbols-outlined text-accent-gold text-lg">check_circle</span>
					Curadoria mensal com rótulos selecionados pela equipe Agnello.
				</li>
				<li class="flex items-start gap-2">
					<span class="material-symbols-outlined text-accent-gold text-lg">check_circle</span>
					Benefícios exclusivos para membros e condições especiais na loja.
				</li>
				<li class="flex items-start gap-2">
					<span class="material-symbols-outlined text-accent-gold text-lg">check_circle</span>
					Conteúdos e recomendações do nosso sommelier digital.
				</li>
			</ul>
		</section>
	</main>

	<%@ include file="./snippets/menu.jsp" %>
	<%@ include file="./snippets/bottom-nav.jsp" %>

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
