package service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import dao.FriendDAO;
import domain.Friend;
import ftp.FTPService;

@Transactional
/** board 데이터를 이용한 서비스 */
public class FriendService {

	/* 변수 */
	private FriendDAO dao;
	private FTPService ftp;

	/* 프로퍼티 */
	public void setFriendDAO(FriendDAO dao) {
		this.dao = dao;
	}

	public void setFTPService(FTPService ftp) {
		this.ftp = ftp;
	}

	/* 함수 */
	/** 아이디에 해당하는 친구 목록 불러오기 */
	public List<Friend> getList(String id) {

		List<Friend> list = dao.getList(id);
		
		try {
			// ftp에 파일 업로드
			for (Friend f : list) {
				if (!f.getFriendImg().equals("resources/img/profile.jpg")) {
					String fileName[] = f.getFriendImg().split("/");
					ftp.download("member", fileName[fileName.length - 1], "member");
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}

		return list;

	}// end of getList

	/** 친구 삭제하기 */
	public String deleteFriend(Friend f) {

		String msg = "redirect:getList.do";

		if (!dao.deleteFriend(f))
			msg = "error";

		String id = f.getMemberId();
		f.setMemberId(f.getFriendId());
		f.setFriendId(id);

		if (!dao.deleteFriend(f))
			msg = "error";

		return msg;

	}// end of deleteFriend
	
	/** 친구인지 확인하기 */
	public boolean isFriend(Friend f) {
		
		return dao.isFriend(f);
		
	}//end of isFriend
	
	/** 친구 추가하기 */
	public boolean addFriend(Friend f) {
		
		dao.addFriend(f);
		
		String memberId = f.getFriendId();
		f.setFriendId(f.getMemberId());
		f.setMemberId(memberId);
		return dao.addFriend(f);
		
	}//end of addFriend

}// end of FriendService
