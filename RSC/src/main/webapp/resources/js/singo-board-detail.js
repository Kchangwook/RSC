//<!-- 게시글 상세보기(모달) -->
function searchBoard(boardNum , replyNum) {
	console.log(boardNum+"/"+ replyNum);
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
			document.getElementById("boardFileImg").src = address+"/"+resData.board.boardFile;
			
			if(resData.board.boardFile !=" ") {
			document.getElementById("br").innerHTML = '<br><br>';
			} 
			
			replyList(resData.reply, replyNum);
		}
	}
	
	xhttp.open("POST", address+"/board/searchBoard.do", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("boardNum="+boardNum); 
	
}

//<!-- 신고 댓글 가져오기 -->
function replyList(resData, replyNum) {

	var address = document.getElementById("address").value;
	var replyListHTML = '';
	var replySingoFlagHTML = '';
	

		for(i=0; i < resData.length; i++ ) {
			if(resData[i].replyNum == replyNum) {
				replySingoFlagHTML = '<div class="content1" style="float: left; width: 35%;">' +
										 '<span style="color:red;font-weight:700;padding:5px;">'+ resData[i].replyContent +'</span>'+
									 '</div>';
				
				var time = new Date(resData[i].replyTime).getFullYear() + '년 '
				+ (new Date(resData[i].replyTime).getMonth() + 1) + '월 '
				+ new Date(resData[i].replyTime).getDate() + '일 '
				+ new Date(resData[i].replyTime).getHours() + '시 '
				+ new Date(resData[i].replyTime).getMinutes() + '분';
				replyListHTML +=
					'<div class="row replyView"> ' +
						'<div class="col-md-12"> ' +
							'<div class="w3-round-large padding col-md-12">' +
								'<div class="header1" ' +
									'style="float: left; width: 25%;"> ' +
									'<span><img src="'+address+'/'+ resData[i].memberImg +'"></span> ' +
											'<span>&nbsp;&nbsp;'+resData[i].memberNick +'</span>'+
								'</div>'+
								replySingoFlagHTML +
								'<div class="clear"></div>'+
								'<div class="footer" align="right">'+
									'<div class="time-tag">'+
										'<span style="margin-right:3%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;'+ time +'</span>'+
									'</div>'+
								'</div>'+
							'</div>'+
						'</div>'+
					'<br>'+
				'</div>';
			} 
		}
	
	document.getElementById("replyHTML").innerHTML = replyListHTML;
}