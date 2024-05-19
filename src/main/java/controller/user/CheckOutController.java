package controller.user;


import dao.OrderProductVariantDAO;
import dao.TransportDAO;
import model.*;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Order;


@WebServlet("/checkout")
public class CheckOutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Inject
    private TransportDAO transportDAO;

    public CheckOutController(){
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account account = (Account) req.getSession().getAttribute("account");
        boolean is_success = false;
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        String isPaypal = req.getParameter("flexRadioDefault");
        List<Integer> listID = (List<Integer>) req.getSession().getAttribute("selectedProductIds");
        InforTransport inforTransport = transportDAO.findInfoTransportByAccountId(account.getId());
        Order order = OrderProductVariantDAO.findOrderByID_AccountModel(account.getId());
        System.out.println("isPaypal: " + isPaypal);
        System.out.println("listID: " + listID);
        System.out.println("inforTransport: " + inforTransport);
        System.out.println("order: " + order);

            if (listID != null && !listID.isEmpty()) {
                for (int id : listID) {
                    CartProduct cartProduct = cart.getData().get(id);
                    if (cartProduct != null) {
                        is_success = OrderProductVariantDAO.createOrderProductVariant(id, order.getId(), cartProduct.getQuantity(), inforTransport.getId(), cartProduct.getQuantity() * cartProduct.getProductVariant().getPrice() + inforTransport.getCost() , 1);
                        cart.getData().remove(id);
                    }
                }
            }

        if (is_success) {
            resp.sendRedirect("/home");
        } else {
            // Xử lý nếu có lỗi khi thêm vào cơ sở dữ liệu
            resp.getWriter().println("Error occurred while processing orders.");
        }

    }


}