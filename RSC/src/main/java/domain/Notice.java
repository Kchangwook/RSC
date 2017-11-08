package domain;

/** notice 테이블에 담을 정보 class */
public class Notice {

	/* 변수 */
	private int noticeNum; // col : notice_num
	private String memberId; // col : member_id
	private String noticeContent; // col : notice_content
	private int noticeType; // col : notice_type
	
	/* 생성자 */
	public Notice() {
	}
	public Notice(int noticeNum, String memberId, String noticeContent, int noticeType) {
		super();
		this.noticeNum = noticeNum;
		this.memberId = memberId;
		this.noticeContent = noticeContent;
		this.noticeType = noticeType;
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
	
	public int getNoticeType() {
		return noticeType;
	}
	public void setNoticeType(int noticeType) {
		this.noticeType = noticeType;
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
		builder.append(", noticeType=");
		builder.append(noticeType);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class notice
