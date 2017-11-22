package domain;

/** like 테이블에 담을 정보 class */
public class Like {
	
	/* 변수 */
	private String memberId; // col : member_id
	private int boardNum; // col : board_num
	
	/* 생성자 */
	public Like() {
	}
	public Like(String memberId, int boardNum) {
		super();
		this.memberId = memberId;
		this.boardNum = boardNum;
	}
	
	/* Getter, Setter */
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Like [memberId=");
		builder.append(memberId);
		builder.append(", boardNum=");
		builder.append(boardNum);
		builder.append("]");
		return builder.toString();
	}

} // end of Like
