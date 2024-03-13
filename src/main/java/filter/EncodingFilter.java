package filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpFilter;
import java.io.IOException;


@WebFilter(urlPatterns = {"/*"})
@WebInitParam(name = "encoding", value = "utf-8")
public class EncodingFilter extends HttpFilter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        chain.doFilter(req, res);
    }

}
