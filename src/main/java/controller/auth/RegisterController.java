package controller.auth;

import Utils.ValidationUtils;
import dao.LoggingLogin;
import org.json.JSONArray;
import org.json.JSONObject;
import service.EmailSender;
import service.EmailService;
import service.PasswordResetService;
import service.UserService;
import dao.EmailDAO;
import dao.UserDAO;
import model.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static java.lang.Integer.parseInt;
import static java.sql.Date.valueOf;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private PasswordResetService passwordResetService;
    UserService userService = new UserService();
    EmailService emailService = new EmailService();

    @Override
    public void init() throws ServletException {
        try {
            EmailDAO emailDAO = new EmailDAO();
            UserDAO userDAO = new UserDAO();
            EmailService emailService = new EmailService();
            this.passwordResetService = new PasswordResetService(emailDAO, userDAO);
        } catch (Exception e) {
            e.printStackTrace();
            // Xử lý thêm hoặc log lỗi để bạn có thể xác định vấn đề
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            LoggingLogin loggingLogin = new LoggingLogin();
            String lastIPLogin = req.getRemoteAddr();
            String countryLoginByIp = loggingLogin.getCountryFromIP(lastIPLogin);
            String dobParam = req.getParameter("dob");
            Account user = new Account();
            String tinhThanh = req.getParameter("tinhThanh");
            String huyen = req.getParameter("huyen");
            String xa = req.getParameter("xa");
            String nameTinhThanh = findNameWithType(tinhThanh, getServletContext().getRealPath("/") + "json/provinces.json");
            String nameHuyen = findNameWithType(huyen, getServletContext().getRealPath("/") + "json/districts.json");
            String nameXa = findNameWithType(xa, getServletContext().getRealPath("/") + "json/wards.json");
            System.out.println("Tỉnh/Thành: " + nameTinhThanh);
            System.out.println("Huyện: " + nameHuyen);
            System.out.println("Xã: " + nameXa);
            String xaHuyenTinh = nameTinhThanh + " " + nameHuyen + " " + nameXa;
            user.setEmail(req.getParameter("email"));
            user.setFirst_name(req.getParameter("first_name"));
            user.setLast_name(req.getParameter("last_name"));
            user.setPassword(req.getParameter("password"));
            user.setAddress(xaHuyenTinh);
            user.setGender(parseInt(req.getParameter("gender")));
            user.setDob(Date.valueOf(dobParam));
            user.setPhone_number(req.getParameter("phone_number"));
            user.setRole("user");
            user.setIs_active(0);
            user.setLastIPLogin(lastIPLogin);
            user.setCountryLoginByIp(countryLoginByIp);
            String re_password = req.getParameter("re-password");
            System.out.print(user.getEmail());
            System.out.print(user.getPassword());
            System.out.print(user.getFirst_name());
            System.out.print(user.getLast_name());
            System.out.print(user.getDob());
            System.out.print(user.getAddress());
            System.out.print(user.getPhone_number());
            System.out.print(user.getGender());

            List<String> errors = new ArrayList<>();

            if (!ValidationUtils.isValidEmail(user.getEmail())) {
                errors.add("Định dạng email không hợp lệ.\n");
            }
            if (!ValidationUtils.isValidPhone(user.getPhone_number())) {
                errors.add("Số điện thoại không hợp lệ.\n");
            }
            if (!ValidationUtils.isValidPassword(user.getPassword())) {
                errors.add("Mật khẩu phải chứa ít nhất một chữ số, một chữ thường, một chữ hoa, một ký tự đặc biệt và dài từ 8 đến 20 ký tự.\n");
            }
            if (errors.isEmpty()) {
                boolean hasErrors = false;

                if (user.getFirst_name().isEmpty()) {
                    req.setAttribute("firstName", "Vui Lòng Nhập Họ");
                    hasErrors = true;
                }
                if (user.getLast_name().isEmpty()) {
                    req.setAttribute("lastName", "Vui Lòng Nhập Tên");
                    hasErrors = true;
                }
                if (user.getAddress().isEmpty()) {
                    req.setAttribute("address", "Vui Lòng Nhập Địa Chỉ");
                    hasErrors = true;
                }
                if (dobParam == null || dobParam.isEmpty()) {
                    req.setAttribute("getDOB", "Vui Lòng Chọn Ngày Sinh");
                    hasErrors = true;
                }else{
                    user.setDob(valueOf(req.getParameter("dob")));

                }
                if (!user.getPassword().equals(re_password)) {
                    req.setAttribute("passwordNo", "Mật Khẩu Không Trùng Nhau Vui Lòng Nhập Lại");
                    hasErrors = true;
                }
                if (!userService.checkUserEmail(user.getEmail())) {
                    req.setAttribute("emailNotNull", "Email đã có người đăng ký");
                    hasErrors = true;
                }
                if (hasErrors) {
                    req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                } else {
                    userService.save(user);
                    if (passwordResetService.emailExists(user.getEmail())) {
                        passwordResetService.createAndSendResetCode(user.getEmail());
                        req.getSession().setAttribute("userEmailRegister", user.getEmail());
                        resp.sendRedirect("/view/enter_Code_Register.jsp");
                    } else {
                        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                    }
                }
            } else {
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
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

