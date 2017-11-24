var orderArr = [ "Num", "Time", "Like", "Count" ];
var orderColumn = "board_time";
var orderType = "desc";
var boardIdContent = "";

// 댓글 삭제
function replyDelete(replyNum,reply) {
	var address = document.getElementById("address").value;
	var replys = reply.parentNode.parentNode.parentNode;
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				alert(resData);
				if(resData == "삭제에 성공했습니다."){
					replys.parentNode.removeChild(replys);
				}
					
			}
		}
		xhttp.open("POST", address + "/reply/deleteReply.do", true);
		xhttp.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		xhttp.send("replyNum="+replyNum);
	}
}

function searchBoardList() {
	boardIdContent = document.getElementById("boardSearchInput").value;
	if (boardIdContent == '') {
		alert("검색어를 입력해주세요");
	} else {
		getNewBoardList();
	}
}

function orderBoardList(className) {

	switch (className) {
	case 'tdNum':
		setOrder(orderArr[0]);
		orderColumn = "board_num";
		break;
	case 'tdTime':
		setOrder(orderArr[1]);
		orderColumn = "board_time";
		break;
	case 'tdLike':
		setOrder(orderArr[2]);
		orderColumn = "board_like";
		break;
	case 'tdCount':
		setOrder(orderArr[3]);
		orderColumn = "board_cnt"
		break;
	}
	getNewBoardList();
}

function setOrder(column) {
	if (document.getElementById("hidden" + column).value == "desc") {
		orderAsc(column);
		orderType = "asc";
	} else if (document.getElementById("hidden" + column).value == "asc") {
		orderDesc(column);
		orderType = "desc";
	} else {
		orderDesc(column);
		orderType = "desc";
	}
}

function orderDesc(column) {
	for (i = 0; i < orderArr.length; i++) {
		if (orderArr[i] == column) {
			document.getElementById("icon" + orderArr[i]).className = "fa fa-arrow-down";
			document.getElementById("hidden" + orderArr[i]).value = "desc";
		} else {
			document.getElementById("icon" + orderArr[i]).className = "fa fa-arrows-v";
			document.getElementById("hidden" + orderArr[i]).value = "none";
		}
	}
}

function orderAsc(column) {
	for (i = 0; i < orderArr.length; i++) {
		if (orderArr[i] == column) {
			document.getElementById("icon" + orderArr[i]).className = "fa fa-arrow-up";
			document.getElementById("hidden" + orderArr[i]).value = "asc";
		} else {
			document.getElementById("icon" + orderArr[i]).className = "fa fa-arrows-v";
			document.getElementById("hidden" + orderArr[i]).value = "none";
		}
	}
}

function getNewBoardList() {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			printNewBoardList(resData);
		}
	}
	xhttp.open("POST", "boardOrder.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("orderColumn=" + orderColumn + "&orderType=" + orderType
			+ "&boardIdContent=" + boardIdContent);
}

function printNewBoardList(resData) {
	var newBoardHTML = "";
	for (i = 0; i < resData.length; i++) {
		newBoardHTML += '<tr>' + '<td>'
				+ (resData[i].groupNum == "0" ? "개인" : "그룹") + '</td>' + '<td>'
				+ resData[i].boardNum + '</td>' + '<td>' + resData[i].memberId
				+ '</td>' + '<td>' +'<span><a href="#" style="display: block;"data-toggle="modal"' +
				'data-target="#detailView"onclick="searchBoard('+resData[i].boardNum+')">'
				+ resData[i].boardContent + '</a></span></td>' + '<td>'
				+ new Date(resData[i].boardTime).getFullYear() + '년 '
				+ (new Date(resData[i].boardTime).getMonth() + 1) + '월 '
				+ new Date(resData[i].boardTime).getDate() + '일 '
				+ new Date(resData[i].boardTime).getHours() + '시 '
				+ new Date(resData[i].boardTime).getMinutes() + '분' + '</td>'
				+ '<td>' + (resData[i].boardSingoFlag == "0" ? "" : "O")
				+ '</td>' + '<td>' + resData[i].boardLike + '</td>' + '<td>'
				+ resData[i].boardCnt + '</td>' + '</tr>';
	}
	document.getElementById("boardBody").innerHTML = newBoardHTML;
}
// 게시글 수정하기
function modifyContent() {

	document.getElementById("modFrm").submit();

}

