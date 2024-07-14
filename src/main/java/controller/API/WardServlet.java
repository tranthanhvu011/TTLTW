package controller.API;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

public class WardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        JSONParser parser = new JSONParser();
        String districtCode = request.getParameter("districtCode");

        try {
            FileReader reader = new FileReader(getServletContext().getRealPath("/") + "json/wards.json");
            Object obj = parser.parse(reader);
            JSONArray jsonArray = (JSONArray) obj;
            JSONArray filteredArray = new JSONArray();

            for (Object ward : jsonArray) {
                JSONObject jsonWard = (JSONObject) ward;
                if (jsonWard.get("parent_code").equals(districtCode)) {
                    filteredArray.add(jsonWard);
                }
            }

            String jsonString = filteredArray.toJSONString();
            System.out.println(jsonString); // Debugging line
            out.print(jsonString);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}
