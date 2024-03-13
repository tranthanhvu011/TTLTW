package controller.user;

import dao.OrderProductVariantDAO;
import dao.ProductVariantDAO;
import dao.TransportDAO;
import model.Account;
import model.Cart;
import model.InforTransport;
import model.ProductVariant;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/buynow")
public class BuyNowController extends HttpServlet {

    @Inject
    private TransportDAO transportDAO;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        ProductVariant productVariant = ProductVariantDAO.getInstance().findProductVariant(id);
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("account");
        ProductVariant productVariantsession = (ProductVariant) session.getAttribute("product");

        if (productVariant != null) {
            if (account == null) {
                session.setAttribute("message", "Vui lòng đăng nhập");
                resp.sendRedirect("/home");
            } else {
                boolean is_create_Order = OrderProductVariantDAO.findOrderByID_Account(account.getId());
                if (!is_create_Order) {
                    OrderProductVariantDAO.createOrderByID_Account(account.getId());
                }
                InforTransport inforTransports = transportDAO.findInfoTransportByAccountId(account.getId());
                if (inforTransports == null) {
                    InforTransport inforTransport = new InforTransport();
                    inforTransport.setName(account.getLast_name());
                    inforTransport.setCost(30000);
                    inforTransport.setTime_delivery(30);
                    inforTransport.setAddress_reciver(account.getAddress());
                    inforTransport.setName_reciver(account.getLast_name());
                    inforTransport.setPhone_reciver(account.getPhone_number());
                    TransportDAO.createInfoTransport(inforTransport, account.getId());
                }
                req.setAttribute("infortransport", inforTransports);

                // Cập nhật thuộc tính phiên với productVariant mới
                session.setAttribute("product", productVariant);

                req.getRequestDispatcher("/view/paynow.jsp").forward(req, resp);
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
