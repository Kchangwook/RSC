//게시글 수정하기
function modifyContent() {
	
	document.getElementById("modFrm").submit();

}

//이미지 선택하기
function changeBoardSrc() {

	document.getElementById("boardSrc").value = document.getElementById("boardFile").value;
	
}

//<!-- 게시글 상세보기(모달) -->
function modifyBoard(boardNum) {
	var address = document.getElementById("address").value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			
			var time = new Date(resData.board.boardTime).getFullYear() + '년 '
							+ (new Date(resData.board.boardTime).getMonth() + 1) + '월 '
							+ new Date(resData.board.boardTime).getDate() + '일 '
							+ new Date(resData.board.boardTime).getHours() + '시 '
							+ new Date(resData.board.boardTime).getMinutes() + '분';
			
			document.getElementById("modifyNum").value = resData.board.boardNum;
			document.getElementById("modifyNick").innerText = resData.board.memberNick;
			document.getElementById("modifyContent").innerText = resData.board.boardContent;
			document.getElementById("modifyTime").innerText = time;
			document.getElementById("modifyCnt").innerText = "조회수 : "
					+ resData.board.boardCnt;
			document.getElementById("modifyImg").src = address+"/"+resData.board.memberImg;
			document.getElementById("modifyNum").value = resData.board.boardNum;

		}
	}

	xhttp.open("POST", address + "/board/searchBoard.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum);

}

//게시글 더 불러오기
function moreBoard(cnt) {
	
	var address = document.getElementById("address").value;
	var memberId = document.getElementById("memberId").value;
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			
			for(i=0; i < resData.length; i++) {
				append(resData[i]);
			}
		}
	}

	xhttp.open("POST", address + "/board/readMoreBoard.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("memberId="+memberId +"&cnt="+cnt);

	
}

// 게시글 더 보기 append
function append(resData) {
	console.log(resData);
	var moreView = document.getElementById("moreView");
	var address = document.getElementById("address").value;
	
	var time = new Date(resData.boardTime).getFullYear() + '년 '
					+ (new Date(resData.boardTime).getMonth() + 1) + '월 '
					+ new Date(resData.boardTime).getDate() + '일 '
					+ new Date(resData.boardTime).getHours() + '시 '
					+ new Date(resData.boardTime).getMinutes() + '분';
	
	var div1 = document.createElement("div");
	div1.className = "row boardView";
	
	var div2 = document.createElement("div");
	div2.className = "col-md-12";
	
	var div3 = document.createElement("div");
	div3.className = "card w3-round-large";
	
	var div4 = document.createElement("div");
	div4.className = "header";
	
	var span1 = document.createElement("span");
	span1.className = "imgSpan"
		
	var img1 = document.createElement("img");
	img1.className = "imgTag";
	img1.setAttribute("src", address+"/"+resData.memberImg);
	img1.setAttribute("style","width:50px; height:50px;");
	
	var span2 = document.createElement("span");
	span2.innerHTML = resData.memberNick;
	
	span1.appendChild(img1);
	
	div4.appendChild(span1);
	
	div4.appendChild(span2);

	console.log(resData.boardFile==" ");
	
	var div5 = document.createElement("div");
	div5.className = "content";
	
	var span3 = document.createElement("span");
	
	var a1 = document.createElement("a");
	a1.setAttribute("href","");
	a1.setAttribute("style","display: block; font-size:14px;");
	a1.setAttribute("data-toggle","modal");
	a1.setAttribute("data-target","#detailView");
	a1.setAttribute("onclick","searchBoard("+resData.boardNum+")");
	
	var img2 = document.createElement("img");
	img2.setAttribute("style","max-width:100%;");
	img2.setAttribute("src", address+"/"+resData.boardFile);
	
	var br1 = document.createElement("br");
	var br2 = document.createElement("br");
	
	var text = document.createTextNode(resData.boardContent);
	
	if(resData.boardSingoFlag == 0) {
		div5.appendChild(span3);
		span3.appendChild(a1);
		a1.appendChild(text);
		
		if(resData.boardFile !=" ") {
			a1.appendChild(img2);
			a1.appendChild(br1);
			a1.appendChild(br2);
			a1.appendChild(text);
			} 
			
			
		} else if(resData.boardSingoFlag == 1) {
		var span4 = document.createElement("span");
		span4.textContent = "본 게시물은 신고가 되었습니다"
			
		div5.appendChild(span4);
	}
	
		
	var hr1 = document.createElement("hr");
		
	
	var div7 = document.createElement("div");
	div7.className = "footer";
	
	var i1 = document.createElement("i");
	i1.className = "fa fa-clock-o"
		
	var div8 = document.createElement("div");
	div8.className = "time-tag";
	div8.appendChild(i1);
	i1.textContent = time;
	

	div7.appendChild(div8);
	
	div8.appendChild(i1);
	
	div3.appendChild(div4);
	div3.appendChild(div5);
	div3.appendChild(hr1);
	div3.appendChild(div7);
	
	div2.appendChild(div3);
	
	div1.appendChild(div2);
	
	moreView.appendChild(div1);

}

