	
// 	<!-- 게시글 상세보기(모달) -->
		function searchBoard(boardNum) {
			var address = document.getElementById("address").value;
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					console.log(resData);
					
					document.getElementById("memberNick").innerText = resData.board.memberNick;
					document.getElementById("boardContent").innerText = resData.board.boardContent;
					document.getElementById("boardTime").innerText = new Date(resData.board.boardTime).toUTCString();
					document.getElementById("boardCnt").innerText = "조회수 : " + resData.board.boardCnt;
					document.getElementById("boardLike").innerText = resData.board.boardLike;
					document.getElementById("boardNum").value = resData.board.boardNum;
					document.getElementById("memberId").value = resData.board.memberId;
					replyList(resData.reply);

					
										
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
		
//		<!-- 댓글 입력하기 -->
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
		
// 		<!-- 댓글 리스트 가져오기 -->
		function replyList(resData) {
			console.log(resData);
			
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
												'<a class="btn btn-default btnOrange" style="float: right; href="" data-toggle="modal"'+
												'data-target="#replySingo" onclick="replyNumber(\''+resData[i].replyNum+'\')"> 신고하기 </a>'+
											 '</div>'+
											 '<div class="content1" style="float: right; width: 35%;">' +
												 '<span>'+ resData[i].replyContent +'</span>'+
											 '</div>' +
											 
											'</div>';
					} else {
						replySingoFlagHTML = '<div class="content1" style="float: right; width: 55%;">'+
												'<span >'+ '본 댓글은 신고가 되었습니다' +'</span>'+
											 '</div>';
						
					}
					replyListHTML +=
						'<div class="row"> ' +
							'<div class="col-md-12"> ' +
								'<div class="w3-round-large padding col-md-12">' +
// 									<!-- 글 머리 : 사진, 닉네임 -->
									'<div class="header1" ' +
										'style="float: left; width: 25%;"> ' +
										'<span><img '+
												'src="${pageContext.request.contextPath}/resources/img/profile.jpg"></span> ' +
												'<span>&nbsp;&nbsp;'+resData[i].memberNick +'</span>'+
									'</div>'+
									
// 									<!-- 댓글 내용 -->
									replySingoFlagHTML +
									
									'<div class="clear"></div>'+
									
// 									<!-- 글 작성 시간 -->
									'<div class="footer" align="right">'+
										'<div class="time-tag">'+
											'<span><i class="fa fa-clock-o"></i>'+ new Date(resData[i].replyTime).toUTCString() +'</span>'+
										'</div>'+
									'</div>'+
								'</div>'+
							'</div>'+
						'<br>'+
// 						<!--/글 작성 틀-->
					'</div>'
				}
				
			}
			
			document.getElementById("replyHTML").innerHTML = replyListHTML;
		}
		
// 		<!-- 신고하기 -->
		function replySingo(){
			var address = document.getElementById("address").value;
			var replyNum = document.getElementById("replyNum").value;
			var replySingoReason = document.getElementById("replySingoReason").value;
			document.getElementById("replySingoReason").value = "";
			
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					
				}
			}
			
			xhttp.open("POST", address+"/singo/addReplySingo.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("replyNum="+replyNum+"&replySingoReason="+replySingoReason); 
			
		}
		
// 		<!-- 좋아요 -->
		function plusLike() {
			var address = document.getElementById("address").value;
			var boardNum = document.getElementById("boardNum").value; 
			console.log(boardNum)
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					resData=JSON.parse(resData);
					
					document.getElementById("boardLike").innerText = resData.boardLike;
					
				}
			}
			
			xhttp.open("POST", address+"/like/plusLike.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("boardNum="+boardNum); 
		}
		
// 		<!-- 좋아요 취소 -->
		function minusLike() {
			var address = document.getElementById("address").value;
			var boardNum = document.getElementById("boardNum").value; 
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
			xhttp.send("boardNum="+boardNum); 
		}
		
		function replyNumber(replyNum){
			document.getElementById("replyNum").value = replyNum;
			document.getElementById("replySingo").style.display='';
		}