package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/** 기본 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("basic")
public class BasicController {

	/** 시작 페이지 이동 */
	@RequestMapping("start.do")
	public String start() {
		
		return "index";
		
	}//end of start
	
}//end of StartController