//게시글 삭제하기
function deleteBoard(boardNum) {
	var address = document.getElementById("address").value;
	var xhttp = new XMLHttpRequest();

	if (confirm("삭제하시겠습니까?")) {

		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				alert(resData);
				window.location.reload();

			}
		}

		xhttp.open("POST", address + "/board/deleteBoard.do", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xhttp.send("boardNum=" + boardNum);
	}
}

function searchBoard(boardNum) {
	var address = document.getElementById("address").value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			
			var time = new Date(resData.board.boardTime).getFullYear() + '년 '
							+ (new Date(resData.board.boardTime).getMonth() + 1) + '월 '
							+ new Date(resData.board.boardTime).getDate() + '일 '
							+ new Date(resData.board.boardTime).getHours() + '시 '
							+ new Date(resData.board.boardTime).getMinutes() + '분';
				
			document.getElementById("profImg").src = address+"/"+resData.board.memberImg;
			document.getElementById("memberNick").innerText = resData.board.memberNick;
			document.getElementById("boardContent").innerText = resData.board.boardContent;
			document.getElementById("boardTime").innerText = time;
			document.getElementById("boardCnt").innerText = "조회수 : " + resData.board.boardCnt;
			document.getElementById("boardLike").innerText = resData.board.boardLike;
			document.getElementById("boardNum").value = resData.board.boardNum;
			document.getElementById("boardFileImg").src = address+"/"+resData.board.boardFile;
			
			if(resData.board.boardFile != 'resources/img/board') {
			document.getElementById("br").innerHTML = '<br><br>';
			} 
			
			replyList(resData.reply);
			like();
			moreReplyView(cnt);
			
								
			/* document.getElementById("memberNick").innerText = resData.memberNick;
			document.getElementById("boardContent").innerText = resData.boardContent;
			document.getElementById("boardTime").innerText = new Date(resData.boardTime).toUTCString();
			document.getElementById("boardCnt").innerText = "조회수 : " + resData.boardCnt;
			document.getElementById("boardNum").value = resData.boardNum;
			document.getElementById("memberId").value = resData.memberId;
			addReply(); */
			
		}
	}
	
	xhttp.open("POST", address+"/board/searchBoard.do", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum); 
	
}

//<!-- 댓글 입력하기 -->
function addReply(){
	var address = document.getElementById("address").value;
	var memberId = document.getElementById("memberId").value;
	var replyContent = document.getElementById("replyContent").value;
	var boardNum = document.getElementById("boardNum").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			console.log(resData);
			replyList(resData);
			
			document.getElementById("replyContent").value = "";
		}
	}
	
	xhttp.open("POST", address+"/reply/addReply.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum +"&memberId="+memberId+"&replyContent="+replyContent); 
	
}

//<!-- 댓글 리스트 가져오기 -->
function replyList(resData) {

	var address = document.getElementById("address").value;
	var replyListHTML = '';
	var replySingoFlagHTML = '';
	
	if(resData.length == 0) {
		replyListHTML = 
		'<div class="content padding1">댓글을 등록해 주세요</div>' +
		'<div align="right"></div>';
	} else {
		for(i=0; i < resData.length; i++ ) {
			if(resData[i].replySingoFlag == 0) {
				replySingoFlagHTML = '<div class="singoBtn" style="float: right; width: 20%;">'+
										'<i class="fa fa-exclamation-triangle" style="float: right; color:orange;" href="" '+
										'onclick="replyNumber(\''+resData[i].replyNum+'\')"> </i>'+
									 '</div>'+
									 '<div class="content1" style="float: right; width: 35%;">' +
										 '<span>'+ resData[i].replyContent +'</span>'+
									'</div>';
			} else {
				replySingoFlagHTML = '<div class="content1" style="float: right; width: 55%;">'+
										'<span >'+ '본 댓글은 신고가 되었습니다' +'</span>'+
									 '</div>';
				
			}
			var time = new Date(resData[i].replyTime).getFullYear() + '년 '
							+ (new Date(resData[i].replyTime).getMonth() + 1) + '월 '
							+ new Date(resData[i].replyTime).getDate() + '일 '
							+ new Date(resData[i].replyTime).getHours() + '시 '
							+ new Date(resData[i].replyTime).getMinutes() + '분';
			replyListHTML +=
				'<div class="row replyView"> ' +
					'<div class="col-md-12"> ' +
						'<div class="w3-round-large padding col-md-12">' +
//								<!-- 글 머리 : 사진, 닉네임 -->
							'<div class="header1" ' +
								'style="float: left; width: 25%;"> ' +
								'<span><img src="'+address+'/'+ resData[i].memberImg +'"></span> ' +
										'<span>&nbsp;&nbsp;'+resData[i].memberNick +'</span>'+
							'</div>'+
							
//								<!-- 댓글 내용 -->
							replySingoFlagHTML +
							
							'<div class="clear"></div>'+
							
//								<!-- 글 작성 시간 -->
							'<div class="footer" align="right">'+
								'<div class="time-tag">'+
									'<span style="margin-right:3%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;'+ time +'</span>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</div>'+
				'<br>'+
//					<!--/글 작성 틀-->
			'</div>'
		}
		
	}
	
	document.getElementById("replyHTML").innerHTML = replyListHTML;
}

