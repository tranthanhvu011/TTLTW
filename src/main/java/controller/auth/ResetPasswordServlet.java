package controller.auth;

import service.EmailSender;
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

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private PasswordResetService passwordResetService;

    @Override
    public void init() throws ServletException {
        super.init();
        EmailDAO emailDAO = new EmailDAO();
        UserDAO userDAO = new UserDAO();
        EmailSender emailSender = new EmailSender();
        EmailService emailService = new EmailService();
        this.passwordResetService = new PasswordResetService(emailDAO, userDAO);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userEmail = (String) req.getSession().getAttribute("userEmail");
        String code = (String) req.getSession().getAttribute("resetCode");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");


        // Kiểm tra xem session còn tồn tại email hay không.
        if (userEmail == null || userEmail.isEmpty()) {
            req.setAttribute("errorSession", "Vui Lòng Gửi Form Quên Mật Khẩu Lại Từ Đầu");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("errorconfirm", "Mật Khẩu Không Trùng Nhau Vui Lòng Nhập Lại");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
            return;
        }
        if (passwordResetService.resetPassword(userEmail, code, newPassword)) {
            req.getSession().invalidate(); // Clear the session
            resp.sendRedirect("/home");
        } else {
            req.getSession().setAttribute("errorResetPassword", "Failed to reset password. Please try again.");
            req.getRequestDispatcher("/view/reset-password.jsp").forward(req, resp);
        }
    }
}
