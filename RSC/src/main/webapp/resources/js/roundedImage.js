// 동그란 그림 만들기 <span class="imgSpan"> / <img class="imgTag">
var span = document.getElementsByClassName("imgSpan"); // 이미지를 감싸는 div
var img = document.getElementsByClassName("imgTag"); // 이미지
var spanAspect = 1; // div의 가로세로비는 알고 있는 값이다

for( i=0 ; i < span.length ; i++ ){
	var imgAspect = img[i].height / img[i].width;
	 
	if (imgAspect <= spanAspect) {
	    // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
	    var imgWidthActual = span[i].offsetHeight / imgAspect;
	    var imgWidthToBe = span[i].offsetHeight / spanAspect;
	    var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
	    img[i].style.cssText = 'width: auto; height: 100%; margin-left: '
	                      + marginLeft + 'px;'
	} else {
	    // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
	    img[i].style.cssText = 'width: 100%; height: auto; margin-left: 0;';
	}
	
}