//	<!-- 게시글 신고하기 -->
function boardSingo() {
	var address = document.getElementById("address").value;
    var boardSingoReason = prompt("게시글 신고 이유");
    var boardNum = document.getElementById("boardNum").value;
	    if (boardSingoReason=="") {
	    	alert("신고 이유를 입력해 주세요");
	    	boardSingo();
    	} else if (boardSingoReason==null) {
    		return false;
    	}  else {
    		location.href= address+"/singo/addBoardSingo.do?boardNum="+boardNum+"&boardSingoReason="+boardSingoReason;
    	}
}

//	<!-- 댓글 신고하기 -->
function replySingo(){
	var address = document.getElementById("address").value;
	var replyNum = document.getElementById("replyNum").value;
	var replySingoReason = prompt("댓글 신고 이유");
	
	document.getElementById("replySingoReason").value = "";
	
	if (replySingoReason=="") {
    	alert("신고 이유를 입력해 주세요");
    	replySingo();
	} else if (replySingoReason==null) {
		return false;
	}  else {
		location.href= address+"/singo/addReplySingo.do?replyNum="+replyNum+"&replySingoReason="+replySingoReason;
	}
	
}

//<!-- 좋아요 목록 ->
function like() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value; 
	var memberId = document.getElementById("memberId").value;
	var likeHTML = '';
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			console.log(resData);
			
			if(resData == true) {
				likeHTML = '<i class="fa fa-heart fa-2x" style="float: right; color:orange;"'+
									'onclick="addLike()"> </i>';
			} else {
				likeHTML = '<i class="fa fa-heart-o fa-2x" style="float: right; color:orange;"'+
									'onclick="addLike()"> </i>';
			}
		}
		document.getElementById("like").innerHTML = likeHTML;
	}
	
	xhttp.open("POST", address+"/like/like.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum+"&memberId="+memberId); 
}


//<!-- 좋아요 등록 -->
function addLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value; 
	var memberId = document.getElementById("memberId").value;
	var likeHTML = '';
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			console.log(resData);
			
			if(resData != true) {
				plusLike();
				likeHTML = '<i class="fa fa-heart fa-2x" style="float: right; color:orange;"'+
									'onclick="addLike()"> </i>';
			} else {
				minusLike();
				likeHTML = '<i class="fa fa-heart-o fa-2x" style="float: right; color:orange;"'+
									'onclick="addLike()"> </i>';
			}
		}
		document.getElementById("like").innerHTML = likeHTML;
	}
	
	xhttp.open("POST", address+"/like/addLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum+"&memberId="+memberId); 
}

//	<!-- 좋아요 삭제 -->
function delLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value; 
	var memberId = document.getElementById("memberId").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			console.log(resData);
				minusLike();
		}
	}
	
	xhttp.open("POST", address+"/like/delLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum+"&memberId="+memberId); 
}



//	<!-- 좋아요 -->
function plusLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value; 
	var memberId = document.getElementById("memberId").value;
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			console.log(resData);
			
			document.getElementById("boardLike").innerText = resData.boardLike;
			
		}
	}
	
	xhttp.open("POST", address+"/like/plusLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum+"&memberId="+memberId); 
}

//	<!-- 좋아요 취소 -->
function minusLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value; 
	var memberId = document.getElementById("memberId").value;
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData=JSON.parse(resData);
			
			document.getElementById("boardLike").innerText = resData.boardLike;
			
		}
	}
	
	xhttp.open("POST", address+"/like/minusLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum+"&memberId="+memberId); 
}

//	<!-- 댓글 신고하기 클릭시 댓글 번호 넘겨주기 -->
function replyNumber(replyNum){
	document.getElementById("replyNum").value = replyNum;
	replySingo();
}

//	<!-- 게시글 & 댓글 더보기 버튼 사용시 onload -->
window.onload = function(){
	window.cnt = 3;
	moreReplyView(cnt);
	/* 더보기 버튼 클릭 이벤트 누를때마다 window.cnt +=3 */
}

//<!-- 댓글 더 보기 -->
function moreReplyView(cnt){
	
	var replyView = document.getElementsByClassName("replyView");
	cnt = cnt >= replyView.length ? replyView.length : cnt;	
	
	for (var i = 0; i < replyView.length; i++) {
		replyView[i].style.display = 'none';
	}
	
	for (var i = 0; i < cnt; i++) {
		replyView[i].style.display = '';
	}
	
}