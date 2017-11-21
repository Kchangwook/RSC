package domain;

/** friend_request 테이블에 담을 정보 class */
public class FriendRequest {

	/* 변수 */
	private int friendRequestNum; // col : friend_request_num
	private String memberId; // col : member_id
	private String friendId; // col : friend_id
	private int friendRequestAccept; // col : friend_request_accept
	
	/* 생성자 */
	public FriendRequest() {
	}
	
	public FriendRequest(String memberId, String friendId) {
		super();
		this.memberId = memberId;
		this.friendId = friendId;
	}

	public FriendRequest(int friendRequestNum, String memberId, String friendId, int frinendRequestAccept) {
		super();
		this.friendRequestNum = friendRequestNum;
		this.memberId = memberId;
		this.friendId = friendId;
		this.friendRequestAccept = frinendRequestAccept;
	}
	
	/* Getter, Setter */
	public int getFriendRequestNum() {
		return friendRequestNum;
	}
	public void setFriendRequestNum(int friendRequestNum) {
		this.friendRequestNum = friendRequestNum;
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getFriendId() {
		return friendId;
	}
	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}

	public int getFrinendRequestAccept() {
		return friendRequestAccept;
	}
	public void setFrinendRequestAccept(int frinendRequestAccept) {
		this.friendRequestAccept = frinendRequestAccept;
	}
	
	// toString
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("FriendRequest [friendRequestNum=");
		builder.append(friendRequestNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append(", friendId=");
		builder.append(friendId);
		builder.append(", frinendRequestAccept=");
		builder.append(friendRequestAccept);
		builder.append("]");
		return builder.toString();
	}
	
	
} // end of class FriendRequest
