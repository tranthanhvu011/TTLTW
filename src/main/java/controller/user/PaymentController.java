package controller.user;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dao.TransportDAO;
import model.*;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(urlPatterns = {"/payment"})
public class PaymentController extends HttpServlet {

    @Inject
    private TransportDAO transportDAO;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("account");
        InforTransport inforTransport = transportDAO.findInfoTransportByAccountId(account.getId());
        request.setAttribute("infortransport", inforTransport);
        request.getRequestDispatcher("/view/payment.jsp").forward(request, response);
    }
}
