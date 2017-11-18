var contextPath = document.getElementById("contextPath").value;

// 라디오 버튼 선택 - 검색창 보이기/가리기
function viewSearchMemberInput(value){
	if(value=='selectMember'){
		document.getElementById("searchMemberInput").style.display='block';
	} else {
		document.getElementById("searchMemberInput").style.display='none';
		document.getElementById("searchMemberInputText").value='';
		document.getElementById("addedMember").innerHTML = '';
	}
}

// 검색창 입력 이벤트 마다 회원 검색
function searchNoticeMember(memberIdName){
	if(memberIdName!=''){
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);
				viewMemberDropdown(resData);
			}
		}
		xhttp.open("POST",contextPath+"/admin/searchMember.do?memberIdName="+memberIdName, true);
		xhttp.send(); 
	} else {
		document.getElementById("searchMemberDropdown").innerHTML='';
	}
}

// 검색된 회원 목록 구성
function viewMemberDropdown(resData){
	var memberListHTML = '';
	console.log(resData);	
	if(resData.length>0){
		for(i=0 ; i<resData.length ; i++){
			memberListHTML += '<p onclick="clickNoticeMember(\''+resData[i].memberId+'\')">ID : '+resData[i].memberId+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;닉네임 :'+resData[i].memberNick+'</p>';
		}
	}
	document.getElementById("searchMemberDropdown").innerHTML = memberListHTML;
	document.getElementById("searchMemberDropdown").classList.toggle("show");
}

// 검색 목록에서 선택시 - 선택된 멤버 리스트(주황 버튼)에 추가하고 검색목록 초기화 
function clickNoticeMember(memberId){
    var spanNode = document.createElement("span");
    spanNode.className = 'SpanAddedMember';
    spanNode.setAttribute('id',"span"+memberId);
    
    spanNode.setAttribute('onclick','deleteNoticeMember(\''+memberId+'\',this.id)');
    
    var textNode = document.createTextNode(memberId);
    spanNode.appendChild(textNode);
    
    document.getElementById("addedMember").appendChild(spanNode);
    document.getElementById("searchMemberDropdown").innerHTML = '';
}

// 선택된 멤버 클릭시 - 선택된 멤버 삭제
function deleteNoticeMember(memberId, id){
	alert(memberId);
	document.getElementById("addedMember").removeChild(document.getElementById(id));
}

// 선택된 멤버 리스트 만들기
function selectNoticeMember(){
	var memberId = '';
	var radioGroup = document.getElementsByName("checkTarget");
	for(i=0 ; i<radioGroup.length ; i++){
		if(radioGroup[i].checked){
			target = radioGroup[i].value;
		}
	}
	var addedMembers = document.getElementsByClassName("SpanAddedMember");
	
	if(target=='allMember'){
		memberId = 'allMember';
	} else {
		for(i=0 ; i<addedMembers.length ; i++){
			if(i==addedMembers.length-1){
				memberId += addedMembers[i].textContent;
			} else {
				memberId += addedMembers[i].textContent+',';
			}
		}
	}
	return memberId;
}

// 공지 전송 - allMember/selectMember
function sendNotice(){
	var noticeContent = document.getElementById("noticeContent").value;
	var memberId = selectNoticeMember();
	var radioMemberBtn = document.getElementsByName("checkTarget").value;
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			if (resData=='true'){
				alert("성공");
				closeNoticeModal();
			} else {
				alert("실패");
				closeNoticeModal();
			}
			
		}
	}
	xhttp.open("POST", contextPath+"/admin/sendNotice.do?noticeContent="+noticeContent+"&noticeType=3&memberId="+memberId, true);
	xhttp.send();
}

// 공지 modal 닫음 - 모든 값 초기화
function closeNoticeModal(){
	document.getElementById('noticeModal').style.display='none';
	document.getElementById("noticeContent").value = '';
	document.getElementById("radioAllMember").checked = false;
	document.getElementById("radioSelectMember").checked = false;
	document.getElementById("searchMemberInput").style.display='none';
	document.getElementById("addedMember").innerHTML = '';
	document.getElementById("searchMemberInputText").value='';
}