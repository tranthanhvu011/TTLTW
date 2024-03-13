package filter;

import helper.SecurityHelper;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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

        // Thông tin người dùng đã được lưu trong Session
        // (Sau khi đăng nhập thành công).
        Account user = (Account) request.getSession().getAttribute("account");

        if (servletPath.equals("/login")) {
            filterChain.doFilter(request, response);
            return;
        }

//        if (user != null) {
//            // User Name
//            String userName = user.getFirst_name() + " " + user.getLast_name();
//
//            // Các vai trò (Role).
//            String roles = user.getRole();
//
//            // Gói request cũ bởi một Request mới với các thông tin userName và Roles.
////            wrapRequest = new UserRoleRequestWrapper(userName, roles, request);
//        }

        // Các trang bắt buộc phải đăng nhập.
        if (SecurityHelper.isSecurityPage(request)) {
            System.out.println("Security Page");
            // Nếu người dùng chưa đăng nhập,
            // Redirect (chuyển hướng) tới trang đăng nhập.
            if (user == null) {
                request.getSession().setAttribute("message", " Bạn chưa đăng nhap");
                request.getSession().setAttribute("status", false);
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Kiểm tra người dùng có vai trò hợp lệ hay không?
            boolean hasPermission = SecurityHelper.hasPermission(request, user);
            if (!hasPermission) {
                request.getSession().setAttribute("message", "Bạn không có quyền truy cập vào trang web này");
                request.getSession().setAttribute("status", false);
                response.sendRedirect(request.getContextPath() + "/home");
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
