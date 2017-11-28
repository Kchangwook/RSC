	//친구 더 보기
	function moreFriendsView(count){
		
		var friendView = document.getElementsByClassName("friendView");
		count = count>= friendView.length? friendView.length:count;
		
		for (var i = 0; i < friendView.length; i++) {
			friendView[i].style.display = 'none';
		}
		
		for (var i = 0; i < count; i++) {
			friendView[i].style.display = '';
		}
		
	}

	//친구 목록 가져오기
	function friendList(resData){
		
		var friendHTML = '';
		var address = document.getElementById("address").value;
		
		if(resData.length == 0){
			friendHTML = '<tr><td><div class = "chatPeople">친구가 없습니다</div></td></tr>';
		}else{
			for(var i = 0;i<resData.length;i++){
				
				friendHTML += '<tr class = "friendView"><td><div class = "chatImg"><img class = "profImg" id = "profImg" src = "'+address+'/'+resData[i].memberImg+'">'
					+'</div><div class = "chatPeople">'+resData[i].memberNick+'</div>'+
					'<div class = "loginPresent"><i class="fa fa-circle loginPresent" style = "color:green" name = "loginPresent" onclick="selectPeople(this)"></i>'
					+'</div><hr></td></tr>';
					
			}
		}
		
		document.getElementById("presentLogin").innerHTML = friendHTML;
		
	}

	//채팅방 만들기
	function makeRoom(){
		
		if(confirm("이 멤버로 채팅방을 만드시겠습니까?")){
			//변수 초기화
			var people = document.getElementsByName("loginPresent");
			var roomPeople = new Array;
			var index = 0;
			
			for(var i = 0;i<people.length;i++){
				if(people[i].style.color == 'blue'){
					roomPeople[index] = people[i].parentNode.parentNode.childNodes[1].innerText;
					index++;
				}
			}
			
			//비동기 통신
 			var xhttp = new XMLHttpRequest();

			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					var resData = this.responseText;
					alert(resData);
					location.reload();
				}
			}

			xhttp.open("POST", "makeRoom.do", true);
			xhttp.setRequestHeader('Content-type','application/json; charset=utf-8');
			xhttp.send(JSON.stringify({"people": roomPeople})); 
			
		}
		
	}
	
	//채팅 맴버 선택
	function selectPeople(icon){
		
		var color = icon.style.color;
		
		if(color == 'blue'){
			icon.style.color = 'green';
		}
		else if(color == 'green'){
			icon.style.color = 'blue';
		}
		
	}	
	
	//친구 추가하기
	function moreMember(){
		var address = document.getElementById("address").value;

		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				var resData = this.responseText;
				resData = JSON.parse(resData);
				friendList(resData);
				moreFriendsView(window.count);
				
			}
		}
		
		xhttp.open("GET", address+"/member/checkLogin.do", true);
		xhttp.send(); 
		
	}
	
	window.onload = function(){
		window.count = 2;	
	}
	
	function goChat(chatNum){
		var address = document.getElementById("address").value;
		location.href = address+"/chat/chatting.do?chatNum="+chatNum;
	}