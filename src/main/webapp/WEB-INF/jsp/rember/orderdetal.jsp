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
    alert("订单号"+orderNo+"支付成功，将为您跳转首页");
    window.location = "../index.html";
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
       		<div class="nav">你好，<a href="password.html" class="bule">${sessionScope.member.showName }</a> <a href="javascript:void(0)" onclick="logout()">[退出]</a> │ <label id="lastLogin">上次登录时间 :${sessionScope.member.lastLogin  }</label></div>
   		<div class="personal">
            	<div class="sidebar">
                	<h1>我的帐户</h1>
                	<ul>
                		<li ><a href="improve.html" >完善资料</a></li>
                		<li ><a href="binding.html">绑定微信</a></li>
                		<li ><a href="password.html">修改密码</a></li>
                		<li class="on"><a href="orderlist.html" class="bule">我的订单</a></li>
                    	<li ><a href="score.html" >我的积分</a></li>
                        <li><a href="coupon.html">我的优惠劵</a></li>
               		</ul>
                </div>
                <div class="list">
                	<div class="detail">
                    	<ul>
                          <li>订单号：${orderDto.orderNo }</li>
                          <li>交易状态：<span class="red">${orderDto.orderFlagDes }</span><c:if test="${orderDto.orderFlagDes=='未付款' }">
														<button type="button" onclick="continuePay('${orderDto.orderNo }')">付款</button>
												</c:if></li>
                          <li>订单价格：￥${orderDto.orderAmount }</li>
                          <li>下单时间：${orderDto.createDate }</li>
                          <li>配送方式：${orderDto.sendTypeDes }</li>
                          <li>电话：${orderDto.mobile }</li>
                          <c:if test="${orderDto.sendType==0 }">
                          		<li>收货地址：${orderDto.address }</li>
                          		<li>收货人：${orderDto.consignee }</li>
                          	</c:if>
                        </ul>
                        <ul class="clear"></ul>
                    </div>
                
                   	
                   	<c:forEach items="${orderDto.orderGoodsDtos}" var="v">
                   		<div class="order-info">
	                    	<h1>${v.goodsName}</h1>
	                        <label>演出时间：</label><div class="info">${v.perDate}</div>
	                        <label>演出场馆：</label><div class="info">${v.stadiumName}</div>
	                        
	                        <c:if test="${v.seatInfo!=null&&v.seatInfo!=''}">
	                        	<label>座位信息：</label><div class="info">${v.seatInfo}</div>
	                        </c:if>
	                        <label>票数：</label><div class="info">${v.goodsCount}张</div>
	                        <label>价格：</label><div class="info">${v.goodsPrice}</div>
	                        <div class="clear"></div>
                   		</div>
                   	
                   	</c:forEach>
                    
                    <!-- 
                    <div class="order-info">
                    	<h1>物流详情</h1>
                        <p>2014-12-01 16:00南京站已揽件</p>
                        <p>2014-12-01 20:00正发往常州站</p>
                    </div>
                     -->
                </div>
                <div class="clear"></div>
            </div>
      </div>
    </div>
    
    <div style="height:100px"></div>
    
    <div class="sub_footer"><div class="centre">Copyright © 2010-2015 江苏鼎昌科技有限公司 dingchang.co 保留一切权利</div></div>
    
</div>
</body>
</html>

