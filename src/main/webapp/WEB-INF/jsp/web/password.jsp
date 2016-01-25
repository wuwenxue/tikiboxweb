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

function updatepwd(){
	
	var passWord = $("#oldpwd").val();
	 $.post('loginDo.html',{phone:'${sessionScope.member.phone}',passWord:passWord},function(data){
		 if(data=="0"){
			 if($("#newpwd").val()==$("#oldpwd").val()){
				 $("#pwd11").show();
 				 $("#pwd1").hide();
 				 $("#pwd2").hide();
 				 $("#pwd3").hide();
					return false;
			 }
			 
			 var reg=/(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}$/ ;
				if(!reg.test($("#newpwd").val())){
					 $("#pwd11").hide();
					 $("#pwd1").hide();
					 $("#pwd2").show();
					 $("#pwd3").hide();
					return false;
				}else{
					if($("#newpwd").val()!=$("#newpwd2").val()){
						$("#pwd11").hide();
						 $("#pwd1").hide();
						 $("#pwd2").hide();
						 $("#pwd3").show();
						return false;
					}else{
						var pwd=$("#newpwd").val();
						$.post('updatePassword.html',{pwd:pwd,name:'${sessionScope.member.phone}'},function(data){
							if(data=="0"){
								alert("修改成功！请重新登录！");
								location.href="login.html";
							}
						});
					}
				}

		 
		 }else{
			 $("#pwd11").hide();
			 $("#pwd1").show();
			 $("#pwd2").hide();
			 $("#pwd3").hide();
		 }
	 });
	
	
}
document.onkeydown=function(event){
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13){
    	updatepwd();
    }
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
       		<div class="nav">你好，<a href="password.html" class="bule">${sessionScope.member.showName  }</a> <a href="javascript:void(0)" onclick="logout()">[退出]</a> │ <label id="lastLogin">上次登录时间 :${sessionScope.member.lastLogin  }</label></div>
   		<div class="personal">
            	<div class="sidebar">
                	<h1>我的帐户</h1>
                	<ul>
                		<li ><a href="improve.html" >完善资料</a></li>
                		<li ><a href="binding.html">绑定微信</a></li>
                		<li class="on"><a href="password.html" class="bule">修改密码</a></li>
                		<li ><a href="orderlist.html" >我的订单</a></li>
                    	<li><a href="score.html">我的积分</a></li>
                        <li><a href="coupon.html">我的优惠劵</a></li>
               		</ul>
                </div>
                <div class="list">
                	<div style="width:80%; margin:40px auto">
                		<div>
                		<div style="margin-bottom:10px"><label>原密码</label><input id="oldpwd" type="password" />
                			<span id="pwd1" class="alert-warning"  style="display: none">原密码错误，请重新输入</span>
                			<span id="pwd11" class="alert-warning"  style="display: none">新旧密码不能相同</span></div>
                        </div>
                        <div>
                        <div style="margin-bottom:10px"><label>新密码</label><input id="newpwd" type="password" />
                        	<span id="pwd2" class="alert-warning"  style="display: none">6-20位字母数字的组合</span></div>
                        </div>
                        <div>
                        <div style="margin-bottom:10px"><label>再输一遍</label><input id="newpwd2" type="password" />
                        	<span id="pwd3" class="alert-warning"  style="display: none">2次新密码输入不一致！</span></div>
                        </div>
                        <div style="margin-left:100px"><button onclick="updatepwd()" class="gray" style="margin:0">确认修改</button></div>
                    </div>
          		</div>
                
            </div>
            <div class="clear">
                </div>
      </div>
    </div>
    
    <div style="height:100px"></div>
    
   <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>
</body>
</html>
