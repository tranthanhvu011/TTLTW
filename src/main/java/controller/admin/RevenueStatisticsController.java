package controller.admin;

import model.OrderProductVariant;
import service.ManufacturerService;
import service.OrderProductVariantService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/revenue-statistics"})
public class RevenueStatisticsController extends HttpServlet {

    @Inject
    private OrderProductVariantService orderProductVariantService;
    @Inject
    private ManufacturerService manufacturerService;

    int totalNumber = 0;
    double totalPrice = 0;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("totalNumber", totalNumber);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("manufacturers", manufacturerService.getAllManufacturer());
        request.getRequestDispatcher("/viewAdmin/revenue_statistics.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "date":
                    String sDate = request.getParameter("batdau");
                    String eDate = request.getParameter("ketthuc");
                    if (sDate != null && eDate != null) {
                        List<OrderProductVariant> orderProductVariants = orderProductVariantService.filterByDate(sDate, eDate);
                        if (orderProductVariants != null) {
                            request.setAttribute("orderProductVariants", orderProductVariants);
                            request.setAttribute("manufacturers", manufacturerService.getAllManufacturer());
                            complete(orderProductVariants);
                            request.setAttribute("totalNumber", totalNumber);
                            request.setAttribute("totalPrice", totalPrice);
                            request.getRequestDispatcher("/viewAdmin/revenue_statistics.jsp").forward(request, response);
                        } else {
                            totalNumber = 0;
                            totalPrice = 0;
                            request.setAttribute("totalNumber", totalNumber);
                            request.setAttribute("totalPrice", totalPrice);
                            request.getSession().setAttribute("status", false);
                            request.getSession().setAttribute("message", "Không có đơn hàng nào trong khoảng thời gian này");
                            response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
                        }
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Vui lòng nhập khoảng thời gian bạn muốn");
                        response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
                    }
                    break;
                case "manufacturer":
                    String nameManufacturer = request.getParameter("manufacturer");
                    if (nameManufacturer != null) {
                        List<OrderProductVariant> orderProductVariants = orderProductVariantService.filterByManufacturer(nameManufacturer);
                        if (orderProductVariants != null) {
                            request.setAttribute("orderProductVariants", orderProductVariants);
                            request.setAttribute("manufacturers", manufacturerService.getAllManufacturer());
                            complete(orderProductVariants);
                            request.setAttribute("totalNumber", totalNumber);
                            request.setAttribute("totalPrice", totalPrice);
                            request.getRequestDispatcher("/viewAdmin/revenue_statistics.jsp").forward(request, response);
                        } else {
                            totalNumber = 0;
                            totalPrice = 0;
                            request.setAttribute("totalNumber", totalNumber);
                            request.setAttribute("totalPrice", totalPrice);
                            request.getSession().setAttribute("status", false);
                            request.getSession().setAttribute("message", "Không có đơn hàng nào");
                            response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
                        }
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Vui lòng chọn nhà saản xuất!");
                        response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
                    }
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/revenue-statistics");
        }
    }


    private void complete(List<OrderProductVariant> orderProductVariants) {
        orderProductVariants.forEach(o -> {
            totalNumber += o.getQuantity();
            totalPrice += o.getTotal_price();
        });
    }
}
