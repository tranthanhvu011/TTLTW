package controller.auth;

import Utils.ValidationUtils;
import dao.LoggingLogin;
import dao.UserDAO;
import model.Account;
import service.UserService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Inject
    private UserService userService;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LoggingLogin loggingLogin = new LoggingLogin();
        int count = loggingLogin.countLogging_Login("125.5.5.1");
        System.out.print(count);
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        List<String> error = new ArrayList<>();

        if (!ValidationUtils.isValidEmail(email)) {
            error.add("Email không hợp lệ ");
        }
        if (!ValidationUtils.isValidPassword(password)) {
            error.add("Nhập mật khẩu ít nhất 1 chữ hoa, 1 chữ thường, 1 kí tự đặc biệt @,#,% ... , 1 số");
        }
        Account user = userService.findUserByEmailAndPassword(email, password);
        LoggingLogin loggingLogin = new LoggingLogin();
        String ipUser = request.getRemoteUser();
        if (error.isEmpty()){
            int count = loggingLogin.countLogging_Login("125.5.5.1");
            if (count >= 5) {
                request.setAttribute("notLogin", "Ip của bạn đã b band do đăng nhập sai quá nhiều lần, hãy quay lại sau 30 phút");
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            }
            if (user == null) {
                request.setAttribute("error", "Email hoặc mật khẩu không đúng");
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
                System.out.print(count);

            } else if (user.getIs_active() == 0) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
                System.out.print(count);

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
        }else{
            int count = loggingLogin.countLogging_Login("125.5.5.1");
            if (count >= 5) {
                request.setAttribute("notLogin", "Ip của bạn đã b band do đăng nhập sai quá nhiều lần, hãy quay lại sau 30 phút");
                request.setAttribute("status", false); // Đảm bảo status phản ánh tình trạng này
                request.setAttribute("errors", error);
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            }else{
                request.setAttribute("errors", error);
                request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            }
            System.out.print(count);
        }
        LoggingLogin.Logging_Login(request, email, UserDAO.checkLogin(email, password));
    }
}
