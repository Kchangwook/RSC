package domain;

/** friend 테이블에 담을 정보 class */
public class Friend {
	
	/* 변수 */ 
	private String memberId; // col : member_id
	private String friendId; // col : friend_id;
	private String friendNick;
	private String friendImg;
	
	/* 생성자 */
	public Friend() {
	}
	
	public Friend(String memberId, String friendId, String friendNick, String friendImg) {
		super();
		this.memberId = memberId;
		this.friendId = friendId;
		this.friendNick = friendNick;
		this.friendImg = friendImg;
	}

	public Friend(String memberId, String friendId) {
		super();
		this.memberId = memberId;
		this.friendId = friendId;
	}
	
	/* Getter, Setter */
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
	public String getFriendNick() {
		return friendNick;
	}

	public void setFriendNick(String friendNick) {
		this.friendNick = friendNick;
	}

	public String getFriendImg() {
		return friendImg;
	}

	public void setFriendImg(String friendImg) {
		this.friendImg = friendImg;
	}

	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Friend [memberId=");
		builder.append(memberId);
		builder.append(", friendId=");
		builder.append(friendId);
		builder.append(", friendNick=");
		builder.append(friendNick);
		builder.append(", friendImg=");
		builder.append(friendImg);
		builder.append("]");
		return builder.toString();
	}



} // end of class Friend
