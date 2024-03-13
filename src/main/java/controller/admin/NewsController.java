package controller.admin;

import dao.NewDAO;
import model.News;
import service.NewService;
import service.OrderProductVariantService;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/manage-news"})
public class NewsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<News> list  = NewService.getAllNews();
        req.setAttribute("datanew",list);
        String getAction = req.getParameter("action");
        if (getAction != null) {
            doPost(req, resp);
        } else {
            req.getRequestDispatcher("./viewAdmin/manage_news.jsp").forward(req,resp);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<News> list  = NewService.getAllNews();
        req.setAttribute("datanew",list);
        String getAction = req.getParameter("action");
        HttpSession session = req.getSession();
//        int get_ID = Integer.parseInt(req.getParameter("id"));
        String get_ID = req.getParameter("id");
       switch (getAction){
           case "delete":
               boolean is_Delete = NewService.deleteNews(Integer.parseInt(get_ID));
               if (is_Delete){
                   resp.sendRedirect("/manage-news");
                   session.setAttribute("message","Xóa thành công!");
               }else{
                   session.setAttribute("message","Xóa không thành công!");
               }
               break;
           case "edit":
               News news = NewService.getNewsByID(Integer.parseInt(get_ID));
               req.setAttribute("data",news);
               req.getRequestDispatcher("./viewAdmin/edit_news.jsp").forward(req,resp);
               break;
           case "add":
               String title = req.getParameter("title");
               String content = req.getParameter("content");
               String url_image = req.getParameter("image");
               boolean is_add = NewService.addNews(title, content, url_image);
               if (is_add) {
                   session.setAttribute("message", "Thêm thành công!");
                   resp.sendRedirect("/add-news");
               } else {
                   session.setAttribute("message", "Thêm không thành công!");
                   resp.sendRedirect("/add-news");
               }
               break;
//           case "search":
//                String get_keyword = req.getParameter("keyword").trim();
//                List<News> listNewSearch = NewService.searchNews(get_keyword);
//                if (listNewSearch!= null){
//                    req.setAttribute("listNewsAlter",listNewSearch);
//                    req.getRequestDispatcher("./viewAdmin/manage_news.jsp").forward(req,resp);
//                }else {
//                    session.setAttribute("message","Không tìm thấy kết quả");
//                    resp.sendRedirect("/manage-news");
//                }
//               break;
       }
    }
}
//    String get_title = req.getParameter("title");
//    String get_content = req.getParameter("content");
//    String get_image = req.getParameter("image");
//    boolean is_add = NewService.addNews(get_title,get_content,get_image);
//               if (is_add){
//                       req.getRequestDispatcher("./viewAdmin/add_news.jsp");
//                       session.setAttribute("message","Thêm thành công");
//                       resp.sendRedirect("/manage-news");
//
//                       }else {
//                       session.setAttribute("message","Thêm không thành công");
//                       }