package controller.admin;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import dao.ProductVariantDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_import"})
public class ManageImportController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Integer> idProduct = new ArrayList<>();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();

        idProduct =productVariantDAO.getAllIdProductVariant();
        req.setAttribute("listIdProduct",idProduct);
        req.getRequestDispatcher("/viewAdmin/quanlynhaphang.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy dữ liệu JSON từ yêu cầu
        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }

        Gson gson = new Gson();
        JsonObject jsonObject = gson.fromJson(jsonBuilder.toString(), JsonObject.class);
        JsonArray idsArray = jsonObject.getAsJsonArray("ids");

        List<Integer> selectedIds = new ArrayList<>();
        for (JsonElement idElement : idsArray) {
            selectedIds.add(idElement.getAsInt());
        }

        // Lưu danh sách ID sản phẩm vào session
        req.getSession().setAttribute("listProductImport", selectedIds);

        // Trả về phản hồi JSON cho AJAX
        resp.setContentType("application/json");
        resp.getWriter().write("{\"status\": \"success\"}");
    }
}
