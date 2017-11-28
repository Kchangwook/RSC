package domain;

/** board_singo 테이블에 담을 정보 class */
public class BoardSingo {
	
	/* 변수 */
	private int boardSingoNum; // col : board_singo_num
	private int boardNum; // col : board_num
	private String memberId;
	private String memberNick;
	private String boardContent; //col:board_content (board table)
	private String boardSingoReason; // col : board_singo_reason

	/* 생성자 */
	public BoardSingo() {
	}
	public BoardSingo(int boardSingoNum, int boardNum, String boardSingoReason) {
		super();
		this.boardSingoNum = boardSingoNum;
		this.boardNum = boardNum;
		this.boardSingoReason = boardSingoReason;
	}
	
	public BoardSingo(int boardSingoNum, int boardNum, String memberId, String memberNick, String boardContent, String boardSingoReason) {
		super();
		this.boardSingoNum = boardSingoNum;
		this.boardNum = boardNum;
		this.memberId = memberId;
		this.memberNick = memberNick;
		this.boardContent = boardContent;
		this.boardSingoReason = boardSingoReason;
	}
	
	/* Getter, Setter */
	public int getBoardSingoNum() {
		return boardSingoNum;
	}
	public void setBoardSingoNum(int boardSingoNum) {
		this.boardSingoNum = boardSingoNum;
	}
	
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	
	public String getBoardSingoReason() {
		return boardSingoReason;
	}
	public void setBoardSingoReason(String boardSingoReason) {
		this.boardSingoReason = boardSingoReason;
	}
	
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
		builder.append("BoardSingo [boardSingoNum=");
		builder.append(boardSingoNum);
		builder.append(", boardNum=");
		builder.append(boardNum);
		builder.append(", boardSingoReason=");
		builder.append(boardSingoReason);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class BoardSingo
