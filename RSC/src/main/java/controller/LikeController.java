package controller;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.Like;
import service.LikeService;

/** 좋아요 기능을 위한 컨트롤러 */
@Controller
@RequestMapping("like")
public class LikeController {
	
	/* 변수 */
	private ApplicationContext context = new GenericXmlApplicationContext("/applicationContext.xml");
	private LikeService likeService = context.getBean("likeService", LikeService.class);
	
	/* 프로퍼티 */
	public void setService(LikeService service) {
		this.likeService = service;
	}
	
	/* 좋아요 목록 */
	@RequestMapping("like.do")
	public @ResponseBody boolean like(Like l) {
		boolean result = likeService.selectLike(l);
		return result;
	}
	
	/* 좋아요 등록 */
	@RequestMapping("addLike.do")
	public @ResponseBody boolean addLike(Like l) {
		boolean result = likeService.selectLike(l);
		if(result) {
			likeService.delLike(l);
		} else {
			likeService.addLike(l);
			result = false;
		}
		 
		return result;
	}
	
	/* 좋아요 취소 */
	@RequestMapping("delLike.do")
	public @ResponseBody boolean delLike(Like l) {
		boolean result = likeService.delLike(l);
		boolean result1 = likeService.selectLike(l);
		return result1;
	}

} // end of LikeController
