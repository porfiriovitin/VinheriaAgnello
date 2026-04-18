<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String action = request.getParameter("action");

    String activeClass = "text-primary";
    String inactiveClass = "text-slate-400";

    boolean isIndex = "ShowIndex".equals(action);
    boolean isCatalog = "ShowCatalog".equals(action);
    boolean isClub = "ShowClub".equals(action);
%>

<nav class="fixed bottom-0 left-0 right-0 bg-background-light dark:bg-background-dark border-t border-primary/10 px-4 py-2 flex justify-between items-center z-50">
    <a class="flex flex-col items-center gap-1 <%= isIndex ? activeClass : inactiveClass %>"
       href="${pageContext.request.contextPath}/controller?action=ShowIndex">
        <span class="material-symbols-outlined <%= isIndex ? "fill-1" : "" %>">home</span>
        <span class="text-[10px] font-bold uppercase tracking-tighter">Início</span>
    </a>

    <a class="flex flex-col items-center gap-1 <%= isCatalog ? activeClass : inactiveClass %>"
       href="${pageContext.request.contextPath}/controller?action=ShowCatalog">
        <span class="material-symbols-outlined <%= isCatalog ? "fill-1" : "" %>">liquor</span>
        <span class="text-[10px] font-bold uppercase tracking-tighter">Catalogo</span>
    </a>

    <a class="flex flex-col items-center gap-1 <%= isClub ? activeClass : inactiveClass %>" href="${pageContext.request.contextPath}/controller?action=ShowClub">
        <span class="material-symbols-outlined <%= isClub ? "fill-1" : "" %>">stars</span>
        <span class="text-[10px] font-bold uppercase tracking-tighter">Club</span>
    </a>

    <a class="flex flex-col items-center gap-1 <%= inactiveClass %>" href="${pageContext.request.contextPath}/controller?action=ShowLogin">
        <span class="material-symbols-outlined">person</span>
        <span class="text-[10px] font-bold uppercase tracking-tighter">Perfil</span>
    </a>
</nav>
