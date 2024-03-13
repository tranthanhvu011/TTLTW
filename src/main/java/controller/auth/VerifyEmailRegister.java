package controller.auth;

import service.EmailService;
import service.PasswordResetService;
import service.UserService;
import dao.EmailDAO;
import dao.UserDAO;
import model.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/confirm")
public class VerifyEmailRegister extends HttpServlet {
    UserService userService;
    private PasswordResetService passwordResetService;
    EmailDAO emailDAO;
    @Override
    public void init() throws ServletException {
        try {
            EmailDAO emailDAO = new EmailDAO();
            UserDAO userDAO = new UserDAO();
            EmailService emailService = new EmailService();
            this.userService = new UserService();

            this.passwordResetService = new PasswordResetService(emailDAO, userDAO);
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý thêm hoặc log lỗi để bạn có thể xác định vấn đề
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/enter_Code_Register.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String registeredEmail = (String) session.getAttribute("userEmailRegister");
        String resetCode = request.getParameter("confirmationCode");
        if (passwordResetService.verifyResetCode(registeredEmail, resetCode)) {
            userService.activateAccount(registeredEmail);
            request.getSession().invalidate();
            response.sendRedirect("/home");
        } else {
            request.setAttribute("CodeFalse", "Mã Code Đã Nhập Sai");
            request.getRequestDispatcher("/view/enter_Code_Register.jsp").forward(request, response);
        }
    }
}
