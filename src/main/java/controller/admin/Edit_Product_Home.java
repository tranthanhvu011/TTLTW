package controller.admin;

import dao.ProductDAO;
import dao.ProductVariantDAO;
import modelDB.ProductDB;
import modelDB.ProductVariantDB;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/edit_product_home"})
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10,
        fileSizeThreshold = 1024 * 1024,
        maxRequestSize = 1024 * 1024 * 100
)
public class Edit_Product_Home extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String idProduct = req.getParameter("idProduct");
        ProductDAO productDAO = new ProductDAO();
        ProductVariantDAO productVariantDAO  = new ProductVariantDAO();
        List<ProductVariantDB> productVariantDB =  productVariantDAO.getAllProductVariantByIdProduct(Integer.parseInt(idProduct));
        ProductDB productDB = productDAO.findProductById(Integer.parseInt(idProduct));
        System.out.print(productVariantDB);
        req.setAttribute("productDB", productDB);
        req.setAttribute("productVariantDB", productVariantDB);
        req.getRequestDispatcher("/viewAdmin/edit_product_home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action.equalsIgnoreCase("changeProduct")) {
            doPost_ChangeProDuct(req,resp);
        }else if (action.equalsIgnoreCase("changeVariantProduct")) {
            doPost_ChangeProDuctVariant(req,resp);
        }
    }
    protected void doPost_ChangeProDuct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idProduct = req.getParameter("idProduct");
        String remain_quantity = req.getParameter("remain_quantity");
        String sell_quantity = req.getParameter("sell_quantity");
        String discount = req.getParameter("discount");
        String description = req.getParameter("description");
        String price = req.getParameter("price");
        System.out.print(remain_quantity + sell_quantity + discount + description + price);
        ProductDAO productDAO = new ProductDAO();
        if (productDAO.updateProductAndDiscount(Integer.parseInt(sell_quantity),Integer.parseInt(remain_quantity),Double.parseDouble(price),description,Integer.parseInt(discount),Integer.parseInt(idProduct))) {
            req.getSession().setAttribute("message", "Cập Nhập Thành Công");
            req.getSession().setAttribute("status", true);
            resp.sendRedirect("/admin/edit_product_home?idProduct=" + Integer.parseInt(idProduct));
        }else{
            req.getSession().setAttribute("message", "Cập Nhập Thất Bại");
            req.getSession().setAttribute("status", false);
            resp.sendRedirect("/admin/edit_product_home?idProduct=" + Integer.parseInt(idProduct));
        }
    }
    protected void doPost_ChangeProDuctVariant(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String price = req.getParameter("priceVariant");
        String state = req.getParameter("state");
        String idVariant = req.getParameter("idProductVariant");
        String idProduct = req.getParameter("idProduct");
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        if (productVariantDAO.updateVariant(Double.parseDouble(price), Integer.parseInt(state),Integer.parseInt(idVariant)) == 1) {
            req.getSession().setAttribute("message", "Cập Nhập Thành Công");
            req.getSession().setAttribute("status", true);
            resp.sendRedirect("/admin/edit_product_home?idProduct=" + Integer.parseInt(idProduct));
        }else{
            req.getSession().setAttribute("message", "Cập Nhập Thất Bại");
            req.getSession().setAttribute("status", false);
            resp.sendRedirect("/admin/edit_product_home?idProduct=" + Integer.parseInt(idProduct));
        }
    }
    }
