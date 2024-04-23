package helper;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtils {

    public static void deleteCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }
    }


}

