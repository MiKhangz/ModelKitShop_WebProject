package Filter;

import Models.User;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
Vì sanity của tui nên tui xài filter chain chứ add từng cái chắc chết

From Khang
*/
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if user is logged in and is admin
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // User not logged in, redirect to login with original URL
            String originalUrl = httpRequest.getRequestURI();
            String qs = httpRequest.getQueryString();
            if (qs != null && !qs.isEmpty()) {
                originalUrl += "?" + qs;
            }
            String redirectParam = URLEncoder.encode(originalUrl, "UTF-8");
            String loginPage = httpRequest.getContextPath() + "/login?redirect=" + redirectParam;
            httpResponse.sendRedirect(loginPage);
            return;
        } else if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            // User is not admin, redirect to access denied page
            String accessDeniedPage = httpRequest.getContextPath() + "/views/user/access-denied.jsp";
            httpResponse.sendRedirect(accessDeniedPage);
            return;
        } else {
            // User is admin, continue with the request
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}

