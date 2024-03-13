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

@WebServlet("/verify-reset-code")
public class VerifyResetCodeServlet extends HttpServlet {

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
        req.getRequestDispatcher("/view/enter-reset-code.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userEmail = (String) req.getSession().getAttribute("userEmail");
        String code = req.getParameter("resetCode");
        if (passwordResetService.verifyResetCode(userEmail, code)) {
            req.getSession().setAttribute("resetCode", code);
            resp.sendRedirect("/reset-password");
        } else {
            req.getSession().setAttribute("errorEnterCode", "Bạn Đã Nhập Sai Mã Xác Nhận");
            resp.sendRedirect("/view/enter-reset-code.jsp");
        }
    }

}
