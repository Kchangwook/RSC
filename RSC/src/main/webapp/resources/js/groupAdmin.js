function groupDelete(groupNum, groupName){
	var address=document.getElementById("address").value;
	if(confirm("확인 버튼을 누르실 경우 \n["+groupName+"] 그룹에 대한 삭제 요청 투표가 진행됩니다.\n계속 하시겠습니까?")){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);
				if(resData==true){
					alert("투표 전송을 성공하였습니다.");
				} else {
					alert("투표 전송 중 오류가 발생하였습니다.");
				}
			}
		}
		xhttp.open("POST", address+"/group/deleteGroupNotice.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("groupNum="+groupNum+"&groupName="+groupName);
	} else {
		return false;
	}
}

function joinGroup(groupNum, groupName, memberId){
	var address=document.getElementById("address").value;
	if(confirm("'"+groupName+"' 그룹에 가입을 요청하시겠습니까?")){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);
				if(resData==true){
					alert("가입 요청을 성공하였습니다.");
				} else {
					alert("가입 요청을 실패하였습니다.");
				}
			}
		}
		xhttp.open("POST", address+"/group/joinGroup.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("groupNum="+groupNum+"&memberId="+memberId); 
	}
}

function singoGroup(groupNum){
	var address=document.getElementById("address").value;
	var reason = prompt("신고 사유를 입력해 주세요.");
	if(reason=='' || reason==' '){
		alert("신고 사유를 입력해 주세요.");
		singoGroup(groupNum);
	} else {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);
				if(resData==true){
					alert("신고가 성공적으로 접수 되었습니다.");
				} else {
					alert("신고 접수에 실패 하였습니다. 다시 시도해주세요.");
				}
			}
		}
		xhttp.open("POST", address+"/singo/groupSingo.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("groupNum="+groupNum+"&groupSingoReason="+reason);
	}
}
