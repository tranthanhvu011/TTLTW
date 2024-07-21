package controller.admin;

import model.Account;
import service.UserService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin/user/update_user"})
public class UpdateUserController extends HttpServlet {

    @Inject
    private UserService userService;
    boolean isSuccess = false;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int idUser = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone_number");
        String gender = request.getParameter("selectedButton");
        String role = request.getParameter("role");
        String nameRole = "";
        if (Integer.parseInt(role) == 1) {
            nameRole = "admin";
        } else if (Integer.parseInt(role) == 2) {
            nameRole = "manage";
        }else{
            nameRole="user";
        }
        int is_active = Integer.parseInt(request.getParameter("is_active"));
        Account user = userService.getUserById(idUser);
        try {
            Map<String, Object> user1 = compareUser(user, email, firstName, lastName, address, dob, phone, gender, nameRole, is_active);
            if (user1.isEmpty()) {
                request.getSession().setAttribute("status", false);
                request.getSession().setAttribute("message", "Vui lòng nhập thông tin cần thay đổi");
                response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
            } else {
                isSuccess = userService.updateUserById(idUser, user1);
                if (isSuccess) {
                    request.getSession().setAttribute("status", true);
                    request.getSession().setAttribute("message", "Cập nhật thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
                } else {
                    request.getSession().setAttribute("status", false);
                    request.setAttribute("message", "Lỗi cập nhật người dùng!");
                    request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                }
            }
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    private Map<String, Object> compareUser(Account user, String email, String firstName, String lastName, String address, String dob, String phone, String gender, String role, int is_active) throws ParseException {

        Map<String, Object> value = new HashMap<>();

        if (email != null && !email.equals(user.getEmail())) {
            value.put("email", email);
        }
        if (firstName != null && !firstName.equals(user.getFirst_name())) {
            value.put("first_name", firstName);
        }
        if (lastName != null && !lastName.equals(user.getLast_name())) {
            value.put("last_name", lastName);
        }
        if (address != null && !address.equals(user.getAddress())) {
            value.put("address", address);
        }

        if (gender != null && !gender.isEmpty() && !(Integer.parseInt(gender) == user.getGender())) {
            value.put("gender", gender);
        }

        if (dob != null && !dob.equals(user.getDob().toString())) {
            Date date = Date.valueOf(dob);
        }
        if (phone != null && !phone.equals(user.getPhone_number())) {
            value.put("phone_number", phone);
        }

        if (role != null && !role.equals(user.getRole())) {
            value.put("role", role);
        }

        if (is_active != user.getIs_active()) {
            value.put("is_active", is_active);
        }

        System.out.println(value);

        return value;
    }
}
