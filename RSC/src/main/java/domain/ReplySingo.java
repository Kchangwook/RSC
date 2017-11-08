package domain;

/** reply_singo 테이블에 담을 정보 class */
public class ReplySingo {
	
	/* 변수 */
	private int replySingoNum; // col : reply_singo_num
	private int replySingo; // col : reply_num
	private String replySingoReason; // col : reply_singo_reason
	
	/* 생성자 */
	public ReplySingo() {
	}
	public ReplySingo(int replySingoNum, int replySingo, String replySingoReason) {
		super();
		this.replySingoNum = replySingoNum;
		this.replySingo = replySingo;
		this.replySingoReason = replySingoReason;
	}
	
	/* Getter, Setter */
	public int getReplySingoNum() {
		return replySingoNum;
	}
	public void setReplySingoNum(int replySingoNum) {
		this.replySingoNum = replySingoNum;
	}
	
	public int getReplySingo() {
		return replySingo;
	}
	public void setReplySingo(int replySingo) {
		this.replySingo = replySingo;
	}
	
	public String getReplySingoReason() {
		return replySingoReason;
	}
	public void setReplySingoReason(String replySingoReason) {
		this.replySingoReason = replySingoReason;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ReplySingo [replySingoNum=");
		builder.append(replySingoNum);
		builder.append(", replySingo=");
		builder.append(replySingo);
		builder.append(", replySingoReason=");
		builder.append(replySingoReason);
		builder.append("]");
		return builder.toString();
	}

} // end of class ReplySingo
