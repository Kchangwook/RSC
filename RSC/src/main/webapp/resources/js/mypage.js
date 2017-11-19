//이미지 src보여주기
function changeMypageSrc() {

	document.getElementById("mypageSrc").value = document.getElementById("mypageImg").value;
	
}

// 필수 정보가 모두 입력되었는지 확인
function checkMypageInfo() {

	var pwd = document.getElementById("mypagePw").value;
	var interest = document.getElementById("mypageInterest").value;
	
	if (pwd == "") {
		alert("비밀번호를 입력하세요");
		return false;
	} else {
		document.getElementById("frmMypage").submit();
	}

}

//비밀번호 비일치 시, 정보 수정 실패 시 메세지 팝업
/*function getMessage() {
	
	var msg = document.getElementById("msg").value;

	if (msg != "")
		alert(msg);

}

//window.onload = getMessage();
*/
/*//정보수정에서 사용할 아이디
function getMemberId() {

	memberId = document.getElementById("mypageMemberId").value;

}

window.onload = getMemberId();*/

// 동일한 닉네임이 있는지 확인
function checkSameNick(nick) {
	//var nick = document.getElementById("nick").value;
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;

			document.getElementById("mypage_msg").innerText = resData;
		}
	}

	xhttp.open("GET", "../join/checkNick.do?nick=" + nick, true);
	xhttp.send();
}