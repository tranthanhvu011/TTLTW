package controller.admin;

import com.mysql.cj.Session;
import dao.NewDAO;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(urlPatterns = {"/update-news"})
public class UpdateNewsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int get_id = Integer.parseInt(req.getParameter("id"));
        String getTitle = req.getParameter("title").trim();
        String getContent = req.getParameter("content").trim();
        String getUrl_image = req.getParameter("image").trim();
        boolean is_update = NewDAO.updateNew(get_id,getTitle,getContent,getUrl_image);
        HttpSession session = req.getSession();
        if(is_update){
            req.getSession().setAttribute("message","Cập nhật thành công!");
            resp.sendRedirect("/manage-news");
        }else {
            req.getSession().setAttribute("message","Cập nhật không thành công!");
            resp.sendRedirect("/update-news");
        }

    }
}
