package ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.SocketException;

/** FTP와 실질적으로 통신하는 클래스 */
//
public class FTPService {

	/* 변수 */
	private FTPClientImpl ftp;
	     
	/* 프로퍼티 */
	public void setFTPClientImpl(FTPClientImpl ftpClient) {
		
		this.ftp = ftpClient;
		
	}//end of setFTPClient
	
	/* 함수 */
	/** FTP 업로드 메소드 */
	public int upload(String localFile, String remoteFile, String fileName) {
		
		ftp.connect(remoteFile);
		FileInputStream fis = null;
		File uploadfile = new File(localFile);

		int result = -1;

		try {
			
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

	}//end of upload
	
	/** FTP파일 삭제 메소드 */
	public int delete(String remoteFile, String fileName) {

		int result = -1;

		try {
			ftp.connect(remoteFile);

			boolean isSuccess = ftp.deleteFile(fileName);

			if (isSuccess)
				result = 1;

		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {

			try {
				ftp.logout();
				if (ftp != null && ftp.isConnected())
					ftp.disconnect();

			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return result;

	}//end of delete
	
}//end of FTPService
