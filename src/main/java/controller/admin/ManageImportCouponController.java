package controller.admin;

import dao.BranchDAO;
import dao.NhapHangDAO;
import model.ChiNhanh;
import model.NhapHang;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/manage_import_coupon"})
public class ManageImportCouponController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NhapHangDAO nhapHangDAO = new NhapHangDAO();
        BranchDAO branchDAO = new BranchDAO();
        List<ChiNhanh> chiNhanhList = branchDAO.getAllBranches();
        List<NhapHang> list = nhapHangDAO.getAll();
        req.setAttribute("listNhapHang",list);
        req.setAttribute("chiNhanhList",chiNhanhList);
        req.getRequestDispatcher("/viewAdmin/quanlyphieunhaphang.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if ("add".equals(action)) {
            int idChiNhanh = Integer.parseInt(req.getParameter("chiNhanh"));
            String tenNguoiDaiDien = req.getParameter("tenNguoiDaiDien");

            NhapHangDAO nhapHangDAO = new NhapHangDAO();
            boolean success = nhapHangDAO.add(idChiNhanh, tenNguoiDaiDien);

            if (success) {
                req.setAttribute("message", "Thêm phiếu nhập hàng thành công");
            } else {
                req.setAttribute("error", "Thêm phiếu nhập hàng thất bại");
            }
            doGet(req, resp);
        }
    }
}
