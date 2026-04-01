<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!doctype html>

<html lang="pt-BR">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Agnello Riserva 2018 - Vinheria Agnello</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&amp;family=Noto+Sans:wght@400;500;600&amp;display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
      rel="stylesheet"
    />
    <script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            colors: {
              primary: "#490e0e",
              "background-light": "#f8f6f6",
              "background-dark": "#201212",
            },
            fontFamily: {
              display: ["Noto Serif", "serif"],
              sans: ["Noto Sans", "sans-serif"],
            },
            borderRadius: {
              DEFAULT: "0.25rem",
              lg: "0.5rem",
              xl: "0.75rem",
              full: "9999px",
            },
          },
        },
      };
    </script>
    <style>
      body {
        font-family: "Noto Sans", sans-serif;
      }
      h1,
      h2,
      h3,
      .font-display {
        font-family: "Noto Serif", serif;
      }
      .glass-header {
        background: rgba(248, 246, 246, 0.8);
        -webkit-backdrop-filter: blur(8px);
        backdrop-filter: blur(8px);
      }
    </style>
    <style>
      body {
        min-height: max(884px, 100dvh);
      }
    </style>
  </head>
  <body
    class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen"
  >
    <!-- Top Navigation -->
    <nav
      class="fixed top-0 left-0 right-0 z-50 glass-header border-b border-primary/10 px-4 py-3 flex items-center justify-between"
    >
      <button
        class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-primary/5 transition-colors"
      >
        <span class="material-symbols-outlined text-primary">arrow_back</span>
      </button>
      <span class="font-display font-bold text-lg tracking-tight"
        >Vinheria Agnello</span
      >
      <button
        class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-primary/5 transition-colors"
      >
        <span class="material-symbols-outlined text-primary">favorite</span>
      </button>
    </nav>
    <!-- Main Content -->
    <main class="pt-16 pb-32">
      <!-- Hero Section -->
      <section class="relative bg-white dark:bg-slate-900 overflow-hidden">
        <div class="aspect-[3/4] w-full relative group cursor-zoom-in">
          <img
            alt="Bottle of Agnello Riserva 2018 red wine"
            class="w-full h-full object-cover"
            data-alt="Elegant bottle of red wine on dark background"
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuA0Uz1ws0Gql5JxbzL-gOxGsZ5q_phuLTKo7cjcrzpfZ5x2yJ1r5QHJRAKZn6Flk8Efe1Tbu5-_YPNTBcXFGwhl5atMxG54KDSIf99Q0YwW5_rAZyBGDbX2HFnfPqqssBybgPmp35l85Ys-HhcsOjZySGj0Rz8iOqr-7HDj6P4uqHpyBdXBUKiOXTE0VT1twIPDqQiNOWPh5bgcpb84vLNzmna_Hl17vuL49crEVeFmXzUszUzHcQGcvT6kCPtCiZsQjxd1GpLc_XW3"
          />
          <div
            class="absolute bottom-4 right-4 bg-white/80 backdrop-blur-md p-2 rounded-full shadow-lg"
          >
            <span class="material-symbols-outlined text-primary">zoom_in</span>
          </div>
        </div>
      </section>
      <div class="px-6 -mt-8 relative z-10">
        <!-- Header Info -->
        <div
          class="bg-background-light dark:bg-background-dark rounded-xl p-6 shadow-sm border border-primary/5"
        >
          <div class="flex items-center gap-2 mb-2">
            <div
              class="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-bold uppercase tracking-wider"
            >
              <span class="material-symbols-outlined text-sm leading-none"
                >verified</span
              >
              Recomendação do Giulio
            </div>
          </div>
          <h1
            class="text-3xl font-bold text-slate-900 dark:text-slate-100 mb-1"
          >
            Agnello Riserva 2018
          </h1>
          <p class="text-primary font-medium text-lg mb-4">
            Tinto • Toscana, Itália
          </p>
          <div
            class="flex items-center gap-4 text-sm text-slate-600 dark:text-slate-400"
          >
            <div class="flex items-center gap-1">
              <span class="material-symbols-outlined text-yellow-600 text-sm"
                >star</span
              >
              <span class="font-bold text-slate-900 dark:text-slate-100"
                >4.8</span
              >
              <span>(124 avaliações)</span>
            </div>
            <div class="w-px h-4 bg-slate-300"></div>
            <div class="flex items-center gap-1">
              <span class="material-symbols-outlined text-sm">percent</span>
              <span>14.5% Vol.</span>
            </div>
          </div>
        </div>
        <!-- Sensorial Details -->
        <section class="mt-8">
          <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
            <span class="material-symbols-outlined text-primary"
              >local_bar</span
            >
            Notas Aromáticas
          </h2>
          <div class="flex gap-4 overflow-x-auto pb-4 no-scrollbar">
            <div class="flex-shrink-0 flex flex-col items-center gap-2 w-24">
              <div
                class="w-16 h-16 rounded-full bg-primary/5 flex items-center justify-center border border-primary/10"
              >
                <span class="material-symbols-outlined text-primary text-3xl"
                  >restaurant</span
                >
              </div>
              <span class="text-xs font-medium text-center"
                >Frutas Vermelhas</span
              >
            </div>
            <div class="flex-shrink-0 flex flex-col items-center gap-2 w-24">
              <div
                class="w-16 h-16 rounded-full bg-primary/5 flex items-center justify-center border border-primary/10"
              >
                <span class="material-symbols-outlined text-primary text-3xl"
                  >forest</span
                >
              </div>
              <span class="text-xs font-medium text-center">Carvalho</span>
            </div>
            <div class="flex-shrink-0 flex flex-col items-center gap-2 w-24">
              <div
                class="w-16 h-16 rounded-full bg-primary/5 flex items-center justify-center border border-primary/10"
              >
                <span class="material-symbols-outlined text-primary text-3xl"
                  >spa</span
                >
              </div>
              <span class="text-xs font-medium text-center">Especiarias</span>
            </div>
            <div class="flex-shrink-0 flex flex-col items-center gap-2 w-24">
              <div
                class="w-16 h-16 rounded-full bg-primary/5 flex items-center justify-center border border-primary/10"
              >
                <span class="material-symbols-outlined text-primary text-3xl"
                  >potted_plant</span
                >
              </div>
              <span class="text-xs font-medium text-center">Tabaco</span>
            </div>
          </div>
        </section>
        <!-- Perfil de Sabor -->
        <section class="mt-8 space-y-6">
          <h2 class="text-xl font-bold flex items-center gap-2">
            <span class="material-symbols-outlined text-primary"
              >monitoring</span
            >
            Perfil de Sabor
          </h2>
          <div class="space-y-4">
            <!-- Acidêz -->
            <div>
              <div
                class="flex justify-between text-sm mb-1 uppercase tracking-tighter font-semibold"
              >
                <span>Acidêz</span>
                <span class="text-primary">Média-Alta</span>
              </div>
              <div
                class="h-2 w-full bg-primary/10 rounded-full overflow-hidden"
              >
                <div
                  class="h-full bg-primary rounded-full"
                  style="width: 75%"
                ></div>
              </div>
            </div>
            <!-- Taninos -->
            <div>
              <div
                class="flex justify-between text-sm mb-1 uppercase tracking-tighter font-semibold"
              >
                <span>Taninos</span>
                <span class="text-primary">Firmes</span>
              </div>
              <div
                class="h-2 w-full bg-primary/10 rounded-full overflow-hidden"
              >
                <div
                  class="h-full bg-primary rounded-full"
                  style="width: 85%"
                ></div>
              </div>
            </div>
            <!-- Corpo -->
            <div>
              <div
                class="flex justify-between text-sm mb-1 uppercase tracking-tighter font-semibold"
              >
                <span>Corpo</span>
                <span class="text-primary">Encorpado</span>
              </div>
              <div
                class="h-2 w-full bg-primary/10 rounded-full overflow-hidden"
              >
                <div
                  class="h-full bg-primary rounded-full"
                  style="width: 90%"
                ></div>
              </div>
            </div>
          </div>
        </section>
        <!-- Harmonização -->
        <section class="mt-10">
          <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
            <span class="material-symbols-outlined text-primary">flatware</span>
            Harmonização
          </h2>
          <div class="grid grid-cols-3 gap-3">
            <div
              class="bg-primary/5 border border-primary/10 rounded-lg p-3 text-center"
            >
              <span class="material-symbols-outlined text-primary mb-1"
                >set_meal</span
              >
              <p class="text-xs font-bold">Carnes Vermelhas</p>
            </div>
            <div
              class="bg-primary/5 border border-primary/10 rounded-lg p-3 text-center"
            >
              <span class="material-symbols-outlined text-primary mb-1"
                >bakery_dining</span
              >
              <p class="text-xs font-bold">Queijos Maturados</p>
            </div>
            <div
              class="bg-primary/5 border border-primary/10 rounded-lg p-3 text-center"
            >
              <span class="material-symbols-outlined text-primary mb-1"
                >dinner_dining</span
              >
              <p class="text-xs font-bold">Massas Intensas</p>
            </div>
          </div>
        </section>
        <!-- Storytelling Card -->
        <section
          class="mt-10 bg-primary/5 rounded-xl p-6 border-l-4 border-primary"
        >
          <h2 class="text-xl font-bold mb-3 font-display">
            História do Produtor
          </h2>
          <div class="prose prose-sm dark:prose-invert">
            <p
              class="text-slate-700 dark:text-slate-300 leading-relaxed mb-4 italic"
            >
              "Cada garrafa da nossa Riserva conta a história de três gerações
              da família Agnello, cuidando das mesmas videiras sob o sol da
              Toscana desde 1924."
            </p>
            <p class="text-slate-700 dark:text-slate-300 leading-relaxed">
              Colhido manualmente nas encostas de Montalcino, este vinho
              estagiou por 24 meses em barricas de carvalho francês de primeiro
              uso, resultando em uma complexidade inigualável que honra nossas
              raízes.
            </p>
          </div>
          <div class="mt-4 flex items-center gap-3">
            <div
              class="w-10 h-10 rounded-full overflow-hidden border border-primary/20"
            >
              <img
                alt="Giulio Agnello"
                class="w-full h-full object-cover"
                data-alt="Portrait of an elderly Italian winemaker"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBSUzLWxeoI5R5UL5W_gPo4ZBVy6uc2udQf3JepCLyIKpFETuIR8s0QbTy1NUiitKQqz5ZaSySa2UeRoGF6IRazTNyjdehF6qxM3RqoiwhEjBTzOpGZA45NfwQZ8Nc6ykck5-GYSJaorofC4gydqo8S0otE_oTnfQU_GyX7WLTC8Ue7fRd2dm2RaGMX_iG5In94o20i_lAUQdKSFk4JiEwTyLRwyN4wTvdj59reKR1egiDHv-tUL4Q0t0ZoE-l7H3ItHwvllTs4Bjif"
              />
            </div>
            <div>
              <p
                class="text-xs font-bold uppercase tracking-widest text-primary"
              >
                Giulio Agnello
              </p>
              <p class="text-[10px] text-slate-500">Mestre Enólogo</p>
            </div>
          </div>
        </section>
        <!-- Technical Specs -->
        <section class="mt-10 mb-8">
          <h2
            class="text-sm font-bold uppercase tracking-widest text-slate-400 mb-4"
          >
            Especificações Técnicas
          </h2>
          <div
            class="divide-y divide-primary/10 border-t border-b border-primary/10"
          >
            <div class="py-3 flex justify-between">
              <span class="text-sm text-slate-500">Uva</span>
              <span class="text-sm font-medium">100% Sangiovese</span>
            </div>
            <div class="py-3 flex justify-between">
              <span class="text-sm text-slate-500">Amadurecimento</span>
              <span class="text-sm font-medium">24 meses em carvalho</span>
            </div>
            <div class="py-3 flex justify-between">
              <span class="text-sm text-slate-500">Temperatura</span>
              <span class="text-sm font-medium">16°C a 18°C</span>
            </div>
            <div class="py-3 flex justify-between">
              <span class="text-sm text-slate-500">Guarda</span>
              <span class="text-sm font-medium">Até 15 anos</span>
            </div>
          </div>
        </section>
      </div>
    </main>
    <!-- Sticky Footer CTA -->
    <div
      class="fixed bottom-0 left-0 right-0 p-4 bg-background-light/90 dark:bg-background-dark/90 backdrop-blur-md border-t border-primary/10 z-50"
    >
      <div class="max-w-md mx-auto flex items-center justify-between gap-4">
        <div class="flex flex-col">
          <span class="text-xs text-slate-500 font-medium"
            >Preço por garrafa</span
          >
          <span class="text-2xl font-bold text-primary">R$ 489,00</span>
        </div>
        <button
          class="flex-1 bg-primary text-white font-bold py-4 rounded-lg flex items-center justify-center gap-2 hover:opacity-90 active:scale-95 transition-all shadow-lg shadow-primary/20"
        >
          <span class="material-symbols-outlined">shopping_bag</span>
          Adicionar ao Carrinho
        </button>
      </div>
    </div>
  </body>
</html>
