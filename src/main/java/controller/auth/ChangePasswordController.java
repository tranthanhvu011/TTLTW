package controller.auth;

import model.Account;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/change_password")

public class ChangePasswordController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/change_pw.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = new UserService();
        String old_password = req.getParameter("old_password");
        String new_password = req.getParameter("new_password");
        String verify_password = req.getParameter("verify_new_password");
        String email = (String) req.getSession().getAttribute("userEmailLogin");
        // Kiểm tra xem session còn tồn tại email hay không.
        if (email == null || email.isEmpty()) {
            req.setAttribute("errorSessionLogin", "Vui Lòng Đăng Nhập Lại");
            req.getRequestDispatcher("/view/home.jsp").forward(req, resp);
            return;
        }
        if (!new_password.equals(verify_password)) {
            req.setAttribute("nhapLaiMatKhauSai", "Mật Khẩu Mới Và Nhập Lại Mật Khẩu Mới Phải Trùng Nhau - Vui Lòng Nhập Lại");
            req.getRequestDispatcher("/view/change_pw.jsp").forward(req, resp);
            return;
        }
        if (userService.updatePasswordChange(email, old_password, new_password)) {
            req.setAttribute("thanhCongChangePassword", "Bạn đã đổi mật khẩu thành công");
            req.getRequestDispatcher("/view/change_pw.jsp").forward(req, resp);
        } else {
            req.setAttribute("thatBaiChangePassword", "Mật Khẩu Cũ Bạn Nhập Đã Sai");
            req.getRequestDispatcher("/view/change_pw.jsp").forward(req, resp);
        }
    }

}

