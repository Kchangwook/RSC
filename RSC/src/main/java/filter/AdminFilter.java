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

public class AdminFilter implements Filter {

    public AdminFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		httpResponse.setContentType("text/html;charset=UTF-8");
		HttpSession session = httpRequest.getSession(false);

		if(session != null) {
			
			String level = (String)session.getAttribute("level"); // master/admin/member/visitor

			if( level!=null && ( level.equals("master") || level.equals("admin") ) ) {
				chain.doFilter(request, response); // 관리자인 경우 요청 페이지로 
			} else if ( level!=null &&  level.equals("member") ){
				httpResponse.sendRedirect("../board/readBoard.do?cnt=1"); // 회원인경우 loginMain으로
			} else {
				httpResponse.sendRedirect("../index.html"); // 비회원인 경우 메인페이지로
			}
		} else {
			httpResponse.sendRedirect("../index.html");
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
