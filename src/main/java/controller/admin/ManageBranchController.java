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
        req.setAttribute("list",list);
        req.getRequestDispatcher("/viewAdmin/manage_branch.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        BranchDAO branchDAO = new BranchDAO();

        if ("delete".equals(action)) {
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
        } else if ("edit".equals(action)) {
            String idParam = req.getParameter("id");
            String name = req.getParameter("name");

            if (idParam != null && name != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean success = branchDAO.updateBranch(id, name);
                    resp.sendRedirect("/admin/manage_branch");
                } catch (NumberFormatException e) {
                    resp.getWriter().write("error");
                }
            } else {
                resp.getWriter().write("error");
            }
        } else if ("add".equals(action)) { // Xử lý yêu cầu thêm chi nhánh
            String name = req.getParameter("name");

            if (name != null && !name.trim().isEmpty()) {
                try {
                    boolean success = branchDAO.addBranch(name);
                    resp.sendRedirect("/admin/manage_branch");
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
