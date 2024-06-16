package controller.admin;

import model.Product;
import model.ProductVariant;
import service.ProductService;
import service.ProductVariantService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/product/manage_product"})
public class ManageProductController extends HttpServlet {

    @Inject
    private ProductVariantService productVariantService;

    String action, id;
    int idP = 0;
    boolean isSuccess;
    int limit = 10;  // Set a reasonable limit for products per page

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int offset = 0;
        int numberProduct = productVariantService.countNumberPage();
        int numberPage = (numberProduct / limit) + ((numberProduct % limit == 0) ? 0 : 1);
        int index = request.getParameter("index") != null ? Integer.parseInt(request.getParameter("index")) : 1;
        offset += (index-1) * limit;
        List<ProductVariant> productVariants = productVariantService.getAllProductVariant(limit, offset);
        request.setAttribute("currentIndex", index);
        request.setAttribute("numberPage", numberPage);
        request.setAttribute("productVariants", productVariants);
        request.getRequestDispatcher("/viewAdmin/manage_product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        action = request.getParameter("action");
        id = request.getParameter("id");
        isSuccess = false;
        if (id != null) {
            idP = Integer.parseInt(id);
        }
        if (action != null) {
            switch (action) {
                case "delete":
                    isSuccess = productVariantService.deleteProductVariant(idP);
                    if (isSuccess) {
                        request.getSession().setAttribute("status", true);
                        request.getSession().setAttribute("message", "Xóa sản phẩm thành công");
                    } else {
                        request.getSession().setAttribute("status", false);
                        request.getSession().setAttribute("message", "Xóa sản phẩm thất bại");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/product/manage_product");
                    break;
                case "search":
                    String keyword = request.getParameter("keyword");
                    List<ProductVariant> productVariants = productVariantService.searchProductVariant(keyword);
                    request.setAttribute("productVariants", productVariants);
                    request.getRequestDispatcher("/viewAdmin/manage_product.jsp").forward(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/product/manage_product");
        }
    }
}