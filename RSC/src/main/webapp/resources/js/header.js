//이미지 src보여주기
function changeSrc() {

	alert("hello");
	document.getElementById("imgSrc").value = document.getElementById("memberImg").value;
	
}
// 내용 초기화
function clearContent() {

	document.getElementById("id").value = "";
	document.getElementById("pwd").value = "";
	document.getElementById("nick").value = "";
	document.getElementById("imgSrc").value = "";

	var interest = document.getElementsByName("memberInterest");

	for (var i = 0; i < interest.len.gth; i++)
		interest[i].checked = false;

	var radios = document.getElementsByName("memberInfoOpen");
	radios[0].checked = true;
	radios[1].checked = false;

}

// 로그인 실패시 메세지 팝업
function getMessage() {

	var msg = document.getElementById("msg").value;

	if (msg != "")
		alert("로그인에 실패했습니다.");

}

window.onload = getMessage();

// 필수 정보가 모두 입력되었는지 확인
function checkInfo() {

	var id = document.getElementById("id").value;
	var nick = document.getElementById("nick").value;
	var pwd = document.getElementById("pwd").value;
	var interest = document.getElementsByName("memberInterest");
	
	var count = 0;
	
	for(var i = 0;i<interest.length;i++)
		if(interest[i].checked)
			count++;
	
	if (id == "") {
		alert("아이디를 입력하세요");
		return false;
	} else if (pwd == "") {
		alert("비밀번호를 입력하세요");
		return false;
	} else if (nick == "") {
		alert("닉네임을 입력하세요");
		return false;
	} else if(count == 0){
		alert("관심사를 선택하세요");
		return false;
	} else{
		document.getElementById("frm").submit();
	}

}

// 동일한 닉네임이 있는지 확인
function checkSameNick() {
	var nick = document.getElementById("nick").value;
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			document.getElementById("join_msg").innerText = resData;
		}
	}

	xhttp.open("GET", "../join/checkNick.do?nick=" + nick, true);
	xhttp.send();
}

// 동일한 아이디가 있는지 확인
function checkSameId() {
	var id = document.getElementById("id").value;
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			document.getElementById("join_msg").innerText = resData;
		}
	}

	xhttp.open("GET", "../join/checkId.do?id=" + id, true);
	xhttp.send();
}

//회원 또는 그룹 검색
function searchMemberAndGroup(searchValue) {
	var alertHtml = '';
	var address = document.getElementById("address").value;
	
	if (searchValue == '' || searchValue.split(" ")[0] == '') {
		alertHtml += '<li>'
				+ '<a rel="nofollow" href="#" class="dropdown-item d-flex">'
				+ '<div class="search-body">'
				+ '<span>검색어를 입력하세요</span>' + '</div>' + '</a>'
				+ '</li>';
		document.getElementById("searchMemberAndGroup").innerHTML = alertHtml;
	} else {

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);

				if (resData.length == 0) {
					alertHtml += '<li>'
							+ '<a rel="nofollow" href="#" class="dropdown-item d-flex">'
							+ '<div class="search-body">'
							+ '<span>검색 결과가 없습니다</span>' + '</div>'
							+ '</a>' + '</li>';
				} else {
					for (i = 0; i < resData.length; i++) {
						if (resData[i].memberNick != null) {
							alertHtml += '<li>'
									+ '<a href="'+address+'/friend/getFriendInfo.do?friendId=' + resData[i].memberId + '" class="dropdown-item d-flex">'
									+ '<div class="search-body">'
									+ '<span>[회원] ' + resData[i].memberNick
									+ '</span>' + '</div>' + '</a>'
									+ '</li>';
						} else {
							alertHtml += '<li>'
									+ '<a onClick="moveToGroup(' + resData[i].groupNum + ')" class="dropdown-item d-flex">'
									+ '<div class="search-body">'
									+ '<span>[그룹] ' + resData[i].groupName
									+ '</span>' + '</div>' + '</a>'
									+ '</li>';
						}
					}
				}
				document.getElementById("searchMemberAndGroup").innerHTML = alertHtml;
			}
		};

		xhttp.open("POST", "../searchMemberAndGroup/searchByPart.do?part="+ searchValue, true);
		xhttp.send();
	}
}