// <!-- 게시글 상세보기(모달) -->
function modifyBoard(boardNum) {
	var address = document.getElementById("address").value;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);

			document.getElementById("modifyNum").value = resData.board.boardNum;
			document.getElementById("modifyNick").innerText = resData.board.memberNick;
			document.getElementById("modifyContent").innerText = resData.board.boardContent;
			document.getElementById("modifyTime").innerText = new Date(
					resData.board.boardTime).toUTCString();
			document.getElementById("modifyCnt").innerText = "조회수 : "
					+ resData.board.boardCnt;
			document.getElementById("modifyImg").src = address + "/"
					+ resData.board.memberImg;
			document.getElementById("modifyNum").value = resData.board.boardNum;

		}
	}

	xhttp.open("POST", address + "/board/searchBoard.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum);

}

// 게시글 삭제하기
function deleteBoard() {
	var boardNum = document.getElementById("boardNum").value;
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
			resData = JSON.parse(resData);

			document.getElementById("profImg").src = address + "/"
					+ resData.board.memberImg;
			document.getElementById("memberNick").innerText = resData.board.memberNick;
			document.getElementById("boardContent").innerText = resData.board.boardContent;
			document.getElementById("boardTime").innerText = new Date(
					resData.board.boardTime).toUTCString();
			document.getElementById("boardCnt").innerText = "조회수 : "
					+ resData.board.boardCnt;
			document.getElementById("boardLike").innerText = resData.board.boardLike;
			document.getElementById("boardNum").value = resData.board.boardNum;
			document.getElementById("memberId").value = resData.board.memberId;
			replyList(resData.reply);
			moreReplyView(cnt);

			/*
			 * document.getElementById("memberNick").innerText =
			 * resData.memberNick;
			 * document.getElementById("boardContent").innerText =
			 * resData.boardContent;
			 * document.getElementById("boardTime").innerText = new
			 * Date(resData.boardTime).toUTCString();
			 * document.getElementById("boardCnt").innerText = "조회수 : " +
			 * resData.boardCnt; document.getElementById("boardNum").value =
			 * resData.boardNum; document.getElementById("memberId").value =
			 * resData.memberId; addReply();
			 */

		}
	}

	xhttp.open("POST", address + "/board/searchBoard.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum);

}

// <!-- 댓글 입력하기 -->
function addReply() {
	var address = document.getElementById("address").value;
	var memberId = document.getElementById("memberId").value;
	var replyContent = document.getElementById("replyContent").value;
	var boardNum = document.getElementById("boardNum").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			console.log(resData);
			replyList(resData);

			document.getElementById("replyContent").value = "";
		}
	}

	xhttp.open("POST", address + "/reply/addReply.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum + "&memberId=" + memberId
			+ "&replyContent=" + replyContent);

}

// <!-- 댓글 리스트 가져오기 -->
function replyList(resData) {

	var address = document.getElementById("address").value;
	var replyListHTML = '';
	var replySingoFlagHTML = '';

	if (resData.length == 0) {
		replyListHTML = '<div class="content padding1">댓글을 등록해 주세요</div>'
				+ '<div align="right"></div>';
	} else {
		for (i = 0; i < resData.length; i++) {
			if (resData[i].replySingoFlag == 0) {
				replySingoFlagHTML = '<div class="singoBtn" style="float: right; width: 20%;">'
						+ '<a class="btn btn-default btnOrange" style="float: right; href="" data-toggle="modal"'
						+ 'data-target="#replySingo" onclick="replyDelete(\''
						+ resData[i].replyNum
						+ '\',this)"> 삭제하기 </a>'
						+ '</div>'
						+ '<div class="content1" style="float: right; width: 35%;">'
						+ '<span>'
						+ resData[i].replyContent
						+ '</span>'
						+ '</div>' +

						'</div>';
			} else {
				replySingoFlagHTML = '<div class="content1" style="float: right; width: 55%;">'
						+ '<span >' + '본 댓글은 신고가 되었습니다' + '</span>' + '</div>';

			}
			replyListHTML += '<div class="row replyView"> '
					+ '<div class="col-md-12"> '
					+ '<div class="w3-round-large padding col-md-12">' +
					// <!-- 글 머리 : 사진, 닉네임 -->
					'<div class="header1" '
					+ 'style="float: left; width: 25%;"> ' + '<span><img '
					+ 'src="' + address
					+ '/resources/img/profile.jpg"></span> '
					+ '<span>&nbsp;&nbsp;' + resData[i].memberNick + '</span>'
					+ '</div>' +

					// <!-- 댓글 내용 -->
					replySingoFlagHTML +

					'<div class="clear"></div>' +

					// <!-- 글 작성 시간 -->
					'<div class="footer" align="right">'
					+ '<div class="time-tag">'
					+ '<span><i class="fa fa-clock-o"></i>'
					+ new Date(resData[i].replyTime).toUTCString() + '</span>'
					+ '</div>' + '</div>' + '</div>' + '</div>' + '<br>' +
					// <!--/글 작성 틀-->
					'</div>'
		}

	}

	document.getElementById("replyHTML").innerHTML = replyListHTML;
}

