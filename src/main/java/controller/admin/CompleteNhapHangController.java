package controller.admin;

import dao.BranchDAO;
import dao.ChiNhanhProductDAO;
import dao.NhapHangDAO;
import dao.NhapHangProductVariantDAO;
import model.ChiNhanh;
import model.ChiNhanhProduct;
import model.NhapHang;
import model.ProductInventory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet(urlPatterns = {"/admin/importSuccess"})
public class CompleteNhapHangController extends HttpServlet {
    private NhapHangProductVariantDAO nhapHangProductVariantDAO = new NhapHangProductVariantDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String[]> parameterMap = request.getParameterMap();
        ChiNhanhProductDAO chiNhanhProductDAO = new ChiNhanhProductDAO();

        for (String paramName : parameterMap.keySet()) {
            if (paramName.startsWith("quantity_")) {
                String idProductStr = paramName.substring("quantity_".length());
                int idProduct = Integer.parseInt(idProductStr);
                int quantity = Integer.parseInt(request.getParameter("quantity_" + idProductStr));
                double priceOne = Double.parseDouble(request.getParameter("priceOne_" + idProductStr));
                double priceAll = Double.parseDouble(request.getParameter("priceAll_" + idProductStr));
                int branchId = Integer.parseInt(request.getParameter("branch_" + idProductStr));
                int warehouseId = Integer.parseInt(request.getParameter("warehouse_" + idProductStr));

                boolean success = nhapHangProductVariantDAO.addNhapHangProductVariant(branchId, warehouseId, idProduct, quantity, priceOne, priceAll);
                BranchDAO branchDAO = new BranchDAO();
                NhapHangDAO nhapHangDAO = new NhapHangDAO();
                NhapHang nhapHang = nhapHangDAO.getById(branchId);
                ChiNhanh chiNhanh = branchDAO.getBranchById(nhapHang.getIdChiNhanh());
                ChiNhanhProduct chiNhanhProduct = new ChiNhanhProduct(
                        chiNhanh.getId(), idProduct, quantity, priceOne, priceAll
                );

                chiNhanhProductDAO.addOrUpdateQuantity(chiNhanh.getId(), idProduct, quantity, priceOne);
                if (!success) {
                    request.setAttribute("error", "Lỗi khi thêm sản phẩm có ID: " + idProduct);
                    return;
                }
            }
        }
        response.sendRedirect("/admin/manage_import");
    }
}
