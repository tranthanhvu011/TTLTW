package controller.paypal;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.paypal.base.rest.PayPalRESTException;

@WebServlet("/authorize_payment")
public class AuthorizePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AuthorizePaymentServlet() {
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isPaypal = request.getParameter("flexRadioDefault");
        String subtotal = request.getParameter("value_price1");
        String shipping = request.getParameter("value_transport_fee1");
        String discountShip = request.getParameter("value_discount_ts_fee1");
        String total = request.getParameter("value_total_price1");
        OrderDetail orderDetail = new OrderDetail(subtotal, shipping, discountShip, total);
        System.out.println(subtotal);
        System.out.println(shipping);
        System.out.println(discountShip);
        System.out.println(total);
        System.out.println(orderDetail);

        if ("optionPaypal".equals(isPaypal)) {
            try {
                PaypalServices paymentServices = new PaypalServices();
                String approvalLink = paymentServices.authorizePayment(orderDetail);

                response.sendRedirect(approvalLink);

            } catch (PayPalRESTException ex) {
                request.setAttribute("errorMessage", ex.getMessage());
                ex.printStackTrace();
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("/checkout");
        }
    }

}
