<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html lang="pt-BR"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Vinheria Agnello - Sommelier Digital</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,400;0,700;1,400&amp;family=Noto+Sans:wght@400;500;600&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
        h1, h2, h3, .font-serif {
            font-family: 'Noto Serif', serif;
        }
        .radio-custom:checked + div {
            border-color: #490e0e;
            background-color: rgba(73, 14, 14, 0.05);
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen flex flex-col">
<!-- Top Navigation Bar -->
<header class="flex items-center justify-between p-4 md:px-8 border-b border-primary/10 bg-background-light/80 dark:bg-background-dark/80 backdrop-blur-md sticky top-0 z-50">
<button class="flex items-center justify-center p-2 hover:bg-primary/5 rounded-full transition-colors">
<span class="material-symbols-outlined text-primary dark:text-slate-100">close</span>
</button>
<h1 class="text-primary dark:text-slate-100 text-lg font-bold tracking-tight font-serif">Vinheria Agnello</h1>
<button class="flex items-center justify-center p-2 hover:bg-primary/5 rounded-full transition-colors">
<span class="material-symbols-outlined text-primary dark:text-slate-100">help_outline</span>
</button>
</header>
<!-- Progress Indicator -->
<div class="px-4 py-6 md:px-8 max-w-2xl mx-auto w-full">
<div class="flex items-center justify-between mb-2">
<span class="text-xs font-semibold uppercase tracking-wider text-primary/60 dark:text-slate-400">Passo 1 de 4</span>
<span class="text-xs font-bold text-primary dark:text-slate-200">25%</span>
</div>
<div class="h-1.5 w-full bg-primary/10 dark:bg-white/10 rounded-full overflow-hidden">
<div class="h-full bg-primary dark:bg-primary w-1/4 rounded-full"></div>
</div>
</div>
<!-- Main Content Area -->
<main class="flex-grow flex flex-col items-center px-4 pb-12 max-w-2xl mx-auto w-full">
<!-- Mr. Giulio Persona Section -->
<section class="flex flex-col items-center text-center mb-10 mt-4">
<div class="relative mb-4">
<div class="w-24 h-24 md:w-28 md:h-28 rounded-full border-2 border-primary/20 p-1">
<div class="w-full h-full rounded-full bg-cover bg-center shadow-inner" data-alt="Retrato elegante de um sommelier experiente sorrindo" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCwl2XE6MYZFXtJtDa_jlkmpcM5QmvISkNMmwE7lZaG3HOkqYAn5owu-XcTghPlPAc8fEWnb0_Vd9oJHnvLRCr7sLxj4u8cy7dwmx6Iq2HDBJoKkk8q-37fWp-BZPb5bTDJBHoi83f1L8UkBV2Cl7H-10ObgRJeKFDH7gbbzT0-GuJ-X-jEzIk9yXfpfufruABQQsM5W5JdhfTTpWLq6h016lEb3_A6gjEilbSXzIXPMnB7w50lFf1kQxNr9cbiNksmJgFBj7CK7G2D')">
</div>
</div>
<div class="absolute -bottom-1 -right-1 bg-primary text-white p-1 rounded-full border-2 border-background-light dark:border-background-dark">
<span class="material-symbols-outlined text-sm block">verified</span>
</div>
</div>
<div class="space-y-2">
<h2 class="text-xl font-bold font-serif text-primary dark:text-slate-100">Sr. Giulio</h2>
<p class="italic text-slate-600 dark:text-slate-400 text-base leading-relaxed max-w-md">
                    "Bem-vindo à minha adega. Para começarmos nossa jornada, diga-me: qual o motivo da celebração hoje?"
                </p>
</div>
</section>
<!-- Question Title -->
<h3 class="text-2xl md:text-3xl font-serif font-bold text-center mb-8 text-slate-900 dark:text-slate-100">
            Qual a ocasião?
        </h3>
<!-- Options Form -->
<form class="w-full grid gap-4">
<!-- Option 1 -->
<label class="relative cursor-pointer group">
<input checked="" class="peer sr-only radio-custom" name="occasion" type="radio"/>
<div class="flex items-center p-5 border-2 border-primary/10 dark:border-white/10 rounded-xl bg-white dark:bg-white/5 transition-all duration-200 hover:border-primary/30 peer-checked:border-primary peer-checked:bg-primary/5 dark:peer-checked:bg-primary/20">
<div class="flex-shrink-0 w-12 h-12 flex items-center justify-center bg-primary/5 dark:bg-primary/20 rounded-lg text-primary dark:text-slate-100 mr-4">
<span class="material-symbols-outlined text-2xl">favorite</span>
</div>
<div class="flex-grow">
<p class="font-bold text-slate-900 dark:text-slate-100">Jantar Romântico</p>
<p class="text-sm text-slate-500 dark:text-slate-400">Uma noite a dois inesquecível e intimista</p>
</div>
<div class="flex-shrink-0 ml-2">
<div class="w-5 h-5 rounded-full border-2 border-primary/20 peer-checked:border-primary flex items-center justify-center">
<div class="w-2.5 h-2.5 rounded-full bg-primary opacity-0 peer-checked:opacity-100 transition-opacity"></div>
</div>
</div>
</div>
</label>
<!-- Option 2 -->
<label class="relative cursor-pointer group">
<input class="peer sr-only radio-custom" name="occasion" type="radio"/>
<div class="flex items-center p-5 border-2 border-primary/10 dark:border-white/10 rounded-xl bg-white dark:bg-white/5 transition-all duration-200 hover:border-primary/30 peer-checked:border-primary peer-checked:bg-primary/5 dark:peer-checked:bg-primary/20">
<div class="flex-shrink-0 w-12 h-12 flex items-center justify-center bg-primary/5 dark:bg-primary/20 rounded-lg text-primary dark:text-slate-100 mr-4">
<span class="material-symbols-outlined text-2xl">featured_seasonal_and_gifts</span>
</div>
<div class="flex-grow">
<p class="font-bold text-slate-900 dark:text-slate-100">Presente Especial</p>
<p class="text-sm text-slate-500 dark:text-slate-400">Para surpreender alguém querido com elegância</p>
</div>
<div class="flex-shrink-0 ml-2">
<div class="w-5 h-5 rounded-full border-2 border-primary/20 peer-checked:border-primary flex items-center justify-center">
<div class="w-2.5 h-2.5 rounded-full bg-primary opacity-0 peer-checked:opacity-100 transition-opacity"></div>
</div>
</div>
</div>
</label>
<!-- Option 3 -->
<label class="relative cursor-pointer group">
<input class="peer sr-only radio-custom" name="occasion" type="radio"/>
<div class="flex items-center p-5 border-2 border-primary/10 dark:border-white/10 rounded-xl bg-white dark:bg-white/5 transition-all duration-200 hover:border-primary/30 peer-checked:border-primary peer-checked:bg-primary/5 dark:peer-checked:bg-primary/20">
<div class="flex-shrink-0 w-12 h-12 flex items-center justify-center bg-primary/5 dark:bg-primary/20 rounded-lg text-primary dark:text-slate-100 mr-4">
<span class="material-symbols-outlined text-2xl">outdoor_grill</span>
</div>
<div class="flex-grow">
<p class="font-bold text-slate-900 dark:text-slate-100">Churrasco com Amigos</p>
<p class="text-sm text-slate-500 dark:text-slate-400">Carnes nobres, risadas e boa companhia</p>
</div>
<div class="flex-shrink-0 ml-2">
<div class="w-5 h-5 rounded-full border-2 border-primary/20 peer-checked:border-primary flex items-center justify-center">
<div class="w-2.5 h-2.5 rounded-full bg-primary opacity-0 peer-checked:opacity-100 transition-opacity"></div>
</div>
</div>
</div>
</label>
<!-- Option 4 -->
<label class="relative cursor-pointer group">
<input class="peer sr-only radio-custom" name="occasion" type="radio"/>
<div class="flex items-center p-5 border-2 border-primary/10 dark:border-white/10 rounded-xl bg-white dark:bg-white/5 transition-all duration-200 hover:border-primary/30 peer-checked:border-primary peer-checked:bg-primary/5 dark:peer-checked:bg-primary/20">
<div class="flex-shrink-0 w-12 h-12 flex items-center justify-center bg-primary/5 dark:bg-primary/20 rounded-lg text-primary dark:text-slate-100 mr-4">
<span class="material-symbols-outlined text-2xl">wine_bar</span>
</div>
<div class="flex-grow">
<p class="font-bold text-slate-900 dark:text-slate-100">Degustação Solo</p>
<p class="text-sm text-slate-500 dark:text-slate-400">Um momento de relaxamento e apreciação</p>
</div>
<div class="flex-shrink-0 ml-2">
<div class="w-5 h-5 rounded-full border-2 border-primary/20 peer-checked:border-primary flex items-center justify-center">
<div class="w-2.5 h-2.5 rounded-full bg-primary opacity-0 peer-checked:opacity-100 transition-opacity"></div>
</div>
</div>
</div>
</label>
</form>
<!-- Navigation Buttons -->
<div class="w-full mt-10 space-y-4">
<button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-4 rounded-lg shadow-lg shadow-primary/20 transition-all flex items-center justify-center gap-2">
                Continuar para o Perfil de Sabor
                <span class="material-symbols-outlined">arrow_forward</span>
</button>
<button class="w-full bg-transparent hover:bg-primary/5 text-primary dark:text-slate-300 font-semibold py-3 rounded-lg transition-colors text-sm">
                Prefiro escolher sozinho por enquanto
            </button>
</div>
</main>
<!-- Footer Decoration -->
<footer class="p-8 text-center opacity-40">
<div class="inline-block border-t border-primary/20 pt-4 px-8">
<p class="text-xs uppercase tracking-[0.2em] font-serif text-primary dark:text-slate-400">Agnello Dal 1984</p>
</div>
</footer>
</body></html>