package controller.admin;

import dao.ProductDeltailDAO;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import static java.lang.System.out;

@WebServlet(urlPatterns = {"/admin/manage_comment_product_detail_change_delete"})
public class ManagerProductDetailChangeAndDelete extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        try {

        String requestBody = req.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);
        JSONObject jsonObject = new JSONObject(requestBody);
        String action = jsonObject.getString("action");
        int idProduct = jsonObject.getInt("idProduct");
        int idComment = jsonObject.getInt("idComment");
        int idReply = jsonObject.getInt("idReply");
        String content = jsonObject.getString("content");
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        boolean result = false;
        System.out.print("action " + action + "idProduct " + idProduct + "idComment " + idComment + "idReply " + idReply + "content " + content);
        switch (action) {
            case "changeReply":
                result = productDeltailDAO.UpdateReply(idProduct, idComment, idReply, content);
                break;
            case "deleteReply":
                break;
            default:
                out.print("{\"status\": \"error\", \"message\": \"Unknown action\"}");
                out.flush();
                return;
        }
        if (result) {
            out.print("{\"status\": \"success\", \"message\": \"Cập nhật thành công!\"}");
        } else {
            out.print("{\"status\": \"error\", \"message\": \"Cập nhật thất bại!\"}");
        }
        out.flush();
    } catch (Exception e) {
        out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
        out.flush();
    }
}}