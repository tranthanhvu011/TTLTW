package controller.admin;

import dao.InventoryDAO;
import dao.ProductDAO;
import model.KhoHang;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_inventory"})
public class ManageInventoryController  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        InventoryDAO inventoryDAO = new InventoryDAO();
        List<KhoHang> inventory = new ArrayList<>();
        inventory = inventoryDAO.getAllInventory();
        List<Integer> idProduct = ProductDAO.getAllIdProduct();
        req.setAttribute("inventory",inventory);
        req.setAttribute("listId",idProduct);
        req.getRequestDispatcher("/viewAdmin/manage_inventory.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        InventoryDAO inventoryDAO = new InventoryDAO();

        if ("delete".equals(action)) {
            String idParam = req.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean success = inventoryDAO.deleteInventory(id);
                    resp.getWriter().write(success ? "success" : "error");
                } catch (NumberFormatException e) {
                    resp.getWriter().write("error");
                }
            } else {
                resp.getWriter().write("error");
            }
        } else if ("edit".equals(action)) {
            String idParam = req.getParameter("id");
            String productParam = req.getParameter("product");
            String name = req.getParameter("name");

            if (idParam != null && productParam != null && name != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    int productId = Integer.parseInt(productParam);
                    boolean success = inventoryDAO.updateInventory(id, productId, name);
                    resp.sendRedirect("/admin/manage_inventory"); // Redirect to refresh the page
                } catch (NumberFormatException e) {
                    resp.getWriter().write("error");
                }
            } else {
                resp.getWriter().write("error");
            }
        } else if ("add".equals(action)) {
            String productParam = req.getParameter("product");
            String name = req.getParameter("name");

            if (productParam != null && name != null) {
                try {
                    int productId = Integer.parseInt(productParam);
                    boolean success = inventoryDAO.addInventory(productId, name);
                    resp.sendRedirect("/admin/manage_inventory"); // Redirect to refresh the page
                } catch (NumberFormatException e) {
                    resp.getWriter().write("error");
                }
            } else {
                resp.getWriter().write("error");
            }
        } else {
            resp.getWriter().write("error");
        }
    }
}