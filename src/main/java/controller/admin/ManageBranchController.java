package controller.admin;

import dao.BranchDAO;
import model.ChiNhanh;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_branch"})
public class ManageBranchController  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BranchDAO branchDAO = new BranchDAO();
        List<ChiNhanh> list = new ArrayList<>();
        list = branchDAO.getAllBranches();
        req.setAttribute("listBranches",list);
        req.getRequestDispatcher("/viewAdmin/manage_branch.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        BranchDAO branchDAO = new BranchDAO();

        switch (action) {
            case "delete":
                handleDelete(req, resp, branchDAO);
                break;
            case "edit":
                handleEdit(req, resp, branchDAO);
                break;
            case "add":
                handleAdd(req, resp, branchDAO);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, BranchDAO branchDAO) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                boolean success = branchDAO.deleteBranch(id);
                resp.setContentType("text/plain");
                resp.getWriter().write(success ? "success" : "error");
            } catch (NumberFormatException e) {
                resp.getWriter().write("error");
            }
        } else {
            resp.getWriter().write("error");
        }
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp, BranchDAO branchDAO) throws IOException {
        String idParam = req.getParameter("id");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        if (idParam != null && name != null && address != null && phone != null && email != null) {
            try {
                int id = Integer.parseInt(idParam);
                boolean success = branchDAO.updateBranch(id, name, address, phone, email);
                resp.sendRedirect("/admin/manage_branch");
            } catch (NumberFormatException e) {
                resp.getWriter().write("error");
            }
        } else {
            resp.getWriter().write("error");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp, BranchDAO branchDAO) throws IOException {
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        if (name != null && address != null && phone != null && email != null) {
            try {
                boolean success = branchDAO.addBranch(name, address, phone, email);
                resp.sendRedirect("/admin/manage_branch");
            } catch (Exception e) {
                resp.getWriter().write("error");
            }
        } else {
            resp.getWriter().write("error");
        }
    }
}
