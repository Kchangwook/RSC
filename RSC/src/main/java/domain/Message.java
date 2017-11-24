package domain;

import java.util.Date;

/** message 테이블에 담을 정보 class */
public class Message {
	
	/* 변수 */
	private int chatNum; // col : chat_num
	private int messageNum; // col : message_num
	private String memberId; // col : member_id
	private String memberNick; // col : member_nick
	private String memberImg; // col : member_img
	private Date messageSendingTime; //col : message_sending_time
	private String messageContent;// col : message_content
	private String messageFile; // col : message_file
	
	/* 생성자 */
	public Message() {
	}
	public Message(int chatNum, int messageNum, String memberId, String memberNick, String memberImg, Date messageSendingTime, String messageContent,
			String messageFile) {
		super();
		this.chatNum = chatNum;
		this.messageNum = messageNum;
		this.memberId = memberId;
		this.memberNick = memberNick;
		this.memberImg = memberImg;
		this.messageSendingTime = messageSendingTime;
		this.messageContent = messageContent;
		this.messageFile = messageFile;
	}
	
	/* Getter, Setter */
	public int getChatNum() {
		return chatNum;
	}
	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}
	
	public int getMessageNum() {
		return messageNum;
	}
	public void setMessageNum(int messageNum) {
		this.messageNum = messageNum;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public Date getMessageSendingTime() {
		return messageSendingTime;
	}
	public void setMessageSendingTime(Date messageSendingTime) {
		this.messageSendingTime = messageSendingTime;
	}
	
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	
	public String getMessageFile() {
		return messageFile;
	}
	public void setMessageFile(String messageFile) {
		this.messageFile = messageFile;
	}
	
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	public String getMemberImg() {
		return memberImg;
	}
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	
	/* toString */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Message [chatNum=");
		builder.append(chatNum);
		builder.append(", messageNum=");
		builder.append(messageNum);
		builder.append(", memberId=");
		builder.append(memberId);
		builder.append(", memberNick=");
		builder.append(memberNick);
		builder.append(", memberImg=");
		builder.append(memberImg);
		builder.append(", messageSendingTime=");
		builder.append(messageSendingTime);
		builder.append(", messageContent=");
		builder.append(messageContent);
		builder.append(", messageFile=");
		builder.append(messageFile);
		builder.append("]");
		return builder.toString();
	}
	
} // end of class Message
