<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&family=Noto+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
	<%@ include file="./snippets/favicon.jsp" %>
    <title>Vinheria Agnello | Criar Conta</title>
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
				radial-gradient(circle at 8% 18%, rgba(197, 160, 89, 0.13), transparent 30%),
				radial-gradient(circle at 88% 82%, rgba(73, 14, 14, 0.1), transparent 34%),
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
			animation: fadeUp 0.55s ease forwards;
		}

		.fade-up-delay {
			animation-delay: 0.1s;
		}

		.fade-up-delay-2 {
			animation-delay: 0.22s;
		}

		.hero-vineyard-bg {
			background-image: url("https://images.unsplash.com/photo-1470158499416-75be9aa0c4db?q=80&w=1600&auto=format&fit=crop");
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
	<header class="sticky top-0 z-30 bg-background-light/90 backdrop-blur-md border-b border-primary/10">
		<div class="max-w-6xl mx-auto px-4 md:px-8 py-3 flex items-center justify-between">
			<a href="/VinheriaAgnello/controller?action=ShowIndex" class="inline-flex items-center gap-2 text-primary hover:text-primary/80 transition-colors">
				<span class="material-symbols-outlined">arrow_back</span>
				<span class="text-sm font-semibold">Voltar para a vitrine</span>
			</a>
			<p class="font-display text-lg md:text-xl font-bold tracking-tight text-primary">VINHERIA AGNELLO</p>
			<a href="/controller?action=ShowLogin" class="hidden sm:inline-flex items-center gap-1 text-sm font-semibold text-accent-gold hover:text-primary transition-colors">
				<span class="material-symbols-outlined text-base">login</span>
				Já tenho conta
			</a>
		</div>
	</header>

	<main class="max-w-6xl mx-auto px-4 md:px-8 py-8 md:py-12">
		<section class="grid lg:grid-cols-2 gap-6 md:gap-10 items-stretch">
			<article class="relative overflow-hidden rounded-2xl border border-primary/10 shadow-wine bg-primary text-white fade-up">
				<div class="absolute inset-0 bg-cover bg-center opacity-35 hero-vineyard-bg"></div>
				<div class="absolute inset-0 bg-gradient-to-b from-primary/40 to-background-dark/85"></div>

				<div class="relative h-full p-8 md:p-10 flex flex-col justify-between min-h-[460px]">
					<div>
						<p class="text-accent-gold text-xs uppercase tracking-[0.25em] font-bold mb-4">Comunidade Agnello</p>
						<h1 class="font-display text-4xl md:text-5xl font-bold leading-tight mb-4">
							Crie sua conta
							<span class="text-accent-gold">e brinde conosco</span>
						</h1>
						<p class="text-slate-100/90 max-w-md leading-relaxed">
							Tenha acesso a ofertas especiais, recomendações de rótulos por ocasião e histórico completo das suas compras e degustações.
						</p>
					</div>

					<div class="grid gap-3 pt-8 text-sm">
						<div class="inline-flex items-center gap-3 rounded-lg bg-white/10 border border-white/15 px-3 py-2.5">
							<span class="material-symbols-outlined text-accent-gold">sell</span>
							Cupom de boas-vindas para primeira compra
						</div>
						<div class="inline-flex items-center gap-3 rounded-lg bg-white/10 border border-white/15 px-3 py-2.5">
							<span class="material-symbols-outlined text-accent-gold">workspace_premium</span>
							Convites para experiências e degustações exclusivas
						</div>
						<div class="inline-flex items-center gap-3 rounded-lg bg-white/10 border border-white/15 px-3 py-2.5">
							<span class="material-symbols-outlined text-accent-gold">local_shipping</span>
							Rastreio de pedidos e benefícios do Club Agnello
						</div>
					</div>
				</div>
			</article>

			<article class="bg-white/95 border border-primary/10 rounded-2xl shadow-xl p-6 md:p-8 lg:p-10 fade-up fade-up-delay">
				<div class="mb-7">
					<p class="text-xs font-bold uppercase tracking-[0.2em] text-accent-gold mb-2">Novo cadastro</p>
					<h2 class="font-display text-3xl font-bold text-primary mb-2">Abra sua conta</h2>
					<p class="text-sm text-slate-500">Preencha seus dados para começar a comprar com recomendações personalizadas.</p>
				</div>

                <%
                    String erro = (String) request.getAttribute("erro");
                    if (erro != null && !erro.isBlank()) {
                %>
                  <div class="mb-4 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm font-medium text-red-700">
                    <%= erro %>
                  </div>
                <%
                    }
                %>

				<form class="space-y-5" action="/VinheriaAgnello/controller?action=SignUp" method="post">
					<div class="grid sm:grid-cols-2 gap-4">
						<div>
							<label for="first-name" class="block text-sm font-semibold text-primary mb-2">Nome</label>
							<input id="first-name" name="first-name" type="text" autocomplete="given-name" required placeholder="Seu nome"
								class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary px-4 py-3 bg-background-light" />
						</div>
						<div>
							<label for="last-name" class="block text-sm font-semibold text-primary mb-2">Sobrenome</label>
							<input id="last-name" name="last-name" type="text" autocomplete="family-name" required placeholder="Seu sobrenome"
								class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary px-4 py-3 bg-background-light" />
						</div>
					</div>

					<div>
						<label for="email" class="block text-sm font-semibold text-primary mb-2">E-mail</label>
						<div class="relative">
							<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/50">mail</span>
							<input id="email" name="email" type="email" autocomplete="email" required placeholder="nome@exemplo.com"
								class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary pl-11 pr-4 py-3 bg-background-light" />
						</div>
					</div>

					<div>
						<label for="phone" class="block text-sm font-semibold text-primary mb-2">Telefone</label>
						<div class="relative">
							<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/50">phone</span>
							<input id="phone" name="phone" type="tel" autocomplete="tel" placeholder="(11) 99999-9999"
								class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary pl-11 pr-4 py-3 bg-background-light" />
						</div>
					</div>

					<div class="grid sm:grid-cols-2 gap-4">
						<div>
							<label for="password" class="block text-sm font-semibold text-primary mb-2">Senha</label>
							<div class="relative">
								<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/50">lock</span>
								<input id="password" name="password" type="password" autocomplete="new-password" required placeholder="No minimo 8 caracteres"
									class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary pl-11 pr-4 py-3 bg-background-light" />
							</div>
						</div>
						<div>
							<label for="confirm-password" class="block text-sm font-semibold text-primary mb-2">Confirmar senha</label>
							<div class="relative">
								<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-primary/50">verified_user</span>
								<input id="confirm-password" name="confirm-password" type="password" autocomplete="new-password" required placeholder="Repita a senha"
									class="w-full rounded-lg border-primary/15 focus:border-primary focus:ring-primary pl-11 pr-4 py-3 bg-background-light" />
							</div>
						</div>
					</div>

					<div class="space-y-3 text-sm">
						<label class="inline-flex items-start gap-2.5 cursor-pointer">
							<input type="checkbox" required class="mt-0.5 rounded border-primary/30 text-primary focus:ring-primary" />
							<span class="text-slate-600">Eu concordo com os Termos de Uso e Política de Privacidade.</span>
						</label>
						<label class="inline-flex items-start gap-2.5 cursor-pointer">
							<input type="checkbox" class="mt-0.5 rounded border-primary/30 text-primary focus:ring-primary" />
							<span class="text-slate-600">Quero receber novidades, ofertas e sugestões do sommelier por e-mail.</span>
						</label>
					</div>

					<button type="submit"
						class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3.5 rounded-lg transition-all shadow-lg shadow-primary/20 flex items-center justify-center gap-2">
						Criar conta
						<span class="material-symbols-outlined text-base">arrow_forward</span>
					</button>

				</form>

				<p class="text-center text-sm text-slate-500 mt-8">
					Ja possui cadastro?
					<a href="/VinheriaAgnello/controller?action=ShowLogin" class="font-bold text-primary hover:text-primary/80 transition-colors">Entrar agora</a>
				</p>
			</article>
		</section>


	</main>
</body>
</html>
