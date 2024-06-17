package controller.user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import com.google.gson.Gson;

@WebServlet("/api/translations")
public class TranslationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lang = request.getParameter("lang");
        if (lang == null || lang.isEmpty()) {
            lang = "en"; // default language
        }

        ResourceBundle bundle = ResourceBundle.getBundle("messages", new Locale(lang));
        Map<String, String> translations = new HashMap<>();
        bundle.keySet().forEach(key -> translations.put(key, bundle.getString(key)));

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(translations));
        out.flush();
    }
}