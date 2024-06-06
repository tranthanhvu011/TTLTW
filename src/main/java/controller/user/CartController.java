package controller.user;

import com.google.gson.JsonObject;
import com.mysql.cj.Session;
import dao.CapacityDAO;
import dao.ProductVariantDAO;
import model.Cart;
import model.CartProduct;
import model.ProductVariant;
import service.ProductVariantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.gson.Gson;
import com.mysql.cj.xdevapi.JsonArray;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(urlPatterns = {"/cart"})
public class CartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String referer = request.getHeader("Referer");
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("add-cart")) {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            int productID = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean is_success = cart.add(productID,quantity);
            if (is_success) {
                session.setAttribute("message","Thêm vào giỏ hàng thành công");
                session.setAttribute("status",true);
                session.setAttribute("cart", cart);
//                response.sendRedirect(referer);
                int total = cart.getTotal();
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("total", total);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                // Gửi đối tượng JSON về client
                PrintWriter out = response.getWriter();
                out.print(jsonResponse);
                out.flush();
            } else {
                session.setAttribute("message", "không thể add");
                response.sendRedirect("/product-detail");
            }

        } else if (action.equalsIgnoreCase("view-cart")) {
            request.getRequestDispatcher("./view/viewtest.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("update-quantity")) {
            int quantity = Integer.parseInt(request.getParameter("quantity"));
             int id = Integer.parseInt(request.getParameter("idP"));
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            Map<Integer, CartProduct> data = cart.getData();
                if (data.containsKey(id)){
                    data.get(id).setQuantity(quantity);

                }
        } else if (action.equalsIgnoreCase("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            Map<Integer, CartProduct> data = cart.getData();
            if(data.containsKey(id)){
                data.remove(id);
                response.sendRedirect("/cart?action=view-cart");
            }
        } else if (action.equalsIgnoreCase("buynow")) {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            int productID = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            boolean is_success = cart.add(productID,quantity);
            if (is_success) {
                session.setAttribute("cart", cart);
                response.sendRedirect("/cart?action=view-cart");
            } else {
                session.setAttribute("message", "không thể add");
                response.sendRedirect("/product-detail");
            }

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
