package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/** index.html로 시작하기 위한 컨트롤러 */
@Controller
@RequestMapping("start")
public class StartController {

	@RequestMapping("index.do")
	public String start() {
		
		return "index";
		
	}//end of start
	
}//end of StartController
