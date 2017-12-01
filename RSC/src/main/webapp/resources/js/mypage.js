//화면에 표시하기
window.onload = function(){
	
	var interest = document.getElementById("reqInterest").value;
	var infoOpen = document.getElementById("reqOpenInfo").value;
	var reqinterest = interest.split(',');
	
	var interests = document.getElementsByName("myInterest");
	var info = document.getElementsByName("myInfoOpen");
	
	var index = 0;
	
	for(var i = 0;i<interests.length;i++){
		
		if(interests[i].value == reqinterest[index]){
			interests[i].checked = true;
			index++;
		}
		
	}
	
	for(var i = 0;i<info.length;i++){
		if(info[i].value == infoOpen)
			info[i].checked = true;
	}
}

//이미지 src보여주기
function changeMypageSrc() {
	
	document.getElementById("mypageSrc").value = document.getElementById("mypageImg").value;

}

//비밀번호 검증
function checkMypagePw(pw) {
	
	var pw = pw.charCodeAt(0);
	
	if( (32 <= pw && pw <= 47) ||
		(58 <= pw && pw <= 64) ||
		(91 <= pw && pw <= 96) ||
		(123 <= pw && pw <= 126)) {
		document.getElementById("mypage_msg").innerText = "비밀번호에 공백을 입력할 수 없습니다";
		return false;
	} else {
		document.getElementById("mypage_msg").innerText = "";
	}
}

//닉네임 검증
function checkMypageNick(nick) {
	
	var nick = nick.charCodeAt(0);
	
	if( (32 <= nick && nick <= 47) ||
		(58 <= nick && nick <= 64) ||
		(91 <= nick && nick <= 96) ||
		(123 <= nick && nick <= 126)) {
		document.getElementById("mypage_msg").innerText = "닉네임에 특수문자 및 공백을 입력할 수 없습니다";
		return false;
	} else {
		document.getElementById("mypage_msg").innerText = "";
		checkSameNick(nick);
	}
}

//동일한 닉네임이 있는지 확인
function checkSameNick(nick) {
	
	var nick = document.getElementById("nick").value;
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			if(resData == 'true') {
				document.getElementById("mypage_msg").innerText = "닉네임이 존재합니다.";
				document.getElementById("hiddenUpdateNick").value = 0;
			} else {
				document.getElementById("mypage_msg").innerText = "";
				document.getElementById("hiddenUpdateNick").value = 1;
			}
		}
	}

	xhttp.open("GET", "../join/checkNick.do?nick=" + nick, true);
	xhttp.send();
}

// 필수 정보가 모두 입력되었는지 확인
function checkMypageInfo() {

	var pwd = document.getElementById("myPw").value;
	var nick = document.getElementById("myNick").value;
	var interest = document.getElementsByName("myInterest");
	var msg = document.getElementById("mypage_msg").innerText;
	var hiddenUpdateNick = document.getElementById("hiddenUpdateNick").value;

	var count = 0;

	for (var i = 0; i < interest.length; i++)
		if (interest[i].checked)
			count++;
	
	if(msg != "") {
		alert(msg);
		return false;
	} else if (count == 0) {
		alert("관심사를 선택하세요");
		return false;
	} else if(hiddenUpdateNick==0) {
		alert("닉네임 중복을 확인해 주세요");
	} else {
		document.getElementById("frmMypage").submit();
	}
}

// 동일한 닉네임이 있는지 확인
function checkSameNick(nick) {
	// var nick = document.getElementById("nick").value;
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