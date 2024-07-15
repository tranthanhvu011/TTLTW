package controller.API;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

public class ProvinceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONParser parser = new JSONParser();

        try {
            FileReader reader = new FileReader(getServletContext().getRealPath("/") + "json/provinces.json");
            Object obj = parser.parse(reader);
            JSONArray jsonArray = (JSONArray) obj;
            String jsonString = jsonArray.toJSONString();
            System.out.println(jsonString); // Debugging line
            out.print(jsonString);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}
