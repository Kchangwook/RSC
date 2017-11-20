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

	alert(document.getElementById("mypageSrc").value);
	
	document.getElementById("mypageSrc").value = document
			.getElementById("mypageImg").value;

}

// 필수 정보가 모두 입력되었는지 확인
function checkMypageInfo() {

	var pwd = document.getElementById("myPw").value;
	var nick = document.getElementById("myNick").value;
	var interest = document.getElementsByName("myInterest");

	var count = 0;

	for (var i = 0; i < interest.length; i++)
		if (interest[i].checked)
			count++;

	if (count == 0) {
		alert("관심사를 선택하세요");
		return false;
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