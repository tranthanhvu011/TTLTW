package controller.admin;

import dao.ProductDeltailDAO;
import org.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {"/admin/manage_comment_product_detail"})
public class ManageCommentProductDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            req.getRequestDispatcher("/viewAdmin/manage_comment_product_detail.jsp").forward(req, resp);
            return;
        }
        if (action.equalsIgnoreCase("active")) {
            doGet_Active(req, resp);
        } else if (action.equalsIgnoreCase("delete")){
            doGet_Delete(req, resp);
        } else if (action.equalsIgnoreCase("notActive")) {
            doGet_Not_Active(req, resp);
        }else if (action.equalsIgnoreCase("getReply")) {
            doGet_Reply(req,resp);
        }
    }

    protected void doGet_Delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idComment = req.getParameter("id");
        String idProduct = req.getParameter("idProduct");
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        if (productDeltailDAO.deleteComment(Integer.parseInt(idProduct), Integer.parseInt(idComment))) {
            req.getSession().setAttribute("message", "Xóa thành công bình luận");
            resp.sendRedirect("/admin/manage_comment_product_detail");
        }else{
            req.getSession().setAttribute("message", "Xóa thất bại bình luận");
            resp.sendRedirect("/admin/manage_comment_product_detail");
        }
    }
    protected void doGet_Active(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idComment = req.getParameter("id");
        String idProduct = req.getParameter("idProduct");
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        if (productDeltailDAO.isActiveComment(Integer.parseInt(idProduct), Integer.parseInt(idComment))) {
            req.getSession().setAttribute("message", "Duyệt bình luận thành công");
            resp.sendRedirect("/admin/manage_comment_product_detail");
        }else{
            req.getSession().setAttribute("message", "Duyệt bình luận thất bại");
            resp.sendRedirect("/admin/manage_comment_product_detail");
        }

    }
    protected void doGet_Not_Active(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idComment = req.getParameter("id");
        String idProduct = req.getParameter("idProduct");
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        if (productDeltailDAO.isNotActiveComment(Integer.parseInt(idProduct), Integer.parseInt(idComment))) {
            req.getSession().setAttribute("message", "Tắt bình luận thành công");
            resp.sendRedirect("/admin/manage_comment_product_detail");
        }else{
            req.getSession().setAttribute("message", "Tắt bình luận thất bại");
            resp.sendRedirect("/admin/manage_comment_product_detail");
        }
    }
    protected void doGet_Reply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idProduct = req.getParameter("idProduct");
        String idComment = req.getParameter("idComment");
        System.out.println("Received idProduct: " + idProduct + ", idComment: " + idComment);
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        JSONArray jsonArray = productDeltailDAO.getReplyByComment(Integer.parseInt(idProduct), Integer.parseInt(idComment));
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.print(jsonArray.toString());
        out.flush();
    }

        @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String action = req.getParameter("action");
       if (action.equalsIgnoreCase("reply")) {
           doPost_Reply(req,resp);
       }
    }
    protected void doPost_Reply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String nameQTV = req.getParameter("nameQTV");
            String replyContent = req.getParameter("replyContent");
            int idProduct = Integer.parseInt(req.getParameter("idProduct"));
            int idComment = Integer.parseInt(req.getParameter("idComment"));
            ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
            if (productDeltailDAO.addReply(idProduct,idComment,nameQTV,replyContent)) {
                req.getSession().setAttribute("message", "Trả lời bình luận thành công");
                resp.sendRedirect("/viewAdmin/manage_comment_product_detail.jsp");
            }else{
                req.getSession().setAttribute("message", "Trả lời bình luận thất bại");
                resp.sendRedirect("/viewAdmin/manage_comment_product_detail.jsp");
            }
    }
    }
