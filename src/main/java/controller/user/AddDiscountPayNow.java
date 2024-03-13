package controller.user;

import dao.DiscountDAO;
import dao.ProductVariantDAO;
import model.Cart;
import model.CartProduct;
import model.Discount;
import model.ProductVariant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/add-discount-paynow")
public class AddDiscountPayNow extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String getCode = req.getParameter("code");
        int idProduct = Integer.parseInt(req.getParameter("id"));

        HttpSession session = req.getSession();
        ProductVariant productVariantsession = (ProductVariant) session.getAttribute("product");
        ProductVariant productVariant = ProductVariantDAO.getInstance().findProductVariant(idProduct);

        if (productVariant != null) {
            Discount discount = DiscountDAO.findDiscountByCode(getCode);

            if (discount != null) {
                System.out.println(productVariant.getProduct().getId());
                boolean is_discount = DiscountDAO.isDiscount(productVariant.getProduct().getId(), discount.getId());

                if (is_discount) {
                    double discountedPrice = productVariant.getPrice() * discount.getCost();
                    // Nếu sản phẩm hiện tại trong session giống với sản phẩm áp dụng giảm giá
                    if (productVariantsession != null && productVariantsession.getId() == productVariant.getId()) {
                        productVariantsession.setPrice(discountedPrice);
                        session.setAttribute("product", productVariantsession);
                        System.out.println(productVariantsession.getPrice());
                    }
                    productVariant.setPrice(discountedPrice);
                    req.getSession().setAttribute("message-discount", "Áp dụng thành công");
                    resp.sendRedirect("/buynow?id=" + idProduct);
                } else {
                    req.getSession().setAttribute("message-discount", "Mã không tồn tại");
                    resp.sendRedirect("/buynow?id=" + idProduct);
                }
            } else {
                req.getSession().setAttribute("message-discount", "Mã giảm giá không hợp lệ");
                resp.sendRedirect("/buynow?id=" + idProduct);
            }
        } else {
            req.getSession().setAttribute("message-discount", "Sản phẩm không tồn tại");
            resp.sendRedirect("/buynow?id=" + idProduct);
        }
    }

}
