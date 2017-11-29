package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemberFilter implements Filter {

    public MemberFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		httpResponse.setContentType("text/html;charset=UTF-8");
		HttpSession session = httpRequest.getSession(false);

		if(session != null) {
			
			String level = (String)session.getAttribute("level"); // master/admin/member
			if( level!=null && ( level.equals("master") || level.equals("admin") || level.equals("member") ) ) {
				chain.doFilter(request, response);
			} else {
				httpResponse.sendRedirect("../index.html");
			}
		} else {
			httpResponse.sendRedirect("../index.html");
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
