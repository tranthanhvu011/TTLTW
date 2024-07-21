package controller.user;

import dao.OrderProductVariantDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/user/cancel_order"})
public class CancelOrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       int id = Integer.parseInt(req.getParameter("id"));
        OrderProductVariantDAO opv = new OrderProductVariantDAO();
        boolean is_update = opv.updateStatus(id,6);
        if (is_update){
            req.getSession().setAttribute("message","Hủy đơn hàng thành công ");
            req.getSession().setAttribute("status",true);
            resp.sendRedirect(req.getContextPath() + "/user/your_order");
        }else {
            req.getSession().setAttribute("message","Hủy đơn hàng thất bại ");
            req.getSession().setAttribute("status",false);
        }
    }
}
