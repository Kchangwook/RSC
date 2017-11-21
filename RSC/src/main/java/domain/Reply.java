package domain;

import java.util.Date;

/** reply 테이블에 담을 정보 class */
public class Reply {

	/* 변수 */
	private int replyNum; // col : reply_num
	private int boardNum; // col : board_num
	private String memberId; // col : member_id
	private String replyContent; // col : reply_content
	private Date replyTime; // col : reply_time
	private int replySingoFlag; // col : reply_singo_flag
	private String memberNick; // col : member_nick
	
	/* 생성자 */
	public Reply() {
	}
	public Reply(int replyNum, int boardNum, String memberId, String replyContent, Date replyTime, int replySingoFlag,
			String memberNick) {
		super();
		this.replyNum = replyNum;
		this.boardNum = boardNum;
		this.memberId = memberId;
		this.replyContent = replyContent;
		this.replyTime = replyTime;
		this.replySingoFlag = replySingoFlag;
		this.memberNick = memberNick;
	}


	/* Getter, Setter */
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	
	public Date getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	
	public int getReplySingoFlag() {
		return replySingoFlag;
	}
	public void setReplySingoFlag(int replySingoFlag) {
		this.replySingoFlag = replySingoFlag;
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
		builder.append("Reply [replyNum=");
		builder.append(replyNum);
		builder.append(", boardNum=");
		builder.append(boardNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append(", replyContent=");
		builder.append(replyContent);
		builder.append(", replyTime=");
		builder.append(replyTime);
		builder.append(", replySingoFlag=");
		builder.append(replySingoFlag);
		builder.append(", memberNick=");
		builder.append(memberNick);
		builder.append("]");
		return builder.toString();
	}
		
} // end of class Reply
