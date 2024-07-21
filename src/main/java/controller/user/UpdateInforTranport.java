package controller.user;

import dao.TransportDAO;
import model.Account;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@WebServlet("/update-infor-transport")
public class UpdateInforTranport extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Account account = (Account) req.getSession().getAttribute("account");
        String getName = req.getParameter("newName");
        String getPhoneNumber = req.getParameter("newPhoneNumber");
        String getTinhThanh = req.getParameter("tinhThanh");
        String getHuyen = req.getParameter("huyen");
        String getXa = req.getParameter("xa");
        String nameTinhThanh = findNameWithType(getTinhThanh, getServletContext().getRealPath("/") + "json/provinces.json");
        String nameHuyen = findNameWithType(getHuyen, getServletContext().getRealPath("/") + "json/districts.json");
        String nameXa = findNameWithType(getXa, getServletContext().getRealPath("/") + "json/wards.json");
        String getAddress = nameTinhThanh + ", " + nameHuyen + ", " + nameXa;

        // Kiểm tra xem số điện thoại có phải là kiểu số không
        if (!isNumeric(getPhoneNumber)) {
            req.getSession().setAttribute("status",false);
            req.getSession().setAttribute("message", "Số điện thoại phải là kiểu số!");
            resp.sendRedirect("/payment");
            return;
        }

        // Tiếp tục xử lý nếu số điện thoại là kiểu số
        boolean is_success = TransportDAO.updateTransportInfoByAccount_ID(account.getId(), getName, getPhoneNumber, getAddress);

        if (is_success) {
            req.getSession().setAttribute("status",true);
            req.getSession().setAttribute("message", "Cập nhật thành công!");
        } else {
            req.getSession().setAttribute("message", "Cập nhật không thành công!");
        }

        resp.sendRedirect("/payment");
    }

    // Hàm kiểm tra kiểu số
    private boolean isNumeric(String str) {
        if (str == null) {
            return false;
        }
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    public String findNameWithType(String code, String jsonFilePath) {
        try {
            String jsonData = new String(Files.readAllBytes(Paths.get(jsonFilePath)));
            JSONArray jsonArray = new JSONArray(jsonData);

            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                if (jsonObject.getString("code").equals(code)) {
                    return jsonObject.getString("name_with_type");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
