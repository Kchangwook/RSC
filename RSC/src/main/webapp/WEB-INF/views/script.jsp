<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<script>
		//�α��� ���н� �޼��� �˾�
		function getMessage() {

			var msg = document.getElementById("msg").value;

			if (msg != "")
				alert(msg);

		}

		window.onload = getMessage();

		//�ʼ� ������ ��� �ԷµǾ����� Ȯ��
		function checkInfo() {

			var id = document.getElementById("id").value;
			var nick = document.getElementById("nick").value;
			var pwd = document.getElementById("pwd").value;

			if (id == "") {
				alert("���̵� �Է��ϼ���");
				return false;
			} else if (pwd == "") {
				alert("��й�ȣ�� �Է��ϼ���");
				return false;
			} else if (nick == "") {
				alert("�г����� �Է��ϼ���");
				return false;
			} else {
				document.getElementById("frm").submit();
			}

		}

		//������ �г����� �ִ��� Ȯ��
		function checkSameNick() {
			var nick = document.getElementById("nick").value;
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					document.getElementById("msg").innerText = resData;
				}
			}

			xhttp.open("GET", "../join/checkNick.do?nick=" + nick, true);
			xhttp.send();
		}

		//������ ���̵� �ִ��� Ȯ��
		function checkSameId() {
			var id = document.getElementById("id").value;
			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					document.getElementById("msg").innerText = resData;
				}
			}

			xhttp.open("GET", "../join/checkId.do?id=" + id, true);
			xhttp.send();
		}

		//����� Ŭ���ϸ� �˸� ��� �˾�
		function viewAlertList() {
			var alertHtml = '';
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData = JSON.parse(resData);

					if (resData == null) {
						alertHtml += '<li>'
								+ '<a rel="nofollow" href="#" class="dropdown-item d-flex">'
								+ '<div class="msg-body">'
								+ '<span>�˸��� �����ϴ�</span>' + '</div>' + '</a>'
								+ '</li>';
					} else {
						for (i = 0; i < resData.length; i++) {
							if (resData[i].noticeType == 1) { //�׷����
								alertHtml += '<li>'
										+ '<a onClick="deleteGroupNotice(\''+resData[i].noticeTarget+'\',\''+resData[i].noticeContent+'\')" class="dropdown-item d-flex">'
										+ '<div class="msg-body">' + '<span>'
										+ resData[i].noticeContent + '</span>'
										+ '</div>' + '</a>' + '</li>';
							} else if (resData[i].noticeType == 2) { //ģ����û
								alertHtml += '<li>'
										+ '<a onClick="addFriendNotice(\''+resData[i].noticeTarget+'\',\''+resData[i].noticeContent+'\')" class="dropdown-item d-flex">'
										+ '<div class="msg-body">' + '<span>'
										+ resData[i].noticeContent + '</span>'
										+ '</div>' + '</a>' + '</li>';
							} else {
								alertHtml += '<li>'
										+ '<a onClick="deleteNotice('
										+ resData[i].noticeNum
										+ ')" class="dropdown-item d-flex">'
										+ '<div class="msg-body">' + '<span>'
										+ resData[i].noticeContent + '</span>'
										+ '</div>' + '</a>' + '</li>';

							}
						}
					}
					document.getElementById("viewAlert").innerHTML = alertHtml;
				}
			};

			xhttp.open("POST", "../notice/searchById.do?memberId=" + '${sessionScope.id}', true);
			xhttp.send();
		}
		
		//notice_type 1, �׷���� �˾�â_���� ����� ���� �˾�â�� ����
		function deleteGroupNotice(groupNum, noticeContent) {
			
			if(confirm(noticeContent) == true) {
				document.form.submit;
			} else {
				return;
			}
		}
		
		//notice_type 2, ģ����û �˾�â_���� ����� ���� �˾�â�� ����
		function addFriendNotice(friendId, noticeContent) {
			
			if(confirm(noticeContent) == true) {
				document.form.submit;
			} else {
				return;
			}
			
		}

		//notice_type 3, �˾��� �˸� Ŭ���ϸ� notice ���̺��� ����
		function deleteNotice(noticeNum) {

			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {

				}
			}

			xhttp.open("POST", "../notice/deleteByNoticeNum.do?noticeNum=" + noticeNum, true);
			xhttp.send();
		}
	</script>
</body>
</html>