// <!-- 신고하기 -->
function replySingo() {
	var address = document.getElementById("address").value;
	var replyNum = document.getElementById("replyNum").value;
	var replySingoReason = document.getElementById("replySingoReason").value;
	document.getElementById("replySingoReason").value = "";

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);

		}
	}

	xhttp.open("POST", address + "/singo/addReplySingo.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp
			.send("replyNum=" + replyNum + "&replySingoReason="
					+ replySingoReason);

}

// <!-- 좋아요 목록 ->
function like() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value;
	var memberId = document.getElementById("memberId").value;
	var likeHTML = '';

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			console.log(resData);

			if (resData == true) {
				likeHTML = '<i class="fa fa-thumbs-down btn btn-default btnOrange" style="float: right;"'
						+ 'onclick="addLike()"> </i>';
			} else {
				likeHTML = '<i class="fa fa-thumbs-up btn btn-default btnOrange" style="float: right;"'
						+ 'onclick="addLike()"> </i>';
			}
		}
		document.getElementById("like").innerHTML = likeHTML;
	}

	xhttp.open("POST", address + "/like/like.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum + "&memberId=" + memberId);
}

// <!-- 좋아요 등록 -->
function addLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value;
	var memberId = document.getElementById("memberId").value;
	var likeHTML = '';

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			console.log(resData);

			if (resData != true) {
				plusLike();
				likeHTML = '<i class="fa fa-thumbs-down btn btn-default btnOrange" style="float: right;"'
						+ 'onclick="addLike()"> </i>';
			} else {
				minusLike();
				likeHTML = '<i class="fa fa-thumbs-up btn btn-default btnOrange" style="float: right;"'
						+ 'onclick="addLike()"> </i>';
			}
		}
		document.getElementById("like").innerHTML = likeHTML;
	}

	xhttp.open("POST", address + "/like/addLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum + "&memberId=" + memberId);
}

// <!-- 좋아요 삭제 -->
function delLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value;
	var memberId = document.getElementById("memberId").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			console.log(resData);
			minusLike();
		}
	}

	xhttp.open("POST", address + "/like/delLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum + "&memberId=" + memberId);
}

// <!-- 좋아요 -->
function plusLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value;
	var memberId = document.getElementById("memberId").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);
			console.log(resData);

			document.getElementById("boardLike").innerText = resData.boardLike;

		}
	}

	xhttp.open("POST", address + "/like/plusLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum + "&memberId=" + memberId);
}

// <!-- 좋아요 취소 -->
function minusLike() {
	var address = document.getElementById("address").value;
	var boardNum = document.getElementById("boardNum").value;
	var memberId = document.getElementById("memberId").value;

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var resData = this.responseText;
			resData = JSON.parse(resData);

			document.getElementById("boardLike").innerText = resData.boardLike;

		}
	}

	xhttp.open("POST", address + "/like/minusLike.do", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum=" + boardNum + "&memberId=" + memberId);
}

// <!-- 댓글 신고하기 클릭시 댓글 번호 넘겨주기 -->
function replyNumber(replyNum) {
	document.getElementById("replyNum").value = replyNum;
	document.getElementById("replySingo").style.display = '';
}

// <!-- 게시글 & 댓글 더보기 버튼 사용시 onload -->
window.onload = function() {
	window.cnt = 3;
	moreBoardView(cnt);
	moreReplyView(cnt);
	/* 더보기 버튼 클릭 이벤트 누를때마다 window.cnt +=3 */
}

// <!-- 게시글 더 보기 -->
function moreBoardView(cnt) {

	var boardView = document.getElementsByClassName("boardView");
	cnt = cnt >= boardView.length ? boardView.length : cnt;

	for (var i = 0; i < boardView.length; i++) {
		boardView[i].style.display = 'none';
	}

	for (var i = 0; i < cnt; i++) {
		boardView[i].style.display = '';
	}

}

// <!-- 댓글 더 보기 -->
function moreReplyView(cnt) {

	var replyView = document.getElementsByClassName("replyView");
	cnt = cnt >= replyView.length ? replyView.length : cnt;

	for (var i = 0; i < replyView.length; i++) {
		replyView[i].style.display = 'none';
	}

	for (var i = 0; i < cnt; i++) {
		replyView[i].style.display = '';
	}

}
