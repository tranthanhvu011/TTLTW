package controller.auth;

import model.Account;
import service.UserService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Inject
    private UserService userService;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Account user = userService.findUserByEmailAndPassword(email, password);
        if (user == null) {
            request.setAttribute("error", "Email hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        } else if (user.getIs_active() == 0) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("account", user);
            request.getSession().setAttribute("nameAccount", user.getFirst_name() + " " + user.getLast_name());
            request.getSession().setAttribute("userEmailLogin", user.getEmail());
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }
}
