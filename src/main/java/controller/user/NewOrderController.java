package controller.user;

import dao.OrderProductVariantDAO;
import model.Account;
import model.Order;
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

@WebServlet(urlPatterns = {"/user/your_order"})
public class NewOrderController extends HttpServlet {
    @Inject
    private OrderProductVariantService orderProductVariantService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        Order order = OrderProductVariantDAO.findOrderByID_AccountModel(account.getId());
        if (order == null) {
            OrderProductVariantDAO.createOrderByID_Account(account.getId());
        }
        List<OrderProductVariant> orderProductVariants = orderProductVariantService.findOrderProductVariantsByOrderId(order.getId());
        request.setAttribute("order_Account", orderProductVariants);
        request.getRequestDispatcher("../view/new_order.jsp").forward(request, response);
    }
}
