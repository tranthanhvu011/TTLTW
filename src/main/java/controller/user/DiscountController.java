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

@WebServlet("/add-discount")
public class DiscountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String getCode = req.getParameter("code");
        int idProduct = Integer.parseInt(req.getParameter("id"));
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
                boolean is_discount = DiscountDAO.isDiscount(idProduct, discount.getId());

                if (is_discount) {
                    double discountedPrice = productVariant.getPrice() - discount.getCost();
                    productVariant.setPrice(discountedPrice);

                    if (cart.getData().containsKey(productVariant.getId())) {
                        CartProduct cartProduct = cart.getData().get(productVariant.getId());
                        cartProduct.getProductVariant().setPrice(discountedPrice);
                        // Cập nhật lại giá trong cart
                        cart.getData().put(productVariant.getId(), cartProduct);
                    }

                    session.setAttribute("message", "Áp mã thành công!");
                    session.setAttribute("status", true);
                } else {
                    session.setAttribute("message", "Mã không tồn tại");
                    session.setAttribute("status", false);
                }
            } else {
                session.setAttribute("message", "Mã giảm giá không hợp lệ");
                session.setAttribute("status", false);
            }
        } else {
            session.setAttribute("message", "Sản phẩm không tồn tại");
            session.setAttribute("status", false);
        }

        session.setAttribute("cart", cart);
        resp.sendRedirect("/payment");
    }
}
