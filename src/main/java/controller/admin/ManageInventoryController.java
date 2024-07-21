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
            String name = req.getParameter("name");
            String address = req.getParameter("address");
            String phone = req.getParameter("phone");
            String mail = req.getParameter("mail");

            if (idParam != null && name != null && address != null && phone != null && mail != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean success = inventoryDAO.updateInventory(id, name, address, phone, mail);
                    resp.sendRedirect("/admin/manage_inventory"); // Redirect to refresh the page
                } catch (NumberFormatException e) {
                    resp.getWriter().write("error");
                }
            } else {
                resp.getWriter().write("error");
            }
        } else if ("add".equals(action)) {
            String name = req.getParameter("name");
            String address = req.getParameter("address");
            String phone = req.getParameter("phone");
            String mail = req.getParameter("mail");

            if (name != null && address != null && phone != null && mail != null) {
                try {
                    boolean success = inventoryDAO.addInventory(name, address, phone, mail);
                    resp.sendRedirect("/admin/manage_inventory"); // Redirect to refresh the page
                } catch (Exception e) {
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