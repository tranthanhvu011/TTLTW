package controller.admin;

import dao.NhapHangProductVariantDAO;
import model.NhapHangProductVariant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manage_import_details")
public class ImportDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NhapHangProductVariantDAO nhapHangProductVariantDAO = new NhapHangProductVariantDAO();
        List<NhapHangProductVariant> nhapHangProductVariantList = nhapHangProductVariantDAO.getAll();
        req.setAttribute("nhaphangdetail",nhapHangProductVariantList);
        req.getRequestDispatcher("/viewAdmin/xemthongtinnhaphang.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
