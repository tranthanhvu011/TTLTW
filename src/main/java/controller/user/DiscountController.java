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
import java.util.Map;

@WebServlet("/add-discount")
public class DiscountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String getCode = req.getParameter("code");
        int idProduct = Integer.parseInt(req.getParameter("id"));
        System.out.println(getCode);
        System.out.println(idProduct);
        HttpSession session = req.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        ProductVariant productVariant = ProductVariantDAO.getInstance().findProductVariant(idProduct);

        if (productVariant != null) {
            Discount discount = DiscountDAO.findDiscountByCode(getCode);

            if (discount != null) {
                System.out.println(productVariant.getProduct().getId());
                boolean is_discount = DiscountDAO.isDiscount(productVariant.getProduct().getId(), discount.getId());

                if (is_discount) {
                    double discountedPrice = productVariant.getPrice() * discount.getCost();
                    productVariant.setPrice(discountedPrice);

                    if (cart.getData().containsKey(productVariant.getId())) {
                        CartProduct cartProduct = cart.getData().get(productVariant.getId());
                        cartProduct.getProductVariant().setPrice(discountedPrice);
                    }

                    req.getSession().setAttribute("message-discount", "Áp dụng thành công");
                    resp.sendRedirect("/payment");
                } else {
                    req.getSession().setAttribute("message-discount", "Mã không tồn tại");
                    resp.sendRedirect("/payment");
                }
            } else {
                req.getSession().setAttribute("message-discount", "Mã giảm giá không hợp lệ");
                resp.sendRedirect("/payment");
            }
        } else {
            req.getSession().setAttribute("message-discount", "Sản phẩm không tồn tại");
            resp.sendRedirect("/payment");
        }
    }

}
