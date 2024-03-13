package controller.auth;

import service.EmailSender;
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
import java.sql.Date;
import java.sql.SQLException;

import static java.lang.Integer.parseInt;
import static java.sql.Date.valueOf;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private PasswordResetService passwordResetService;
    UserService userService = new UserService();
    EmailService emailService = new EmailService();

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
        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Account user = new Account();
            user.setFirst_name(req.getParameter("first_name"));
            user.setLast_name(req.getParameter("last_name"));
            user.setEmail(req.getParameter("email"));
            user.setPhone_number(req.getParameter("phone_number"));
            user.setAddress(req.getParameter("address"));
            user.setGender(parseInt(req.getParameter("gender")));
            user.setDob(valueOf(req.getParameter("dob")));
            user.setPassword(req.getParameter("password"));
            String re_password = req.getParameter("re-password");
            if (!user.getPassword().equals(re_password)) {
                req.setAttribute("passwordNo", "Mật Khẩu Không Trùng Nhau Vui Lòng Nhập Lại");
                req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                return;
            } else if (!userService.checkUserEmail(user.getEmail())) {
                req.setAttribute("emailNotNull", "Email đã có người đăng ký");
                req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            } else {
                userService.save(user);
                if (passwordResetService.emailExists(user.getEmail())) {
                    passwordResetService.createAndSendResetCode(user.getEmail());
                    req.getSession().setAttribute("userEmailRegister", user.getEmail());
                    resp.sendRedirect("/view/enter_Code_Register.jsp");
                } else {
                    req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

