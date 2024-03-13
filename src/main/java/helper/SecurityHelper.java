package helper;

import config.SecurityConfig;
import model.Account;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

public class SecurityHelper {
    public static boolean isSecurityPage(HttpServletRequest request) {
        String urlPattern = UrlAnalysis.getUrlPattern(request);
        Set<String> roles = SecurityConfig.getAllRoles();

        for (String role : roles) {
            List<String> urlPatterns = SecurityConfig.getListRole(role);
            if (urlPatterns != null && urlPatterns.contains(urlPattern)) {
                return true;
            }
        }
        return false;
    }

    // Kiểm tra 'request' này có vai trò phù hợp hay không?
    public static boolean hasPermission(HttpServletRequest request, Account account) {
        String urlPattern = UrlAnalysis.getUrlPattern(request);

//        Set<String> allRoles = SecurityConfig.getAllRoles();

        List<String> urlPatterns = SecurityConfig.getListRole(account.getRole());
        if (urlPatterns != null && urlPatterns.contains(urlPattern)) {
            return true;
        }
        return false;
    }
}
