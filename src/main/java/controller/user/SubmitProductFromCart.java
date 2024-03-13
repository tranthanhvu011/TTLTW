package controller.user;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.OrderProductVariantDAO;
import dao.TransportDAO;
import model.Account;
import model.InforTransport;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/submitProductFromCart")
public class SubmitProductFromCart extends HttpServlet {


    @Inject
    private TransportDAO transportDAO;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String selectedIDJson = req.getParameter("selectedProductIds");
        List<String> selectedID = Arrays.asList(new ObjectMapper().readValue(selectedIDJson, String[].class));

        List<Integer> selectedIDs = new ObjectMapper().readValue(selectedIDJson, new TypeReference<List<Integer>>() {
        });
        HttpSession session = req.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account == null) {
            session.setAttribute("message", "Vui lòng đăng nhập để tiến hành thanh toán!");
            resp.sendRedirect("/cart?action=view-cart");
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
            session.setAttribute("selectedProductIds", selectedIDs);
            resp.sendRedirect("/payment");
        }

    }
}
