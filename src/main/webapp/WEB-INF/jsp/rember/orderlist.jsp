<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	// 获得项目完全路径（假设你的项目叫MyApp，那么获得到的地址就是 http://localhost:8080/MyApp/）:    
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>盒子房</title>
<link href="images/style.css" rel="stylesheet" type="text/css" />
<%@include file="/WEB-INF/jsp/share/linkjs.jsp"%>
</head>
<script type="text/javascript">

function logout(){
	 $.post('logout.html',function(r){
		 location.href="index.html";
	 });
}

function continuePay(No) {
	window.open("payDo.html?orderNo="+No,"openwin");
}

function okfun(orderNo){  
    alert("订单号"+orderNo+"支付成功，将为您跳转订单页面");
    window.location = "../orderlist.html";
}  

function orderdetal(orderId) {
	window.location = "orderdetal.html?id="+orderId;
}

</script>

<body>
	<div class="warp">
		<div class="head">
			<%@include file="/WEB-INF/jsp/share/headTwo.jsp"%>
		</div>
		<div class="sub_bar"></div>

		<div class="centre">
			<div class="board">
				<div class="nav">
					你好，<a href="orderlist.html" class="bule">${sessionScope.member.showName }</a> <a
						href="javascript:void(0)" onclick="logout()">[退出]</a> │ <label
						id="lastLogin">上次登录时间 :${sessionScope.member.lastLogin  }</label>
				</div>
				<div class="personal">
					<div class="sidebar">
						<h1>我的帐户</h1>
						<ul>
							<li ><a href="improve.html" >完善资料</a></li>
							<li ><a href="binding.html">绑定微信</a></li>
							<li><a href="password.html">修改密码</a></li>
							<li class="on"><a href="orderlist.html" class="bule">我的订单</a></li>
							<li><a href="score.html">我的积分</a></li>
							<li><a href="coupon.html">我的优惠劵</a></li>
						</ul>
					</div>
					<div class="list">
						
						<table width="100%" border="0" cellpadding="0" cellspacing="0"
							class="table-striped">
							<thead>
								<tr>
									<th width="20%">订单号</th>
									<th width="30%">名称</th>
									<th width="17%">下单时间</th>
									<th width="13%">金额</th>
									<th width="10%">订单状态</th>
									<th width="10%">操作</th>
								</tr>
							</thead>

							<tbody>
							
								<c:forEach var="v" items="${pageView.records}">
									<tr>
										<td>${v.orderNo }</td>
										<td>${v.orderName }</td>
										<td>${v.createDate }</td>
										<td>${v.orderAmount }</td>
										<td>${v.orderFlagDes }</td>
										<td>
												<button type="button" onclick="orderdetal('${v.id }')">详细</button>
												<c:if test="${v.orderFlagDes=='未付款' }">
														<button type="button" onclick="continuePay('${v.orderNo }')">付款</button>
												</c:if>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
				<div class="clear"></div>
				<div class="clear"></div>
				<nav>
			
				
				<%@include file="/WEB-INF/jsp/share/page.jsp"%>
				</nav>
			</div>
		</div>

		<div style="height: 100px"></div>

		<%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>

	</div>
</body>
</html>
