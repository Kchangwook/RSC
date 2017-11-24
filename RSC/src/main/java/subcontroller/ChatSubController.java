package subcontroller;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** 채팅을 위한 비동기 통신 컨트롤러 */
@RestController
@RequestMapping("chat")
public class ChatSubController {

	/** 채팅방 만들기 */
	@RequestMapping(value = "makeRoom.do",produces = "application/json; charset=utf8")
	public String makeRoom(@RequestBody Map<String,List<String>> map) {
		
		String msg = "성공";
		
		List<String> nicks = map.get("people");
		
		return msg;
		
	}//end of makeRoom
	
}//end of ChatSubController
