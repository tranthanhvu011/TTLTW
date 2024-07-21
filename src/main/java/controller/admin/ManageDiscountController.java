package controller.admin;

import controller.enums.LogLevel;
import dao.LogDAO;
import model.Account;
import model.Discount;
import service.DiscountService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_discount"})
public class ManageDiscountController extends HttpServlet {
    @Inject
    private DiscountService discountService;

    String action;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("discounts", discountService.getAllDiscount());
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
                    List<Discount> results = discountService.findDiscountWithKeyWord(keyword);
                    if (results == null) {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không tìm thấy kết quả với từ khóa: " + keyword + " !");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_discount");
                    } else {
                        request.setAttribute("discounts", results);
                        request.getRequestDispatcher("/viewAdmin/manage_discount.jsp").forward(request, response);
                    }
                    break;
                case "add":
                    Discount discount = getDataFromRequest(request);
                    isSuccessful = discountService.insertCapacity(discount);
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.ALERT.toString(),"null",discount.toString(),"Thêm mã giảm giá");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Thêm thông tin thành công !");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Thêm thông tin thất bại !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_discount");
                    break;
                case "showEdit":
                    int idDiscountEdit = Integer.parseInt(request.getParameter("id"));
                    Discount discountEdit = discountService.findDiscountById(idDiscountEdit);
                    if (discountEdit != null) {
                        request.setAttribute("discount", discountEdit);
                        request.getRequestDispatcher("/viewAdmin/manage_discount.jsp").forward(request, response);
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Không tìm thấy thông tin !");
                        response.sendRedirect(request.getContextPath() + "/admin/manage_discount");
                    }
                    break;
                case "edit":
                    int idCapacity = Integer.parseInt(request.getParameter("id"));
                    Discount discount1 = discountService.findDiscountById(idCapacity);
                    Discount discount_edit = new Discount();
                    try {
                        Discount discountFromRequest = getDataFromRequest(request);
                        isSuccessful = discountService.editDiscount(idCapacity, discountFromRequest);
                        discount_edit = discountFromRequest;
                    } catch (Exception e) {
                        isSuccessful = false;
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", e.getMessage());
                    }
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.WARNING.toString(),discount1.toString(),discount_edit.toString(),"Sửa mã giảm giá");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Sửa thành công !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_discount");
                    break;
                case "delete":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Discount discount_delete = discountService.findDiscountById(id);
                    try {
                        isSuccessful = discountService.deleteDiscount(id);
                    } catch (Exception e) {
                        isSuccessful = false;
                    }
                    if (isSuccessful) {
                        LogDAO logDAO = new LogDAO();
                        logDAO.insertLog(account.getId(),ip, LogLevel.DANGER.toString(),discount_delete.toString(),"Delete Success!!","Xóa mã giảm giá");
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Xóa thành công!");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Bạn cần xóa các thông tin khác !");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/manage_discount");
                    break;
            }
        } else {
            request.getRequestDispatcher("/viewAdmin/manage_discount.jsp").forward(request, response);
        }
    }


    public Discount getDataFromRequest(HttpServletRequest request) {
        Discount discount = new Discount();
        String name = request.getParameter("name_discount");
        String cost = request.getParameter("cost");
        String code = request.getParameter("code");
        String start_at = request.getParameter("start_at");
        String end_at = request.getParameter("end_at");
        String is_active = request.getParameter("is_active");
        try {
            discount.setName(name);
            discount.setCost(Double.parseDouble(cost));
            discount.setCode(code);
            discount.setStart_at(Date.valueOf(start_at));
            discount.setEnd_at(Date.valueOf(end_at));
            discount.setIs_active(Integer.parseInt(is_active));
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
        return discount;
    }
}
