package ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.SocketException;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

/** FTPService 클래스 */
public class FTPService {

	private String url = "59.187.224.177";
	private String id = "project";
	private String pwd = "1234";
	private int port = 5543;

	/** FTP 업로드 메소드 */
	public int upload(String dirName, String fileName) {

		FTPClient ftp = null;
		FileInputStream fis = null;
		int result = -1;

		try {

			File uploadfile = new File("C:/Users/kosta/git/RSC/RSC/src/main/webapp/info/" + dirName + "/" + fileName);


			ftp = new FTPClient();
			ftp.setControlEncoding("UTF-8");
			ftp.connect(url, port);
			ftp.login(id, pwd);
			ftp.enterLocalPassiveMode();
			ftp.changeWorkingDirectory(dirName);
			ftp.setFileType(FTP.BINARY_FILE_TYPE);

			fis = new FileInputStream(uploadfile);
			boolean isSuccess = ftp.storeFile(fileName, fis);

			if (isSuccess)
				result = 1;

		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {

			try {
				if (fis != null)
					fis.close();
				ftp.logout();
				if (ftp != null && ftp.isConnected())
					ftp.disconnect();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return result;

	}

	// /** FTP파일 삭제 메소드 */
	// public static int delete(String remoteFile, String fileName,
	// HttpServletRequest request) {
	//
	// FTPClient ftp = null;
	//
	// String url = "59.187.224.177";
	// String id = "project";
	// String pwd = "1234";
	// int port = 5543;
	//
	// int result = -1;
	//
	// try {
	// ftp = new FTPClient();
	// ftp.setControlEncoding("UTF-8");
	// ftp.connect(url, port);
	// ftp.login(id, pwd);
	// ftp.enterLocalPassiveMode();
	// ftp.changeWorkingDirectory(remoteFile);
	// ftp.setFileType(FTP.BINARY_FILE_TYPE);
	//
	// boolean isSuccess = ftp.deleteFile(fileName);
	//
	// if (isSuccess)
	// result = 1;
	//
	// } catch (SocketException e) {
	// e.printStackTrace();
	// } catch (IOException e) {
	// e.printStackTrace();
	// } finally {
	//
	// try {
	// ftp.logout();
	// if (ftp != null && ftp.isConnected())
	// ftp.disconnect();
	//
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
	//
	// return result;
	//
	// }

	public int download(String filePath, String fileName, String dirName) throws Exception {
		FTPClient client = null;
		FileOutputStream fos = null;
		File f = null;

		int result = -1;
		try {

			f = new File("C:/Users/kosta/git/RSC/RSC/src/main/webapp/info/" + dirName, fileName);
			client = new FTPClient();
			client.setControlEncoding("UTF-8");
			client.connect(url, port);
			int resultCode = client.getReplyCode();
			if (FTPReply.isPositiveCompletion(resultCode) == false) {
				client.disconnect();
				System.out.println("FTP 서버에 연결할 수 없습니다.");
			} else {
				client.setSoTimeout(5000);
				boolean isLogin = client.login(id, pwd);
				if (isLogin == false) {
					System.out.println("FTP 서버에 로그인 할 수 없습니다.");
				}
				client.enterLocalPassiveMode();
				client.setFileType(FTP.BINARY_FILE_TYPE);
				client.changeWorkingDirectory(filePath);
				fos = new FileOutputStream(f);
				boolean isSuccess = client.retrieveFile(fileName, fos);
				if (isSuccess) {
					result = 1;
				} else {
					System.out.println("파일 다운로드를 할 수 없습니다.");
				}
				client.logout();
			}
		} catch (Exception e) {
			System.out.println("FTP Exception : " + e);
		} finally {

			try {
				if (fos != null)
					fos.close();
				if (client != null && client.isConnected())
					client.disconnect();
			} catch (Exception e) {
			}
		}
		
		return result;
	}

}// end of FtpClient
