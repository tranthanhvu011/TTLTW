package controller.admin;

import controller.enums.LogLevel;
import dao.LogDAO;
import model.Account;
import model.Capacity;
import model.Manufacturer;
import service.CapacityService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_capacity"})
public class ManageCapacityController extends HttpServlet {
    @Inject
    private CapacityService capacityService;

    String action;


    int limit = 1000;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("capacities", capacityService.getAllCapacities());
        request.getRequestDispatcher("/viewAdmin/manage_capacity.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ip = request.getRemoteAddr();
        Account account = (Account) request.getSession().getAttribute("account");
        action = request.getParameter("action");
        boolean isSuccessful;
        if (action != null) {
            switch (action) {
                case "search":
                    String keyword = request.getParameter("keyword");
                    List<Capacity> results = capacityService.findCapacityWithKeyWord(keyword);
                    if (results.isEmpty()) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không tìm thấy kết quả !");
                    }
                    request.setAttribute("capacities", results);
                    request.getRequestDispatcher("/viewAdmin/manage_capacity.jsp").forward(request, response);
                    break;
                case "add":
                    String name = request.getParameter("name_capacity");
                    int row = capacityService.findCapacityByName(name);
                    if (row == 1) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Tên dung lượng đã tồn tại !");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_capacity");
                        break;
                    }
                    isSuccessful = capacityService.insertCapacity(name);
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.ALERT.toString(),"null",name,"Thêm dung lượng");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thêm thông tin thành công !");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thêm thông tin thất bại !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_capacity");
                    break;
                case "showEdit":
                    int idCapacityEdit = Integer.parseInt(request.getParameter("id"));
                    Capacity capacity = capacityService.findCapacityById(idCapacityEdit);
                    request.setAttribute("capacity", capacity);
                    request.getRequestDispatcher("/viewAdmin/manage_capacity.jsp").forward(request, response);
                    break;
                case "edit":
                    int idCapacity = Integer.parseInt(request.getParameter("id"));
                    String nameCapacity = request.getParameter("name");
                    isSuccessful = capacityService.alertCapacity(idCapacity, nameCapacity);
                    Capacity capacity_before = capacityService.findCapacityById(idCapacity);
                    Capacity capacity_after = new Capacity();
                    capacity_after.setId(idCapacity);
                    capacity_after.setName(nameCapacity);
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.ALERT.toString(),capacity_before.toString(),capacity_after.toString(),"Chỉnh sửa dung lượng");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Sửa thành công !");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Sửa thất bại !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_capacity");
                    break;
                case "delete":

                    int id = Integer.parseInt(request.getParameter("id"));
                    Capacity capacity_delete = capacityService.findCapacityById(id);
                    try {
                        isSuccessful = capacityService.deleteCapacity(id);
                    } catch (Exception e) {
                        isSuccessful = false;
                    }
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.DANGER.toString(),capacity_delete.toString(),"Delete Success","Xóa dung dượng");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Xóa thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Bạn cần xóa các thông tin có sử dụng tới dung lượng này !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_capacity");
                    break;
            }
        } else {
            request.getRequestDispatcher("/viewAdmin/manage_capacity.jsp").forward(request, response);
        }
    }
}
