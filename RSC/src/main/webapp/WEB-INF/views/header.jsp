<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>

	<header class="header">
		<nav class="navbar">
			<div class="container-fluid">
				<div
					class="navbar-holder d-flex align-items-center justify-content-between">
					<div class="navbar-header">
						<a id="toggle-btn" href="#" class="menu-btn"> <i
							class="icon-bars"> </i>
						</a>
					</div>
					<ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
						<!-- 알림1 -->
						<li class="nav-item dropdown"><a id="notifications"
							rel="nofollow" data-target="#" href="#" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false" class="nav-link"><i
								class="fa fa-bell"></i><span class="badge badge-warning">12</span></a>
							<ul aria-labelledby="notifications" class="dropdown-menu">
								<li><a rel="nofollow" href="#" class="dropdown-item d-flex">
										<div class="msg-profile">
											<img src="img/avatar-1.jpg" alt="..."
												class="img-fluid rounded-circle">
										</div>
										<div class="msg-body">
											<h3 class="h5">Jason Doe</h3>
											<span>sent you a direct message</span><small>3 days
												ago at 7:58 pm - 10.06.2014</small>
										</div>
								</a></li>
								<li><a rel="nofollow" href="#" class="dropdown-item d-flex">
										<div class="msg-profile">
											<img src="img/avatar-2.jpg" alt="..."
												class="img-fluid rounded-circle">
										</div>
										<div class="msg-body">
											<h3 class="h5">Frank Williams</h3>
											<span>sent you a direct message</span><small>3 days
												ago at 7:58 pm - 10.06.2014</small>
										</div>
								</a></li>
								<li><a rel="nofollow" href="#" class="dropdown-item d-flex">
										<div class="msg-profile">
											<img src="img/avatar-3.jpg" alt="..."
												class="img-fluid rounded-circle">
										</div>
										<div class="msg-body">
											<h3 class="h5">Ashley Wood</h3>
											<span>sent you a direct message</span><small>3 days
												ago at 7:58 pm - 10.06.2014</small>
										</div>
								</a></li>
								<li><a rel="nofollow" href="#"
									class="dropdown-item all-notifications text-center"> <strong>
											<i class="fa fa-envelope"></i>Read all messages
									</strong></a></li>
							</ul>
						</li>
						
						<!-- 회원가입  -->
						<li class="nav-item"><a href="login.html"
							class="nav-link logout">회원가입</a>
						</li>
						
						<!-- 로그인 -->
						<li class="nav-item"><a href="login.html"
							class="nav-link logout">로그인</a>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</header>

</body>
</html>