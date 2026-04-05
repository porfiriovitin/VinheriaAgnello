<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />

  <title><c:out value="${wine.name}" /> \- Vinheria Agnello</title>

  <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Serif:wght@400;700&amp;family=Noto+Sans:wght@400;500;600&amp;display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet" />

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
    body { font-family: "Noto Sans", sans-serif; }
    h1, h2, h3, .font-display { font-family: "Noto Serif", serif; }
    .glass-header {
      background: rgba(248, 246, 246, 0.8);
      -webkit-backdrop-filter: blur(8px);
      backdrop-filter: blur(8px);
    }
    body { min-height: max(884px, 100dvh); }
  </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">

<nav class="fixed top-0 left-0 right-0 z-50 glass-header border-b border-primary/10 px-4 py-3 flex items-center justify-between">
  <button type="button" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-primary/5 transition-colors" onclick="history.back()">
    <span class="material-symbols-outlined text-primary">arrow_back</span>
  </button>

  <span class="font-display font-bold text-lg tracking-tight">Vinheria Agnello</span>

  <button type="button" class="w-10 h-10 flex items-center justify-center rounded-full hover:bg-primary/5 transition-colors">
    <span class="material-symbols-outlined text-primary">favorite</span>
  </button>
</nav>

<main class="pt-16 pb-32">
  <section class="relative bg-white dark:bg-slate-900 overflow-hidden">
    <div class="aspect-[3/4] w-full relative group cursor-zoom-in">
      <img
        alt="Imagem do produto"
        class="w-full h-full object-cover"
        src="<c:out value='${wine.imageURL}' />"
      />
      <div class="absolute bottom-4 right-4 bg-white/80 backdrop-blur-md p-2 rounded-full shadow-lg">
        <span class="material-symbols-outlined text-primary">zoom_in</span>
      </div>
    </div>
  </section>

  <div class="px-6 -mt-8 relative z-10">
    <div class="bg-background-light dark:bg-background-dark rounded-xl p-6 shadow-sm border border-primary/5">
      <div class="flex items-center gap-2 mb-2">
        <div class="inline-flex items-center gap-1 px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-bold uppercase tracking-wider">
          <span class="material-symbols-outlined text-sm leading-none">verified</span>
          Recomendação do Giulio
        </div>
      </div>

      <h1 class="text-3xl font-bold text-slate-900 dark:text-slate-100 mb-1">
        <c:out value="${wine.name}" />
      </h1>

      <p class="text-primary font-medium text-lg mb-4">
        <c:out value="${wine.type}" /> • <c:out value="${wine.region}" />, <c:out value="${wine.country}" />
      </p>

      <div class="flex items-center gap-4 text-sm text-slate-600 dark:text-slate-400">
        <div class="flex items-center gap-1">
          <span class="material-symbols-outlined text-yellow-600 text-sm">star</span>
          <span class="font-bold text-slate-900 dark:text-slate-100">
            <fmt:formatNumber value="${wine.userRatings}" minFractionDigits="1" maxFractionDigits="1" />
          </span>
          <span>(<c:out value="${wine.amountRatings}" /> avaliações)</span>
        </div>

        <div class="w-px h-4 bg-slate-300"></div>

        <div class="flex items-center gap-1">
          <span class="material-symbols-outlined text-sm">percent</span>
          <span>
            <fmt:formatNumber value="${wine.alcoholPercentage}" minFractionDigits="1" maxFractionDigits="1" />
          </span>
        </div>
      </div>
    </div>

    <section class="mt-8">
      <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
        <span class="material-symbols-outlined text-primary">local_bar</span>
        Notas Aromáticas
      </h2>

      <div class="flex gap-4 overflow-x-auto pb-4 no-scrollbar justify-center">
        <c:forEach items="${wine.aromaticNotes}" var="note">
          <div class="flex-shrink-0 flex flex-col items-center gap-2 w-24">
            <div class="w-16 h-16 rounded-full bg-primary/5 flex items-center justify-center border border-primary/10">
              <span class="material-symbols-outlined text-primary text-3xl">
                <c:out value="${note.materialSymbol}" />
              </span>
            </div>
            <span class="text-xs font-medium text-center"><c:out value="${note.title}" /></span>
          </div>
        </c:forEach>

        <c:if test="${empty wine.aromaticNotes}">
          <p class="text-sm text-slate-500">Sem notas aromáticas cadastradas.</p>
        </c:if>
      </div>
    </section>

    <section class="mt-8 space-y-6">
      <h2 class="text-xl font-bold flex items-center gap-2">
        <span class="material-symbols-outlined text-primary">monitoring</span>
        Perfil de Sabor
      </h2>

      <c:set var="acidity" value="${wine.flavorProfile.acidity}" />
      <c:set var="tannins" value="${wine.flavorProfile.tannins}" />
      <c:set var="body" value="${wine.flavorProfile.body}" />

      <div class="space-y-4">
        <div>
          <div class="flex justify-between text-sm mb-1 uppercase tracking-tighter font-semibold">
            <span>Acidêz</span>
            <span class="text-primary"><c:out value="${acidity}" /></span>
          </div>
          <div class="h-2 w-full bg-primary/10 rounded-full overflow-hidden">
            <div class="h-full bg-primary rounded-full" style="width: ${acidity}%;"></div> <!-- 0-100% fill -->
          </div>
        </div>

        <div>
          <div class="flex justify-between text-sm mb-1 uppercase tracking-tighter font-semibold">
            <span>Taninos</span>
            <span class="text-primary"><c:out value="${tannins}" /></span>
          </div>
          <div class="h-2 w-full bg-primary/10 rounded-full overflow-hidden">
            <div class="h-full bg-primary rounded-full" style="width: ${tannins}%;"></div> <!-- 0-100% fill -->
          </div>
        </div>

        <div>
          <div class="flex justify-between text-sm mb-1 uppercase tracking-tighter font-semibold">
            <span>Corpo</span>
            <span class="text-primary"><c:out value="${body}" /></span>
          </div>
          <div class="h-2 w-full bg-primary/10 rounded-full overflow-hidden">
            <div class="h-full bg-primary rounded-full" style="width: ${body}%;"></div> <!-- 0-100% fill -->
          </div>
        </div>

        <c:if test="${empty wine.flavorProfile}">
          <p class="text-sm text-slate-500">Sem perfil de sabor cadastrado.</p>
        </c:if>
      </div>
    </section>

    <section class="mt-10">
      <h2 class="text-xl font-bold mb-4 flex items-center gap-2">
        <span class="material-symbols-outlined text-primary">flatware</span>
        Harmonização
      </h2>

      <div class="grid grid-cols-3 gap-3 justify-items-center"> <!-- Centralized -->
        <c:forEach items="${wine.harmonization}" var="harm">
          <div class="bg-primary/5 border border-primary/10 rounded-lg p-3 text-center">
            <span class="material-symbols-outlined text-primary mb-1"><c:out value="${harm.materialSymbol}" /></span>
            <p class="text-xs font-bold"><c:out value="${harm.title}" /></p>
          </div>
        </c:forEach>

        <c:if test="${empty wine.harmonization}">
          <p class="text-sm text-slate-500 col-span-3">Sem harmonizações cadastradas.</p>
        </c:if>
      </div>
    </section>

    <section class="mt-10 bg-primary/5 rounded-xl p-6 border-l-4 border-primary">
      <h2 class="text-xl font-bold mb-3 font-display">História do Produtor</h2>
      <div class="prose prose-sm dark:prose-invert">
        <p class="text-slate-700 dark:text-slate-300 leading-relaxed">
          <c:out value="${fn:replace(wine.productorLore, '.', '.<br>')}" escapeXml="false" />
        </p>
      </div>
    </section>

    <section class="mt-10 mb-8">
      <h2 class="text-sm font-bold uppercase tracking-widest text-slate-400 mb-4">Especificações Técnicas</h2>

      <div class="divide-y divide-primary/10 border-t border-b border-primary/10">
        <div class="py-3 flex justify-between">
          <span class="text-sm text-slate-500">Uva</span>
          <span class="text-sm font-medium"><c:out value="${wine.specifications.grape}" /></span>
        </div>
        <div class="py-3 flex justify-between">
          <span class="text-sm text-slate-500">Amadurecimento</span>
          <span class="text-sm font-medium"><c:out value="${wine.specifications.ripening}" /></span>
        </div>
        <div class="py-3 flex justify-between">
          <span class="text-sm text-slate-500">Temperatura</span>
          <span class="text-sm font-medium"><c:out value="${wine.specifications.temperature}" /></span>
        </div>
        <div class="py-3 flex justify-between">
          <span class="text-sm text-slate-500">Guarda</span>
          <span class="text-sm font-medium"><c:out value="${wine.specifications.keeper}" /></span>
        </div>

        <c:if test="${empty wine.specifications}">
          <div class="py-3">
            <span class="text-sm text-slate-500">Sem especificações cadastradas\.</span>
          </div>
        </c:if>
      </div>
    </section>

  </div>
</main>

<div class="fixed bottom-0 left-0 right-0 p-4 bg-background-light/90 dark:bg-background-dark/90 backdrop-blur-md border-t border-primary/10 z-50">
  <div class="max-w-md mx-auto flex items-center justify-between gap-4">
    <div class="flex flex-col">
      <span class="text-xs text-slate-500 font-medium">Preço por garrafa</span>
      <span class="text-2xl font-bold text-primary">
        <fmt:setLocale value="pt_BR" />
        <fmt:formatNumber value="${wine.price}" type="currency" currencySymbol="R\$ " />
      </span>
    </div>

    <button class="flex-1 bg-primary text-white font-bold py-4 rounded-lg flex items-center justify-center gap-2 hover:opacity-90 active:scale-95 transition-all shadow-lg shadow-primary/20">
      <span class="material-symbols-outlined">shopping_bag</span>
      Adicionar ao Carrinho
    </button>
  </div>
</div>

</body>
</html>
