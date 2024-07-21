package controller.google;

import dao.LoggingLogin;
import helper.CookieUtils;
import model.Account;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;


@WebServlet(name ="LoginGoogleHandle" ,value = "/LoginGoogleHandle")
public class LoginGoogleHandle extends HttpServlet {
  private static final long serialVersionUID = 1L;
  public LoginGoogleHandle() {
    super();
  }
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException, IOException {
    CookieUtils.deleteCookie(request,response,"SID");
    String code = request.getParameter("code");
      String accessToken = GoogleUtils.getToken(code);
      GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
      String name = googlePojo.getName();
      String email = googlePojo.getEmail();
      UserService userService = new UserService();
    LoggingLogin loggingLogin = new LoggingLogin();
    String lastIPLogin = request.getRemoteAddr();
    String countryLoginByIp = loggingLogin.getCountryFromIP(lastIPLogin);
      List<Account> accountList = userService.findUserByEmail(email);
      if(accountList!=null){
        request.getSession().setAttribute("account", accountList.get(0));
        response.sendRedirect("/home");
      }else{
        Account account = new Account();
        account.setIs_active(1);
        account.setEmail(email);
        account.setFirst_name(name);
        account.setLast_name("");
        account.setPhone_number("");
        account.setRole("user");
        account.setCountryLoginByIp(countryLoginByIp);
        account.setLastIPLogin(lastIPLogin);
        account.setAddress("null");
        account.setGender(1);
        Date dob = new Date(2024, 1, 20);
        account.setDob(dob);
        account.setPhone_number("0");
        try {
          userService.save(account);
          request.getSession().setAttribute("account", account);
          response.sendRedirect("/home");
        } catch (SQLException e) {
          throw new RuntimeException(e);
        }

      }
    }
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    doGet(request, response);
  }
}