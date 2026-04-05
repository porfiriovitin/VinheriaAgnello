<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Vinheria Agnello | Login</title>

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
						"background-dark": "#201212",
					},
					fontFamily: {
						"display": ["Noto Serif", "serif"],
						"sans": ["Noto Sans", "sans-serif"]
					},
					borderRadius: {
						"DEFAULT": "0.25rem",
						"lg": "0.5rem",
						"xl": "0.75rem",
						"2xl": "1rem",
						"full": "9999px"
					},
					boxShadow: {
						"wine": "0 25px 50px -12px rgba(73, 14, 14, 0.25)"
					}
				},
			},
		};
	</script>

	<style>
		body {
			min-height: max(884px, 100dvh);
			font-family: "Noto Sans", sans-serif;
			background:
				radial-gradient(circle at 15% 15%, rgba(197, 160, 89, 0.12), transparent 28%),
				radial-gradient(circle at 85% 80%, rgba(73, 14, 14, 0.1), transparent 34%),
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
			transform: translateY(16px);
			animation: fadeUp 0.55s ease forwards;
		}

		.fade-up-delay {
			animation-delay: 0.12s;
		}

		.fade-up-delay-2 {
			animation-delay: 0.22s;
		}

		.hero-cellar-bg {
			background-image: url("https://images.unsplash.com/photo-1516594915697-87eb3b1c14ea?q=80&w=1400&auto=format&fit=crop");
		}

		@keyframes fadeUp {
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
	</style>
</head>

<body class="text-slate-900 dark:text-slate-100">
    <%
    	String erro = (String) request.getAttribute("erro");
    %>

	<header class="sticky top-0 z-30 bg-background-light/90 backdrop-blur-md border-b border-primary/10">
		<div class="max-w-6xl mx-auto px-4 md:px-8 py-3 flex items-center justify-between">
			<a href="pages/products.html" class="inline-flex items-center gap-2 text-primary hover:text-primary/80 transition-colors">
				<span class="material-symbols-outlined">arrow_back</span>
				<span class="text-sm font-semibold">Voltar para a vitrine</span>
			</a>
			<p class="font-display text-lg md:text-xl font-bold tracking-tight text-primary">VINHERIA AGNELLO</p>
			<a href="sommelier.html" class="hidden sm:inline-flex items-center gap-1 text-sm font-semibold text-accent-gold hover:text-primary transition-colors">
				<span class="material-symbols-outlined text-base">smart_toy</span>
				Sommelier Digital
			</a>
		</div>
	</header>

	<main class="max-w-6xl mx-auto px-4 md:px-8 py-8 md:py-12">
		<section class="grid lg:grid-cols-2 gap-6 md:gap-10 items-stretch">
			<article class="relative overflow-hidden rounded-2xl border border-primary/10 shadow-wine bg-primary text-white fade-up">
				<div class="absolute inset-0 bg-cover bg-center opacity-35 hero-cellar-bg"></div>
				<div class="absolute inset-0 bg-gradient-to-b from-primary/35 to-background-dark/85"></div>

				<div class="relative h-full p-8 md:p-10 flex flex-col justify-between min-h-[420px]">
					<div>
						<p class="text-accent-gold text-xs uppercase tracking-[0.25em] font-bold mb-4">Dal 1994</p>
						<h1 class="font-display text-4xl md:text-5xl font-bold leading-tight mb-4">
							Seja bem-vindo
							<span class="text-accent-gold">de volta</span>
						</h1>
						<p class="text-slate-100/90 max-w-md leading-relaxed">
							Entre para acessar seus pedidos, favoritos, benefícios do Club Agnello e recomendações personalizadas do nosso sommelier.
						</p>
					</div>

					<div class="space-y-4 pt-8">
						<div class="flex items-center gap-3">
							<span class="material-symbols-outlined text-accent-gold">local_shipping</span>
							<p class="text-sm">Frete especial para assinantes e clientes recorrentes</p>
						</div>
						<div class="flex items-center gap-3">
							<span class="material-symbols-outlined text-accent-gold">wine_bar</span>
							<p class="text-sm">Rastreador de safras e histórico de degustação</p>
						</div>
					</div>
				</div>
			</article>

			<article class="bg-white/95 border border-primary/10 rounded-2xl shadow-xl p-6 md:p-8 lg:p-10 fade-up fade-up-delay">
				<div class="mb-8">
					<p class="text-xs font-bold uppercase tracking-[0.2em] text-accent-gold mb-2">Acesso exclusivo</p>
					<h2 class="font-display text-3xl font-bold text-primary mb-2">Entrar na sua conta</h2>
					<p class="text-sm text-slate-500">Use seu e-mail cadastrado para continuar sua jornada na adega Agnello.</p>
				</div>

				<form class="space-y-5" action="/VinheriaAgnello/controller?action=Login" method="post">
					<div>
						<label for="email" class="block text-sm font-semibold text-primary mb-2">E-mail</label>
						<div class="relative">
							<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/50">mail</span>
							<input id="email" name="email" type="email" autocomplete="email" required placeholder="nome@exemplo.com"
								class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary pl-11 pr-4 py-3 bg-background-light" />
						</div>
					</div>

					<div>
						<div class="flex items-center justify-between mb-2">
							<label for="password" class="text-sm font-semibold text-primary">Senha</label>
							<a href="#" class="text-xs font-semibold text-accent-gold hover:text-primary transition-colors">Esqueci minha senha</a>
						</div>
						<div class="relative">
							<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/50">lock</span>
							<input id="password" name="password" type="password" autocomplete="current-password" required placeholder="Digite sua senha"
								class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary pl-11 pr-4 py-3 bg-background-light" />
						</div>
					</div>

					<div class="flex items-center justify-between text-sm">
						<label class="inline-flex items-center gap-2 cursor-pointer">
							<input type="checkbox" class="rounded border-primary/30 text-primary focus:ring-primary" />
							<span class="text-slate-600">Manter conectado</span>
						</label>
						<a href="sommelier.html" class="font-semibold text-primary hover:text-primary/75 transition-colors">Pedir ajuda do sommelier</a>
					</div>

					<button type="submit"
						class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3.5 rounded-lg transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2">
						Entrar
						<span class="material-symbols-outlined text-base">arrow_forward</span>
					</button>

				</form>

				<p class="text-center text-sm text-slate-500 mt-8">
					Novo por aqui?
					<a href="signup.jsp" class="font-bold text-primary hover:text-primary/80 transition-colors">Crie sua conta</a>
				</p>
			</article>
		</section>
	</main>
</body>
</html>
