package dao;

import config.JDBIConnector;
import model.Logging_Login;
import org.jdbi.v3.core.Jdbi;

import javax.servlet.http.HttpServletRequest;

public class LoggingLogin {
    public static void Logging_Login(HttpServletRequest request, String username, boolean success){
        String ipUser = request.getRemoteAddr();
        String status = success? "thành công":"thất bại";
        Jdbi jdbi = JDBIConnector.me();
        jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO logging_login (username, status, ipUser) Values (?,?,?)")
                        .bind(0, username)
                        .bind(1, status)
                        .bind(2, ipUser)
                        .execute());
    }
    public static int countLogging_Login(String ipRemote) {
        String query = "select count(*) from logging_login where ipUser=:ipUser";
        try {
            Jdbi jdbi = JDBIConnector.me();
            int count = jdbi.withHandle(handle ->
                    handle.createQuery(query)
                            .bind("ipUser", ipRemote)
                            .mapTo(Integer.class)
                            .findOnly());
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }


}
