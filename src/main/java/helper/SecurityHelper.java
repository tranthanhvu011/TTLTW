package helper;

import config.SecurityConfig;
import model.Account;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

public class SecurityHelper {

    public static boolean isSecurityPage(HttpServletRequest request) {
        String urlPattern = UrlAnalysis.getUrlPattern(request);
        System.out.println("Checking security for URL: " + urlPattern); // Logging

        Set<String> roles = SecurityConfig.getAllRoles();

        for (String role : roles) {
            List<String> urlPatterns = SecurityConfig.getListRole(role);
            if (urlPatterns != null && urlPatterns.contains(urlPattern)) {
                return true;
            }
        }
        return false;
    }

    public static boolean hasPermission(HttpServletRequest request, Account account) {
        String urlPattern = UrlAnalysis.getUrlPattern(request);
        System.out.println("Checking permission for URL: " + urlPattern + " with role: " + account.getRole()); // Logging

        List<String> urlPatterns = SecurityConfig.getListRole(account.getRole());
        if (urlPatterns != null && urlPatterns.contains(urlPattern)) {
            return true;
        }
        return false;
    }
}
