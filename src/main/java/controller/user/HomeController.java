package controller.user;

import model.Product;
import service.ProductService;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Inject
    private ProductService productService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        List<Product> products = productService.findAllProductForHomePage();
        req.setAttribute("products", products);
        HttpSession session = req.getSession();
        String language = req.getParameter("lang");
        System.out.print(language + "fjlasfkjasbfsagbfsa");
        if (language != null) {
            session.setAttribute("lang", language);
        }
        req.getRequestDispatcher("/view/home.jsp").forward(req, resp);

    }
}
