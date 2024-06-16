package filter;

import helper.SecurityHelper;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String servletPath = request.getServletPath();
        System.out.println("Request Path: " + servletPath); // Logging

        // Thông tin người dùng đã được lưu trong Session
        // (Sau khi đăng nhập thành công).
        Account user = (Account) request.getSession().getAttribute("account");

        if (servletPath.equals("/login")) {
            filterChain.doFilter(request, response);
            return;
        }

        // Các trang bắt buộc phải đăng nhập.
        if (SecurityHelper.isSecurityPage(request)) {
            System.out.println("Security Page"); // Logging
            // Nếu người dùng chưa đăng nhập,
            // Redirect (chuyển hướng) tới trang đăng nhập.
            if (user == null) {
                request.getSession().setAttribute("message", "Bạn chưa đăng nhập");
                request.getSession().setAttribute("status", false);
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            // Kiểm tra người dùng có vai trò hợp lệ hay không?
            boolean hasPermission = SecurityHelper.hasPermission(request, user);
            if (!hasPermission) {
                request.getSession().setAttribute("message", "Bạn không có quyền truy cập vào trang web này");
                request.getSession().setAttribute("status", false);
                // Redirect tùy thuộc vào vai trò của người dùng
                if (user.getRole().equals("user")) {
                    response.sendRedirect(request.getContextPath() + "/home");
                } else if (user.getRole().equals("manage")) {
                    response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
                } else {
                    response.sendRedirect(request.getContextPath() + "/login");
                }
                return;
            }
        }

        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
