package service;

import dao.LikeDAO;
import domain.Like;

/** like 데이터를 이용한 서비스*/
public class LikeService {
	
	/* 변수 */
	private LikeDAO likeDAO;
	
	/* 프로퍼티 */
	public void setLikeDAO(LikeDAO likeDAO) {
		this.likeDAO = likeDAO;
	}
	
	/* 함수 */
	/** 좋아요 등록하는 함수 */
	public boolean addLike(Like l) {
		return likeDAO.addLike(l);
	}
	
	/** 좋아요 삭제하는 함수 */
	public boolean delLike(Like l) {
		return likeDAO.delLike(l);
	}
	
	/** 게시판 번호로 좋아요 목록 불러오는 함수 */
	public boolean selectLike(Like l) {
		return likeDAO.searchLike(l);
	}
	
} // end of LikeService
