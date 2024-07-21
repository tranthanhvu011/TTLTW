package controller.user;

import com.google.gson.Gson;
import dao.RateDAO;
import model.Account;
import model.Rate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(urlPatterns = {"/user/rate"})
public class RateController extends HttpServlet {
    private RateDAO rateDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        rateDAO = new RateDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String productIdStr = req.getParameter("id");
        if (productIdStr != null) {
            int productId = Integer.parseInt(productIdStr);
            List<Rate> rates = rateDAO.getRatesByProductId(productId);

            Gson gson = new Gson();
            String jsonRates = gson.toJson(rates);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonRates);
        } else {
            resp.sendRedirect(req.getContextPath() + "/someErrorPage");
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String comment = req.getParameter("comment");
        int star = Integer.parseInt(req.getParameter("star")); // Chuyển đổi giá trị số sao từ String sang int
        Account account = (Account) req.getSession().getAttribute("account");
        int id = Integer.parseInt(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("status"));

            RateDAO dao = new RateDAO();
            boolean check_comment = dao.checkRateByAccountId(id,account.getId());
            if(check_comment== false){
                Rate rate = new Rate();
                rate.setProduct_id(id);
                rate.setAccount_id(account.getId());
                rate.setComment(comment);
                rate.setNumber_rate(star);
                rateDAO.addRate(rate);
                req.getSession().setAttribute("message","Đánh giá thành công ");
                req.getSession().setAttribute("status",true);
                resp.sendRedirect(req.getContextPath() + "/user/your_order");
            }else{
               if (status!=6){
                   req.getSession().setAttribute("message","Hãy đánh giá khi đơn hàng được giao thành công!");
                   req.getSession().setAttribute("status",false);
                   resp.sendRedirect(req.getContextPath() + "/user/your_order");
               }else {
                   req.getSession().setAttribute("message","Sản phẩm đã được đánh giá");
                   req.getSession().setAttribute("status",false);
                   resp.sendRedirect(req.getContextPath() + "/user/your_order");
               }
            }
    }
}
