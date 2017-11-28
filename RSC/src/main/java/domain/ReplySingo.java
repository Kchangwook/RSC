package domain;

/** reply_singo 테이블에 담을 정보 class */
public class ReplySingo {
	
	/* 변수 */
	private int replySingoNum; // col : reply_singo_num
	private int replyNum; // col : reply_num
	private int boardNum;
	private String memberId;
	private String memberNick;
	private String replyContent;
	private String replySingoReason; // col : reply_singo_reason
	
	/* 생성자 */
	public ReplySingo() {
	}
	public ReplySingo(int replySingoNum, int replyNum, String replySingoReason) {
		super();
		this.replySingoNum = replySingoNum;
		this.replyNum = replyNum;
		this.replySingoReason = replySingoReason;
	}
	
	public ReplySingo(int replySingoNum, int replyNum, int boardNum, String memberId, String memberNick, String replyContent, String replySingoReason) {
		super();
		this.replySingoNum = replySingoNum;
		this.replyNum = replyNum;
		this.boardNum = boardNum;
		this.memberId = memberId;
		this.memberNick = memberNick;
		this.replyContent = replyContent;
		this.replySingoReason = replySingoReason;
	}

	/* Getter, Setter */
	public int getReplySingoNum() {
		return replySingoNum;
	}
	public void setReplySingoNum(int replySingoNum) {
		this.replySingoNum = replySingoNum;
	}
	
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	
	public String getReplySingoReason() {
		return replySingoReason;
	}
	public void setReplySingoReason(String replySingoReason) {
		this.replySingoReason = replySingoReason;
	}
	
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	
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
	
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ReplySingo [replySingoNum=");
		builder.append(replySingoNum);
		builder.append(", replyNum=");
		builder.append(replyNum);
		builder.append(", replySingoReason=");
		builder.append(replySingoReason);
		builder.append("]");
		return builder.toString();
	}

} // end of class ReplySingo
