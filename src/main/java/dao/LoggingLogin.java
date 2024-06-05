package dao;

import config.JDBIConnector;
import model.Logging_Login;
import org.jdbi.v3.core.Jdbi;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class LoggingLogin {
    private static final String IPINFO_API_KEY = "266521ab10481c";

    public static void Logging_Login(HttpServletRequest request, String username, boolean success){
        String ipUser = request.getRemoteAddr();
        String nameCountry = getCountryFromIP(ipUser);
        System.out.print(nameCountry);
        String status = success? "thành công":"thất bại";
        Jdbi jdbi = JDBIConnector.me();
        jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO logging_login (username, status, ipUser, countryName) Values (?,?,?,?)")
                        .bind(0, username)
                        .bind(1, status)
                        .bind(2, ipUser)
                        .bind(3, nameCountry)
                        .execute());
    }
    private static String getClientIp(HttpServletRequest request) {
        String remoteAddr = "";
        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }

        return remoteAddr;
    }
    public static String getCountryFromIP(String ipAddress) {
        String country = "";
        String city = "";
        String countryAndCity = "";
        try {
            URL url = new URL("https://ipinfo.io/" + ipAddress + "/json?token=" + IPINFO_API_KEY);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Parse JSON response và lấy quốc gia
            JSONParser parser = new JSONParser();
            JSONObject responseJson = (JSONObject) parser.parse(response.toString());
            city = (String) responseJson.get("city");
            country = (String) responseJson.get("country");
            countryAndCity = "Thanh pho " + city + " Quoc gia " + country;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return countryAndCity;
    }
    public static int countLogging_Login(String ipRemote) {
        String query = "select count(*) from logging_login where ipUser=:ipUser AND status like 'thất bại'";
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
