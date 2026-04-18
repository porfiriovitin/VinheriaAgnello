package br.com.fiap.action.auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Shared authentication flow helpers.
 */
public final class AuthFlowSupport {
    private static final String POST_LOGIN_REDIRECT_ATTR = "postLoginRedirect";

    private AuthFlowSupport() {
    }

    public static void rememberActionRedirect(HttpServletRequest request, String actionName) {
        if (isBlank(actionName)) return;

        HttpSession session = request.getSession();
        String redirectTarget = request.getContextPath() + "/controller?action=" + actionName.trim();
        session.setAttribute(POST_LOGIN_REDIRECT_ATTR, redirectTarget);
    }

    public static String consumePostLoginRedirect(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String redirectTarget = (String) session.getAttribute(POST_LOGIN_REDIRECT_ATTR);
        session.removeAttribute(POST_LOGIN_REDIRECT_ATTR);
        return isBlank(redirectTarget) ? null : redirectTarget;
    }

    public static void clearPostLoginRedirect(HttpServletRequest request) {
        request.getSession().removeAttribute(POST_LOGIN_REDIRECT_ATTR);
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
