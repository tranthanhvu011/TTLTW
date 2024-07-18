package controller.admin;

import dao.ProductDeltailDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        } else {
            req.getRequestDispatcher("/viewAdmin/manage_comment_product_detail.jsp").forward(req, resp);
        }}

    protected void doGet_Delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    protected void doGet_Active(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idComment = req.getParameter("id");
        System.out.print(" co cl gi ma khoc " + idComment);
        String idProduct = req.getParameter("idProduct");
        System.out.print(" co cl gi ma khoc " + idProduct);

        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        if (productDeltailDAO.isActiveComment(Integer.parseInt(idProduct), Integer.parseInt(idComment))) {
            req.getSession().setAttribute("message", "Active tài khoản thành công");
            req.getRequestDispatcher("/viewAdmin/manage_comment_product_detail.jsp").forward(req, resp);
        }else{
            req.setAttribute("message", "Active tài khoản thất bại");
            req.getRequestDispatcher("/viewAdmin/manage_comment_product_detail.jsp").forward(req, resp);
        }

    }
}
