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
        <a href="/controller?action=ShowIndex" class="flex items-center gap-3 px-3 py-3 rounded-lg ${activeMenu == 'home' ? 'text-primary bg-primary/5 font-semibold' : 'text-slate-700 hover:bg-primary/5 transition-colors'}">
            <span class="material-symbols-outlined">home</span>Início
        </a>

        <a href="/controller?action=ShowCatalog" class="flex items-center gap-3 px-3 py-3 rounded-lg ${activeMenu == 'catalog' ? 'text-primary bg-primary/5 font-semibold' : 'text-slate-700 hover:bg-primary/5 transition-colors'}">
            <span class="material-symbols-outlined">liquor</span>Todos os Vinhos
        </a>

        <a href="/controller?action=ShowSommelier" class="flex items-center gap-3 px-3 py-3 rounded-lg ${activeMenu == 'sommelier' ? 'text-primary bg-primary/5 font-semibold' : 'text-slate-700 hover:bg-primary/5 transition-colors'}">
            <span class="material-symbols-outlined">stars</span>Sommelier Digital
        </a>

        <a href="/controller?action=ShowCartCheckout" class="flex items-center gap-3 px-3 py-3 rounded-lg ${activeMenu == 'cart' ? 'text-primary bg-primary/5 font-semibold' : 'text-slate-700 hover:bg-primary/5 transition-colors'}">
            <span class="material-symbols-outlined">shopping_bag</span>Carrinho
        </a>

        <a href="/controller?action=ShowLogin" class="flex items-center gap-3 px-3 py-3 rounded-lg ${activeMenu == 'login' ? 'text-primary bg-primary/5 font-semibold' : 'text-slate-700 hover:bg-primary/5 transition-colors'}">
            <span class="material-symbols-outlined">person</span>Entrar
        </a>

        <a href="/controller?action=ShowSignup" class="flex items-center gap-3 px-3 py-3 rounded-lg ${activeMenu == 'signup' ? 'text-primary bg-primary/5 font-semibold' : 'text-slate-700 hover:bg-primary/5 transition-colors'}">
            <span class="material-symbols-outlined">person_add</span>Criar conta
        </a>
    </nav>
</aside>