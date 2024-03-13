package controller.admin;


import model.OrderProductVariant;
import service.OrderProductVariantService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_order"})
public class OrderController extends HttpServlet {


    @Inject
    private OrderProductVariantService orderProductVariantService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("dataOrder", orderProductVariantService.getAllOrderProductVariants());
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String getAction = req.getParameter("action");
        int getID;
        if (getAction != null) {
            switch (getAction) {
                case "search":
                    String getSearch = req.getParameter("keyword");
                    List<OrderProductVariant> list = orderProductVariantService.searchOrder(getSearch);
                    if (list == null) {
                        req.getSession().setAttribute("status", false);
                        req.getSession().setAttribute("message", "Không tìm thấy đơn hàng nào");
                        resp.sendRedirect(req.getContextPath() + "/admin/manage_order");
                    } else {
                        req.setAttribute("dataOrder", list);
                        req.getRequestDispatcher("/viewAdmin/manage_order.jsp").forward(req, resp);
                    }
                    break;
                case "delete":
                    getID = Integer.parseInt(req.getParameter("id"));
                    boolean isSuccess = orderProductVariantService.deleteOrder(getID);
                    if (isSuccess) {
                        req.getSession().setAttribute("status", true);
                        req.getSession().setAttribute("message", "Xóa đơn hàng thành công");
                    } else {
                        req.getSession().setAttribute("status", false);
                        req.getSession().setAttribute("message", "Xóa đơn hàng thất bại");
                    }
                    resp.sendRedirect(req.getContextPath() + "/admin/manage_order");
                    break;
                case "editStatus":
                    getID = Integer.parseInt(req.getParameter("id"));
                    int statusOrder = orderProductVariantService.findOrderProductVariantById(getID);
                    int getStatus = Integer.parseInt(req.getParameter("status"));
                    if (statusOrder == getStatus) {
                        req.getSession().setAttribute("status", false);
                        req.getSession().setAttribute("message", "Trạng thái đơn hàng đã được cập nhật trước đó");
                        resp.sendRedirect(req.getContextPath() + "/admin/manage_order");
                        break;
                    }
                    boolean success = orderProductVariantService.updateStatus(getID, getStatus);
                    if (success) {
                        req.getSession().setAttribute("status", true);
                        req.getSession().setAttribute("message", "Cập nhật trạng thái đơn hàng thành công");
                    } else {
                        req.getSession().setAttribute("status", false);
                        req.getSession().setAttribute("message", "Cập nhật trạng thái đơn hàng thất bại");
                    }
                    resp.sendRedirect(req.getContextPath() + "/admin/manage_order");
                    break;
                case "showDetail":
                    getID = Integer.parseInt(req.getParameter("id"));
                    OrderProductVariant orderProductVariant = orderProductVariantService.getOrderProductVariantById(getID);
                    if (orderProductVariant != null) {
                        req.setAttribute("orderProductVariant", orderProductVariant);
                        req.setAttribute("dataOrder", orderProductVariantService.getAllOrderProductVariants());
                        req.getRequestDispatcher("/viewAdmin/manage_order.jsp").forward(req, resp);
                        break;
                    } else {
                        req.getSession().setAttribute("status", false);
                        req.getSession().setAttribute("message", "Không tìm thấy đơn hàng");
                    }
                    resp.sendRedirect(req.getContextPath() + "/admin/manage_order");
                    break;
            }
        }else{
            req.getRequestDispatcher("/viewAdmin/manage_order.jsp").forward(req, resp);
        }
    }
}
