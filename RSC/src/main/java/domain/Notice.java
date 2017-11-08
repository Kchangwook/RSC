package domain;

/** notice 테이블에 담을 정보 class */
public class Notice {

	/* 변수 */
	private int noticeNum; // col : notice_num
	private String memberId; // col : member_id
	private String noticeContent; // col : notice_content
	
	/* 생성자 */
	public Notice() {
	}
	public Notice(int noticeNum, String memberId, String noticeContent) {
		super();
		this.noticeNum = noticeNum;
		this.memberId = memberId;
		this.noticeContent = noticeContent;
	}
	
	/* Getter, Setter */
	public int getNoticeNum() {
		return noticeNum;
	}
	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Notice [noticeNum=");
		builder.append(noticeNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append(", noticeContent=");
		builder.append(noticeContent);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class notice
