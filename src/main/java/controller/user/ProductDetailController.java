package controller.user;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import dao.CapacityDAO;
import dao.ProductImageDAO;
import dao.ProductVariantDAO;
import dao.ProductDeltailDAO;

import model.Capacity;
import model.Color;
import model.ProductImage;
import model.ProductVariant;

import org.json.JSONObject;
import service.ProductDetalService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

@WebServlet(urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null) {
            doGet_Index(request, response);
        } else if(action.equalsIgnoreCase("productvariant")) {
            doGet_ProductVariant(request, response);
        } else if(action.equalsIgnoreCase("productvariantcapacity")) {
            doGet_ProductVariantCapacity(request, response);
        }
    }
    protected void doGet_Index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDetalService productDetalService = new ProductDetalService();
        String productID = request.getParameter("id");
        int id = Integer.parseInt(productID);
        List<ProductVariant> listProductVariant = productDetalService.getAllProductVariant(id);

        Map<String, String> colorImageMap = new LinkedHashMap<>();
        for (ProductVariant variant : listProductVariant) {
            String colorName = variant.getColor().getName();
            // Kiểm tra nếu màu sắc chưa có trong map
            if (!colorImageMap.containsKey(colorName)) {
                colorImageMap.put(colorName, variant.getProductImages().get(0).getImage_url());
            }
        }

        Set<String> capacitiesSet = new LinkedHashSet<>();
        for (ProductVariant variant : listProductVariant) {
            capacitiesSet.add(variant.getCapacity().getName());
        }
        List<String> capacitiesList = new LinkedList<>(capacitiesSet);
        request.setAttribute("colorImageMap", colorImageMap);
        request.setAttribute("capacities", capacitiesList);
        request.setAttribute("productVariant", listProductVariant);
        request.getRequestDispatcher("/view/product_detail.jsp").forward(request, response);
    }
    protected void doGet_ProductVariant(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter printWriter = response.getWriter();
        String productID = request.getParameter("productID");
        String colorID = request.getParameter("colorID");
        ProductImageDAO productImageDAO = new ProductImageDAO();
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("productVariant", productVariantDAO.getProductVariantByColorIDProductID(Integer.parseInt(productID), Integer.parseInt(colorID)).get(0));
        responseData.put("first", productImageDAO.getAllProductImageByProductVariantId(productVariantDAO
                .getProductVariantByColorIDProductID(Integer.parseInt(productID), Integer.parseInt(colorID)).get(0).getId()).get(0));
        responseData.put("last", productImageDAO.getAllProductImageByProductVariantId(productVariantDAO
                .getProductVariantByColorIDProductID(Integer.parseInt(productID), Integer.parseInt(colorID)).get(0).getId()));

        Gson gson = new Gson();

        System.out.println(productImageDAO.getAllProductImageByProductVariantId(productVariantDAO
                .getProductVariantByColorIDProductID(Integer.parseInt(productID), Integer.parseInt(colorID)).get(0).getId()).get(0).getImage_url());
        request.getSession().setAttribute("name", productImageDAO.getAllProductImageByProductVariantId(productVariantDAO
                .getProductVariantByColorIDProductID(Integer.parseInt(productID), Integer.parseInt(colorID)).get(0).getId()).get(0).getImage_url());
        printWriter.print(gson.toJson(responseData));
    }
    protected void doGet_ProductVariantCapacity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter printWriter = response.getWriter();
        String productID = request.getParameter("productID");
        String capacityID = request.getParameter("capacityID");
        String colorID = request.getParameter("colorID");
        ProductVariantDAO productVariantDAO = new ProductVariantDAO();
        CapacityDAO capacityDAO = new CapacityDAO();
        int capacityID1 = capacityDAO.findCapacityByName(capacityID).getId();
        Gson gson = new Gson();
        printWriter.print(gson.toJson(productVariantDAO.getProductVariantByCapacityIDProductID(Integer.parseInt(productID), capacityID1, Integer.parseInt(colorID))));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        JSONObject commentProductDetail = new JSONObject();
        commentProductDetail.put("content", request.getParameter("content"));
        commentProductDetail.put("nameComment", request.getParameter("nameComment"));
        commentProductDetail.put("phoneNumber", request.getParameter("phoneNumber"));
        commentProductDetail.put("idProduct", request.getParameter("idProduct"));
        commentProductDetail.put("isActive", 0);
        commentProductDetail.put("timestamp", request.getParameter("timestamp"));
        int idProduct = Integer.parseInt(request.getParameter("idProduct"));
        JsonArray commentProductArray = new JsonArray();
        commentProductArray.add(String.valueOf(commentProductDetail));
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        String jsonString = commentProductDetail.toString();
        System.out.println(jsonString);

        boolean result = productDeltailDAO.insertComment(commentProductDetail,idProduct );
        if (result) {
            request.getSession().setAttribute("message", "Bình luận của bạn đã được gửi và đang đợi xét duyệt.");
        }
        response.sendRedirect("/product-detail?id=" + idProduct);

    }

}
