package controller.admin;

import dao.TransportDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "update-order", urlPatterns = {"/update-order"})
public class UpdateInforTransportController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        int getOrderId = Integer.parseInt(req.getParameter("orderId"));
        String name = req.getParameter("name").trim();
        String address = req.getParameter("address").trim();
        String phone = req.getParameter("phone").trim();
        HttpSession session = req.getSession();
        boolean is_Update = TransportDAO.updateTransportInfoByOrderId(getOrderId, name, phone, address);
        if (is_Update) {
            resp.sendRedirect("/manage-order");
            session.setAttribute("message","Cập nhật thành công!");
        }else {
            session.setAttribute("message","Cập nhật không thành công!");
        }
    }
}
