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
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/user/manage_user"})
public class ManageUserController extends HttpServlet {

    @Inject
    private UserService userService;

    int limit = 20;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int offset = 0;
        int numberProduct = userService.countNumberPage();
        int numberPage = (numberProduct / limit) + 1;
        int index = request.getParameter("index") != null ? Integer.parseInt(request.getParameter("index")) : 1;
        offset += (index-1) * limit;
        List<Account> users = userService.getAllUsers(limit,offset);
        request.setAttribute("currentIndex", index);
        request.setAttribute("numberPage", numberPage);
        String actionRequest = request.getParameter("action");
        request.setAttribute("users", users);
        if (actionRequest != null) {
            doPost(request, response);
        } else {
            request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isSuccess;
        int idUser = 0;
        Account user = null;
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (id != null) {
            idUser = Integer.parseInt(id);
            user = userService.getUserById(idUser);
        }
        switch (action) {
            case "active":
                isSuccess = activeUserById(idUser);
                if (isSuccess) {
                    request.getSession().setAttribute("status", true);
                    request.getSession().setAttribute("message", "Đã mở khóa một người dùng");
                    response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
                } else {
                    request.getSession().setAttribute("status", false);
                    request.getSession().setAttribute("message", "Lỗi!");
                    request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                }
                break;
            case "block":
                isSuccess = blockUserById(idUser);
                if (isSuccess) {
                    request.getSession().setAttribute("status", true);
                    request.getSession().setAttribute("message", "Đã khóa một người dùng");
                    response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
                } else {
                    request.getSession().setAttribute("status", false);
                    request.getSession().setAttribute("message", "Lỗi!");
                    request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                }
                break;
            case "alter":
                request.setAttribute("user", user);
                request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                break;
            case "delete":
                try {
                    isSuccess = userService.deleteUserById(idUser);
                    if (isSuccess) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Đã xóa một người dùng");
                        response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Lỗi!");
                        request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    request.getSession().setAttribute("status", false);
                    request.getSession().setAttribute("message", "Lỗi!");
                    request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                }
                break;
            case "add":
                try {
                    isSuccess = userService.save(getUserFromRequest(request));
                    if (isSuccess) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thêm người dùng thành công");
                        response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thêm người dùng lỗi");
                        request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "search":
                String keyword = request.getParameter("keyword");
                StringBuilder stringBuffer = new StringBuilder();
                if (keyword != null) {
                    stringBuffer.append("%").append(keyword).append("%");
                }
                List<Account> users = userService.searchUserWithCondition(stringBuffer.toString());
                if (users != null) {
                    request.setAttribute("users", users);
                    request.getRequestDispatcher("/viewAdmin/manage_user.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("status", false);
                    request.getSession().setAttribute("message", "Không tìm thấy kết quả");
                    response.sendRedirect(request.getContextPath() + "/admin/user/manage_user");
                }
                break;
        }
    }

    private boolean activeUserById(int idUser) {
        boolean isSuccess = false;
        try {
            isSuccess = userService.activeUserById(idUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    private boolean blockUserById(int idUser) {
        boolean isSuccess = false;
        try {
            isSuccess = userService.blockUserById(idUser);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    private Account getUserFromRequest(HttpServletRequest request) {
        Account user = new Account();
        user.setEmail(request.getParameter("email"));
        user.setFirst_name(request.getParameter("first_name"));
        user.setLast_name(request.getParameter("last_name"));
        user.setAddress(request.getParameter("address"));
        user.setDob(Date.valueOf(request.getParameter("dob")));
        user.setPhone_number(request.getParameter("phone_number"));
        user.setGender(Integer.parseInt(request.getParameter("selectedButton")));
        user.setRole(request.getParameter("role"));
        user.setIs_active(Integer.parseInt(request.getParameter("is_active")));
        user.setPassword(request.getParameter("pass"));
        return user;
    }


}
