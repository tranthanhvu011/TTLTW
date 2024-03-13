package controller.admin;

import model.Color;
import service.ColorService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_color"})
public class ManageColorController extends HttpServlet {
    @Inject
    private ColorService colorService;

    String action;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("colors", colorService.getAllColors());
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        action = request.getParameter("action");
        boolean isSuccessful;
        if (action != null) {
            switch (action) {
                case "search":
                    String keyword = request.getParameter("keyword");
                    List<Color> results = colorService.findColorWithKeyWord(keyword);
                    if (results == null) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không tìm thấy kết quả !");
                    }
                    request.setAttribute("colors", results);
                    request.getRequestDispatcher("/viewAdmin/manage_color.jsp").forward(request, response);
                    break;
                case "add":
                    String name = request.getParameter("name_color");
                    int idColorAdd = colorService.findColorByName(name);
                    if (idColorAdd == 1) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Màu sắc đã tồn tại !");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_color");
                        break;
                    }
                    isSuccessful = colorService.insertColor(name);
                    if (isSuccessful) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thêm thông tin thành công !");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thêm thông tin thất bại !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_color");
                    break;
                case "showEdit":
                    int idColorEdit = Integer.parseInt(request.getParameter("id"));
                    Color color = colorService.findColorById(idColorEdit);
                    request.setAttribute("color", color);
                    request.getRequestDispatcher("/viewAdmin/manage_color.jsp").forward(request, response);
                    break;
                case "edit":
                    int idColor = Integer.parseInt(request.getParameter("id"));
                    String nameColor = request.getParameter("name");
                    isSuccessful = colorService.editColor(idColor, nameColor);
                    if (isSuccessful) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Sửa thành công !");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Sửa thất bại !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_color");
                    break;
                case "delete":
                    int id = Integer.parseInt(request.getParameter("id"));
                    try {
                        isSuccessful = colorService.deleteColor(id);
                    } catch (Exception e) {
                        isSuccessful = false;
                        e.printStackTrace();
                    }
                    if (isSuccessful) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Xóa thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Bạn cần xóa các thông tin có sử dụng tới màu sắc này !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_color");
                    break;
            }
        } else {
            request.getRequestDispatcher("/viewAdmin/manage_color.jsp").forward(request, response);
        }
    }
}