// 검색한 회원으로 이동
function moveToMember(memberId) {
	
	alert('알림');
	location.href = 'friend/getFriendInfo.do?friendId='+memberId;
}

function moveToGroup(groupNum) {
	var address = document.getElementById("address").value;
	location.href= address+'/basic/group.do?groupNum='+groupNum;
}

// 알림에서 사용할 아이디
function getMemberId() {

	memberId = document.getElementById("noticeMemberId").value;

}

window.onload = getMemberId();

// 종모양 클릭하면 알림 모달 팝업
function viewAlertList() {
	var alertHtml = '';
	var address = document.getElementById("address").value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);

			if (resData.length==0) {
				alertHtml += '<li>'
						+ '<a rel="nofollow" href="#" class="dropdownitem d-flex">'
						+ '<div class="msgbody">' + '<span>알림이 없습니다</span>'
						+ '</div>' + '</a>' + '</li>';
			} else {
				for (i = 0; i < resData.length; i++) {
					if (resData[i].noticeType == 1) { // 그룹삭제
						alertHtml += '<li>'
								+ '<a onClick="deleteGroupNotice(\''
								+ resData[i].noticeTarget + '\',\''
								+ resData[i].noticeContent + '\',\''
								+ resData[i].noticeNum
								+ '\')" class="dropdownitem d-flex">'
								+ '<div class="msgbody">' + '<span>'
								+ resData[i].noticeContent + '</span>'
								+ '</div>' + '</a>' + '</li>';
					} else if (resData[i].noticeType == 2) { // 친구요청
						alertHtml += '<li>' + '<a onClick="addFriendNotice(\''
								+ resData[i].noticeTarget + '\',\''
								+ resData[i].noticeNum
								+ '\',this)" class="dropdownitem d-flex">'
								+ '<div class="msgbody">' + '<span>'
								+ resData[i].noticeContent + '</span>'
								+ '</div>' + '</a>' + '</li>';
					} else {
						alertHtml += '<li>' + '<a onClick="deleteNotice('
								+ resData[i].noticeNum
								+ ')" class="dropdownitem d-flex">'
								+ '<div class="msgbody">' + '<span>'
								+ resData[i].noticeContent + '</span>'
								+ '</div>' + '</a>' + '</li>';

					}
				}
			}
			document.getElementById("viewAlert").innerHTML = alertHtml;
		}
	};

	xhttp.open("POST", address+"/notice/searchById.do?memberId=" + memberId, true);
	xhttp.send();
}

// notice_type 1, 그룹삭제 팝업창_실제 기능은 없고 팝업창만 있음
function deleteGroupNotice(groupNum, noticeContent, noticeNum) {
	var confirmFlag = confirm(noticeContent+"\n\n확인 : 찬성\n취소 : 반대");
	var address = document.getElementById("address").value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			alert(resData);
		}
	}
	xhttp.open("POST", address+"/group/voteGroupDelete.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("groupNum="+groupNum+"&confirmFlag="+confirmFlag+"&noticeNum="+noticeNum); 
}

// notice_type 2, 친구요청 팝업창_실제 기능은 없고 팝업창만 있음
function addFriendNotice(requestNum, noticeNum, notice) {
	
	var accept = confirm("친구 요청을 수락하시겠습니까?");
	var address = document.getElementById("address").value; 
	var xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			if(resData == 'success')
				notice.parentNode.removeChild(notice);
		}
	}

	xhttp.open("GET", address+"/notice/friendResult.do?result="+accept+"&requestNum="+requestNum+"&noticeNum="+noticeNum, true);
	xhttp.send();

}

// notice_type 3, 팝업된 알림 클릭하면 notice 테이블에서 삭제
function deleteNotice(noticeNum) {

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {

		}
	}

	xhttp.open("POST", "../notice/deleteByNoticeNum.do?noticeNum=" + noticeNum,
			true);
	xhttp.send();
}