package controller.admin;

import dao.InventoryDAO;
import dao.ProductInventoryDAO;
import dao.ProductVariantDAO;
import model.KhoHang;
import model.ProductInventory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_product_inventory"})
public class ManageProductInventoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductInventoryDAO productInventoryDAO = new ProductInventoryDAO();
        List<ProductInventory> list = productInventoryDAO.getAllProductInventories();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();
        List<KhoHang> khoHangList = inventoryDAO.getAllInventory();
        List<Integer> listIdProduct = productVariantDAO.getAllIdProductVariant();
        req.setAttribute("productInventory", list);
        req.setAttribute("listid", listIdProduct);
        req.setAttribute("listkho", khoHangList);
        req.getRequestDispatcher("/viewAdmin/manage_productinventory.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            int warehouseId = Integer.parseInt(req.getParameter("warehouseId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            double price = Double.parseDouble(req.getParameter("price"));
            double allPrice = Double.parseDouble(req.getParameter("allprice"));

            // Tạo đối tượng ProductInventory
            ProductInventory productInventory = new ProductInventory();
            productInventory.setIdKho(warehouseId);
            productInventory.setIdProductVariant(productId);
            productInventory.setQuantityProductVariant(quantity);
            productInventory.setPriceOneProductVariant(price);
            productInventory.setPriceAllProductVariant(allPrice);

            // Thêm vào cơ sở dữ liệu
            ProductInventoryDAO productInventoryDAO = new ProductInventoryDAO();
            boolean success = productInventoryDAO.addProductInventory(warehouseId, productId, quantity, price, allPrice);

            if (success) {
                resp.sendRedirect("/admin/manage_product_inventory");
            } else {
                req.setAttribute("error", "Lỗi khi thêm sản phẩm vào kho.");
                req.getRequestDispatcher("/viewAdmin/manage_productinventory.jsp").forward(req, resp);
            }
        } else if ("edit".equals(action)) {
            int idParam = Integer.parseInt(req.getParameter("id"));
            int warehouseId = Integer.parseInt(req.getParameter("warehouseId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            double price = Double.parseDouble(req.getParameter("price"));
            double allPrice = Double.parseDouble(req.getParameter("allprice"));

            // Tạo đối tượng ProductInventory
            ProductInventory productInventory = new ProductInventory();
            productInventory.setId(idParam);
            productInventory.setIdKho(warehouseId);
            productInventory.setIdProductVariant(productId);
            productInventory.setQuantityProductVariant(quantity);
            productInventory.setPriceOneProductVariant(price);
            productInventory.setPriceAllProductVariant(allPrice);

            // Thêm vào cơ sở dữ liệu
            ProductInventoryDAO productInventoryDAO = new ProductInventoryDAO();

            boolean success = productInventoryDAO.updateProductInventory(productInventory);

            if (success) {
                resp.sendRedirect("/admin/manage_product_inventory");
            } else {
                req.setAttribute("error", "Lỗi khi thêm sản phẩm vào kho.");
                req.getRequestDispatcher("/viewAdmin/manage_productinventory.jsp").forward(req, resp);
            }
        } else if ("delete".equals(action)) {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                try {
                    ProductInventoryDAO productInventoryDAO = new ProductInventoryDAO();
                    int id = Integer.parseInt(idParam);
                    boolean success = productInventoryDAO.deleteProductInventory(id);
                    resp.getWriter().write(success ? "success" : "error");
                } catch (NumberFormatException e) {
                    resp.getWriter().write("error");
                }
            } else {
                resp.getWriter().write("error");
            }
        }

    }
}
