package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Notice;
import service.NoticeService;

/** 알림 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("notice")
public class NoticeController {
	
	ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private NoticeService noticeService = context.getBean("noticeService",NoticeService.class);
	
	/** 아이디를 통해 notice 데이터를 가져오는 기능 */
	@RequestMapping(value="searchById.do",produces = "application/json; charset=utf8")
	public @ResponseBody String searchById(@RequestParam("memberId") String memberId) {

		List<Notice> list = new ArrayList<>();
		
		StringBuffer sb = new StringBuffer();
		
		list = noticeService.searchById(memberId);
		
		sb.append("[");
		if(list.size() > 0) {
			for( int i=0; i<list.size() ; i++ ) {
				sb.append("{");
				sb.append("\"noticeNum\":\""+list.get(i).getNoticeNum()+"\",");
				sb.append("\"memberId\":\""+list.get(i).getMemberId()+"\",");
				sb.append("\"noticeContent\":\""+list.get(i).getNoticeContent()+"\",");
				sb.append("\"noticeType\":\""+list.get(i).getNoticeType()+"\",");
				sb.append("\"noticeTarget\":\""+list.get(i).getNoticeTarget()+"\"}");
				if(i != list.size()-1 ) {
					sb.append(",");
				}
			}
		}
		sb.append("]");
		
		return sb.toString();
		
	}//end of searchById
	
	/** noticeNum을 통한 notice 테이블 내의 데이터 삭제 기능 */
	@RequestMapping(value="deleteByNoticeNum.do",produces = "application/json; charset=utf8")
	public void deleteByNoticeNum(@RequestParam("noticeNum") int noticeNum) {
		
		noticeService.deleteByNoticeNum(noticeNum);
	}//end of deleteByNoticeNum
	
}//end of NoticeController
