package controller.admin;

import controller.enums.LogLevel;
import dao.LogDAO;
import model.Account;
import model.Manufacturer;
import service.ManufacturerService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_manufacturer"})
public class ManageManufacturerController extends HttpServlet {

    @Inject
    private ManufacturerService manufacturerService;

    String action;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("manufacturers", manufacturerService.getAllManufacturer());
        doPost(request, response);
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
                    List<Manufacturer> results = manufacturerService.findManufacturerWithKeyword(keyword);
                    if (results == null) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", " Không tìm thấy thông tin ");
                    }
                    request.setAttribute("manufacturers", results);
                    request.getRequestDispatcher("/viewAdmin/manage_manufacturer.jsp").forward(request, response);
                    break;
                case "add":
                    String name = request.getParameter("name_manufacturer");
                    int row = manufacturerService.findManufacturerByName(name);
                    if (row == 1) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", " Tên nhà sản xuất đã tồn tại");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_manufacturer");
                        break;
                    }
                    isSuccessful = manufacturerService.insertManufacturer(name);
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.ALERT.toString(),"null",name,"Thêm hãng sản xuất");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thất bại");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_manufacturer");
                    break;
                case "showEdit":
                    int idManufacturerEdit = Integer.parseInt(request.getParameter("id"));
                    Manufacturer manufacturer = manufacturerService.findManufacturerById(idManufacturerEdit);
                    request.setAttribute("manufacturer", manufacturer);
                    request.getRequestDispatcher("/viewAdmin/manage_manufacturer.jsp").forward(request, response);
                    break;
                case "edit":
                    int idManufacturer = Integer.parseInt(request.getParameter("id"));
                    String nameManufacturer = request.getParameter("name");
                    Manufacturer manufacturer_before = new Manufacturer();
                    manufacturer_before = manufacturerService.findManufacturerById(idManufacturer);
                    isSuccessful = manufacturerService.alertManufacturer(idManufacturer, nameManufacturer);
                    Manufacturer manufacturer_after  = new Manufacturer();
                    manufacturer_after.setId(idManufacturer);
                    manufacturer_after.setNAME(nameManufacturer);
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.ALERT.toString(),manufacturer_before.toString(),manufacturer_after.toString(),"Sửa hãng sản xuất");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Lỗi!");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_manufacturer");
                    break;
                case "delete":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Manufacturer manufacturer_delete = manufacturerService.findManufacturerById(id);
                    try {
                        isSuccessful = manufacturerService.deleteManufacturer(id);

                    } catch (Exception e) {
                        isSuccessful = false;
                    }
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.ALERT.toString(),manufacturer_delete.toString(),"DELETE Success","Xóa hãng sản xuất");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Bạn cần xóa các thông tin có sử dụng tới hãng sản xuất này !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_manufacturer");
                    break;
            }
        } else {
            request.getRequestDispatcher("/viewAdmin/manage_manufacturer.jsp").forward(request, response);
        }
    }
}
