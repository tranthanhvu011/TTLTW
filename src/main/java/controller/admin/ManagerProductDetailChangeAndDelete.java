package controller.admin;

import dao.ProductDeltailDAO;
import org.json.JSONArray;
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
            System.out.print("idProduct" + idProduct + "idComment" + idComment + "idReply" + idReply);
            String content = jsonObject.optString("content", "");
            ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
            boolean result = false;
            JSONArray jsonArray = new JSONArray();
            switch (action) {
                case "changeReply":
                    result = productDeltailDAO.UpdateReply(idProduct, idComment, idReply, content);
                    break;
                case "deleteReply":
                    result = productDeltailDAO.deleteReplyWithComment(idProduct, idComment, idReply);
                    jsonArray = productDeltailDAO.getReplyByComment(idProduct, idComment);
                    break;
                default:
                    out.print("{\"status\": \"error\", \"message\": \"Unknown action\"}");
                    out.flush();
                    return;
            }
            JSONObject responseJson = new JSONObject();
            if (result) {
                responseJson.put("status", "success");
                responseJson.put("message", "Cập nhật thành công!");
                if (action.equals("deleteReply")) {
                    responseJson.put("replies", jsonArray);
                }
            } else {
                responseJson.put("status", "error");
                responseJson.put("message", "Cập nhật thất bại!");
            }
            out.print(responseJson.toString());
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\": \"error\", \"message\": \"" + e.getMessage() + "\"}");
            out.flush();
        }
    }
}
