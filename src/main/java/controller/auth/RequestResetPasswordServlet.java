package controller.auth;

import service.EmailService;
import service.PasswordResetService;
import dao.EmailDAO;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class RequestResetPasswordServlet extends HttpServlet {
    private PasswordResetService passwordResetService;
    @Override
    public void init() throws ServletException {
        try {
            EmailDAO emailDAO = new EmailDAO();
            UserDAO userDAO = new UserDAO();
            EmailService emailService = new EmailService();
            this.passwordResetService = new PasswordResetService(emailDAO, userDAO);
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý thêm hoặc log lỗi để bạn có thể xác định vấn đề
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            req.getRequestDispatcher("/view/forgot_password.jsp").forward(req, resp);
        }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userEmail = req.getParameter("email");
        if (passwordResetService.emailExists(userEmail)) {
            passwordResetService.createAndSendResetCode(userEmail);
            req.getSession().setAttribute("userEmail", userEmail);
            resp.sendRedirect("/verify-reset-code");
        } else {
            req.setAttribute("errorEmail", "Email Này Hiện Chưa Được Đăng Ký");
            req.getRequestDispatcher("/view/forgot_password.jsp").forward(req, resp);
        }
    }
}
