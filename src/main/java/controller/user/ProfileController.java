package controller.user;

import model.Account;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet(urlPatterns = {"/profile"})

public class ProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService userService = new UserService();
        String action = req.getParameter("action");
        if ("submit".equals(action)) {
            HttpSession session = req.getSession();
            Account user = (Account) session.getAttribute("account"); // Lấy thông tin người dùng từ phiên làm việc hiện tại
            String email = (String) req.getSession().getAttribute("userEmailLogin");
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String phoneNumber = req.getParameter("phoneNumber");
            String address = req.getParameter("address");
            String dob = req.getParameter("dob");
            String gender = req.getParameter("gender");
            boolean updateSuccess = userService.updateProfile(email, firstName, lastName, address, phoneNumber, dob, gender);
            if (updateSuccess) {
                user.setFirst_name(firstName);
                user.setLast_name(lastName);
                user.setPhone_number(phoneNumber);
                user.setAddress(address);
                user.setDob(Date.valueOf(dob));
                user.setGender(Integer.parseInt(gender));
                req.setAttribute("thanhCongProfile", "Bạn đã cập nhập thành công thông tin cá nhân");
                req.getRequestDispatcher("/view/profile.jsp").forward(req, resp);
            }
        } else if ("cancel".equals(action)) {
            resp.sendRedirect("/home");
        }
    }

}
