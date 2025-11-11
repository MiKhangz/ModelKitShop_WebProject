package Filter;

import Models.User;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class AuthenticationFilter implements Filter {
    
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
        
        // Allow static and image-generation endpoints without auth
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        if (path.startsWith("/images/") || path.startsWith("/css/") || path.startsWith("/js/") ||
            path.startsWith("/favicon") || path.startsWith("/image/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (user == null) {
            // User not logged in, redirect to login page
            String loginPage = httpRequest.getContextPath() + "/login";
            httpResponse.sendRedirect(loginPage);
        } else {
            // User is logged in, continue with the request
            chain.doFilter(request, response);
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
