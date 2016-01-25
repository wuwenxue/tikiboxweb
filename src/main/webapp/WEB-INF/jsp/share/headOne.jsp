<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 
 
 <div class="centre">
            <div class="logo" ><a href="index.html"><img src="images/logo.png" width="236" height="45" /></a></div>
            <div class="h_right"><img src="images/tel.png" width="240" height="45" />
            <c:if test='${sessionScope.member != null}' >
            <p>你好，<a href="orderlist.html" class="bule">${sessionScope.member.showName}</a> <a href="javascript:void(0)" onclick="logout()">[退出]</a> │ <a href="orderlist.html" >我的订单</a> │ <a href="score.html" >积分</a>(<u>0</u>) │ <a href="coupon.html" >我的优惠券</a></p>
            </c:if>
            <c:if test='${sessionScope.member == null}'>
             <p ><a href="login.html" class="bule">登录</a> │ <a href="register.html">注册</a></p>
           </c:if>
            
            </div>
 </div>
 <script type="text/javascript">
 function logout(){
	 $.post('logout.html',function(r){
		 location.href="index.html";
	 });
 }
 
 </script>