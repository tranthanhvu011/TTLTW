package controller.admin;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import dao.NhapHangDAO;
import model.NhapHang;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/admin/manage_getlistimport")
public class GetListImportController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NhapHangDAO nhapHangDAO = new NhapHangDAO();
        List<NhapHang> nhapHangList = nhapHangDAO.getAll();
        req.setAttribute("nhaphang",nhapHangList);
        req.getRequestDispatcher("/viewAdmin/xulynhaphang.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            String id = req.getParameter("id");
            List<Integer> list = (List<Integer>) req.getSession().getAttribute("listProductImport");

            if (list != null) {
                try {
                    int productId = Integer.parseInt(id);
                    list.remove(Integer.valueOf(productId));

                    req.getSession().setAttribute("listProductImport", list);
                    resp.setStatus(HttpServletResponse.SC_OK);
                } catch (NumberFormatException e) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
                }
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Danh sách sản phẩm không tồn tại");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không hợp lệ");
        }
    }

}

