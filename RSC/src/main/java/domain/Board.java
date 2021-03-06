package domain;

import java.util.Date;

/** board 테이블에 담을 정보 class */
public class Board {
	
	/* 변수 */
	private int groupNum; // col : group_num
	private int boardNum; // col : board_num
	private String memberId; // col : member_id
	private String boardContent; // col : board_content
	private String boardFile; // col : board_file
	private Date boardTime; // col : board_time
	private int boardSingoFlag; // col : board_singo_flag
	private int boardLike; // col : board_like
	private int boardCnt; // col : board_cnt
	private String memberNick; // col : member_nick 
	private String memberImg; // col : member_img
	private int cnt; // 게시글을 불러올 개수를 담을 변수

	/* 생성자 */
	public Board() {
	}
	public Board(int groupNum, int boardNum, String memberId, String boardContent, String boardFile, Date boardTime,
			int boardSingoFlag, int boardLike, int boardCnt, String memberNick,String memberImg) {
		super();
		this.groupNum = groupNum;
		this.boardNum = boardNum;
		this.memberId = memberId;
		this.boardContent = boardContent;
		this.boardFile = boardFile;
		this.boardTime = boardTime;
		this.boardSingoFlag = boardSingoFlag;
		this.boardLike = boardLike;
		this.boardCnt = boardCnt;
		this.memberNick = memberNick;
		this.memberImg = memberImg;
	}
	public Board(String memberId, String boardContent) {
		super();
		this.memberId = memberId;
		this.boardContent = boardContent;
		this.boardFile = " ";
	}
	public Board(int groupNum, String memberId, String boardContent) {
		super();
		this.groupNum = groupNum;
		this.memberId = memberId;
		this.boardContent = boardContent;
		this.boardFile = " ";
	}
	public Board(String memberId, int cnt) {
		super();
		this.memberId = memberId;
		this.cnt = cnt;
	}
	
	public Board(int groupNum, int cnt) {
		super();
		this.groupNum = groupNum;
		this.cnt = cnt;
	}
	
	/* Getter, Setter */
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
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
	
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	
	public String getBoardFile() {
		return boardFile;
	}
	public void setBoardFile(String boardFile) {
		this.boardFile = boardFile;
	}
	
	public Date getBoardTime() {
		return boardTime;
	}
	public void setBoardTime(Date boardTime) {
		this.boardTime = boardTime;
	}
	
	public int getBoardSingoFlag() {
		return boardSingoFlag;
	}
	public void setBoardSingoFlag(int boardSingoFlag) {
		this.boardSingoFlag = boardSingoFlag;
	}
	
	public int getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}
	
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
	
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	public String getMemberImg() {
		return memberImg;
	}
	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getCnt() {
		return cnt;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Board [groupNum=");
		builder.append(groupNum);
		builder.append(", boardNum=");
		builder.append(boardNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append(", boardContent=");
		builder.append(boardContent);
		builder.append(", boardFile=");
		builder.append(boardFile);
		builder.append(", boardTime=");
		builder.append(boardTime);
		builder.append(", boardSingoFlag=");
		builder.append(boardSingoFlag);
		builder.append(", boardLike=");
		builder.append(boardLike);
		builder.append(", boardCnt=");
		builder.append(boardCnt);
		builder.append(", memberNick=");
		builder.append(memberNick);
		builder.append(", memberImg=");
		builder.append(memberImg);
		builder.append(", cnt=");
		builder.append(cnt);
		builder.append("]");
		return builder.toString();
	}
	 
} // end of class Board