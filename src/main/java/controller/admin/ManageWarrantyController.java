package controller.admin;

import controller.enums.LogLevel;
import dao.LogDAO;
import model.Account;
import model.InfoWarranty;
import service.WarrantyService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_warranty"})
public class ManageWarrantyController extends HttpServlet {
    @Inject
    private WarrantyService warrantyService;

    String action;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("warranties", warrantyService.getAllWarranty());
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
                    List<InfoWarranty> results = warrantyService.findWarrantyWithKeyWord(keyword);
                    if (results == null) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không tìm thấy kết quả với từ khóa: " + keyword + " !");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_warranty");
                    } else {
                        request.setAttribute("warranties", results);
                        request.getRequestDispatcher("/viewAdmin/manage_warranty.jsp").forward(request, response);
                    }
                    break;
                case "add":
                    InfoWarranty warranty = getDataFromRequest(request);
                    isSuccessful = warrantyService.insertWarranty(warranty);
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(), ip, LogLevel.ALERT.toString(),"null",warranty.toString(),"Thêm thông tin bảo hành");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thêm thông tin thành công !");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thêm thông tin thất bại !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_warranty");
                    break;
                case "showEdit":
                    int idWarrantyEdit = Integer.parseInt(request.getParameter("id"));
                    InfoWarranty warrantyEdit = warrantyService.findWarrantyById(idWarrantyEdit);
                    if (warrantyEdit != null) {
                        request.setAttribute("warrantyEdit", warrantyEdit);
                        request.getRequestDispatcher("/viewAdmin/manage_warranty.jsp").forward(request, response);
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không tìm thấy thông tin !");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_warranty");
                    }
                    break;
                case "edit":
                    int idWarranty = Integer.parseInt(request.getParameter("id"));
                    InfoWarranty infoWarranty_before = warrantyService.findWarrantyById(idWarranty);
                    InfoWarranty infoWarranty_after = new InfoWarranty();
                    try {
                        InfoWarranty warrantyFromRequest = getDataFromRequest(request);
                        infoWarranty_after = warrantyFromRequest;
                        isSuccessful = warrantyService.editWarranty(idWarranty, warrantyFromRequest);
                    } catch (Exception e) {
                        isSuccessful = false;
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/manage_warranty");
                    }
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(), ip, LogLevel.WARNING.toString(),infoWarranty_before.toString(),infoWarranty_after.toString(),"Sửa thông tin bảo hành");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Sửa thành công !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_warranty");
                    break;
                case "delete":
                    InfoWarranty infoWarranty_delete = new InfoWarranty();
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        infoWarranty_delete = warrantyService.findWarrantyById(id);
                        isSuccessful = warrantyService.deleteWarranty(id);
                    } catch (Exception e) {
                        isSuccessful = false;
                    }
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(), ip, LogLevel.WARNING.toString(),infoWarranty_delete.toString(),"Delete success","Xóa bảo hành");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Xóa thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Bạn cần xóa các thông tin khac !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_warranty");
                    break;
            }
        } else {
            request.getRequestDispatcher("/viewAdmin/manage_warranty.jsp").forward(request, response);
        }
    }


    public InfoWarranty getDataFromRequest(HttpServletRequest request) {
        InfoWarranty warranty = new InfoWarranty();
        String term = request.getParameter("term");
        String address = request.getParameter("address");
        String time = request.getParameter("time");
        try {
            warranty.setTerm_waranty(term);
            warranty.setAddress_warranty(address);
            warranty.setTime_warranty(time);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
        return warranty;
    }
}
