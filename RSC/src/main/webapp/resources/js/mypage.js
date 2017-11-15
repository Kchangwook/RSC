//이미지 src보여주기
function changeSrc() {

	document.getElementById("imgSrc").value = document.getElementById("memberImg").value;
	
}

// 필수 정보가 모두 입력되었는지 확인
function checkInfo() {

	var nick = document.getElementById("nick").value;
	var pwd = document.getElementById("pwd").value;
	var pwd_info;

	if (pwd == "") {
		alert("비밀번호를 입력하세요");
		return false;
	} else {
		document.getElementById("frm").submit();
	}

}

//비밀번호 비일치 시 메세지 팝업
function getMessage() {

	var msg = document.getElementById("msg").value;

	if (msg != "")
		alert(msg);

}

window.onload = getMessage();

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
			console.log("resData"+resData);
			document.getElementById("mypage_msg").innerText = resData;
		}
	}

	xhttp.open("GET", "../join/checkNick.do?nick=" + nick, true);
	xhttp.send();
}