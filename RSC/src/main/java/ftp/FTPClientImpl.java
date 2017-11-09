package ftp;

import java.io.IOException;

import org.apache.commons.net.ftp.FTPClient;

/** FTP Client를 구현하는 클래스 */
public class FTPClientImpl extends FTPClient {

	/* 변수 */
	private String url;
	private String id;
	private String pwd;
	private int port;
	
	/* 프로퍼티 */
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	
	/* 함수 */
	/** FTP Connection을 생성하는 함수 */
	public void connect() {
		try {
			super.connect(url,port);
			super.login(id, pwd);
			super.enterLocalPassiveMode();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}//end of connect
	
}//end of FTPClientImpl
