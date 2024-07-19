package controller.admin;


import model.Log;
import dao.LogDAO;
import model.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage-log"})
public class ManageLogController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LogDAO logDAO = new LogDAO();
        List<Log> list = logDAO.getAllLog();
        req.setAttribute("listLog", list);
        req.getRequestDispatcher("/viewAdmin/manage_log.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = req.getParameter("id");
            int id = Integer.parseInt(idStr);
            LogDAO logDAO = new LogDAO();
            boolean success = logDAO.deleteLog(id);
            resp.getWriter().write(success ? "success" : "failure");
        } else {
            doGet(req, resp);
        }
    }
}
