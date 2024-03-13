package controller.user;

import model.News;
import service.NewService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/page/news")
public class NewsControllerSelect extends HttpServlet {
    private NewService newService;

    @Override
    public void init() {
        // Khởi tạo NewService, đảm bảo đã cấu hình đúng
        this.newService = new NewService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Optional<News> news = newService.SelectNewsIndex(1);
        Optional<News> news2 = newService.SelectNewsIndex(2);
        Optional<News> news3 = newService.SelectNewsIndex(3);
        Optional<News> news4 = newService.SelectNewsIndex(4);
        Optional<News> news5 = newService.SelectNewsIndex(5);
        Optional<News> news6 = newService.SelectNewsIndex(6);
        Optional<News> news7 = newService.SelectNewsIndex(7);
        Optional<News> news8 = newService.SelectNewsIndex(8);
        Optional<News> news9 = newService.SelectNewsIndex(9);
        if (news.isPresent()) {
            request.setAttribute("news", news.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news2.isPresent()) {
            request.setAttribute("news2", news2.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news3.isPresent()) {
            request.setAttribute("news3", news3.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news4.isPresent()) {
            request.setAttribute("news4", news4.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news5.isPresent()) {
            request.setAttribute("news5", news5.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news6.isPresent()) {
            request.setAttribute("news6", news6.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news7.isPresent()) {
            request.setAttribute("news7", news7.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news8.isPresent()) {
            request.setAttribute("news8", news8.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        if (news9.isPresent()) {
            request.setAttribute("news9", news9.get());
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy ảnh");
        }
        request.getRequestDispatcher("/view/news.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }


}