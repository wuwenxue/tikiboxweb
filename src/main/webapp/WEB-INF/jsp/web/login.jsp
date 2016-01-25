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
<%
try{ 
Cookie[] cookies=request.getCookies(); 
if(cookies!=null){ 
for(int i=0;i<cookies.length;i++){ 
if(cookies[i].getName().equals("name")){  
request.setAttribute("name",cookies[i].getValue()); }
if(cookies[i].getName().equals("key")){  
request.setAttribute("key",cookies[i].getValue()); 
} 
}
}
}catch(Exception e){ 
e.printStackTrace(); 
} 
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

//两个参数，一个是cookie的名称，一个是值
function SetCookie(name,value)
{
    var Days = 30; //此 cookie 将被保存 30 天
    var exp  = new Date();    //new Date("December 31, 9998");
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
 
//读取cookies函数
function getCookie(name)
{
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    if(arr != null) return unescape(arr[2]); return null;
}
 
//删除cookie
function delCookie(name)
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null) document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}

var serialid = "";
var si = "";
var count = 0;
function qrlogin(){
	if(count>=60){
		alert("二维码已过期，点击确定重新获取");
		clearInterval(si);
		count=0;
		loginweixin();
	}
	if(serialid!=""){
		$.post('qrLogin.html',{serial:serialid},function(data){
			count++;
			var result = eval("("+data+")");
			if(result.status==0){
				alert("登录成功");
				clearInterval(si);
				<c:if test="${returl!=null&&returl!=''}">location.href="${returl}";</c:if>
				 
				 <c:if test="${returl==null||returl==''}">location.href="index.html";</c:if>
			}
		});
	}
	
}


function loginweixin(){
	$("#wx").removeClass();
	$("#sj").addClass("bule");
	$("#foot").hide();
	$.post('getTempQr.html',function(data){
		var result = eval("("+data+")");
		if(result.status==0){
			serialid = result.ret.serial;
			 $("#tempqr").attr("src",result.ret.qrUrl); 
		}
	});
	$("#loginforphone").hide();
	$("#loginforweixin").show();
	si = setInterval("qrlogin()",2000);  
	
}

function loginphone(){
	$("#wx").addClass("bule");
	$("#sj").removeClass();
	$("#foot").show();
	clearInterval(si);
	$("#loginforphone").show();
	$("#loginforweixin").hide();
}

function loginDo(){
	var phone=$("#phone").val();
	var passWord=$("#passWord").val();
	 var _d=/^1[3458]\d{9}$/; 
	 if(_d.test(phone)){
		 $.post('loginDo.html',{phone:phone,passWord:passWord},function(data){
			if(data=="0"){
				/*  alert("登录成功！"); */
				if(document.getElementById("save").checked){
					SetCookie("name",phone);
					SetCookie("key",passWord);
				}else{
					delCookie("name");
					delCookie("key");
				}
				 <c:if test="${returl!=null&&returl!=''}">location.href="${returl}";</c:if>
				 
				 <c:if test="${returl==null||returl==''}">location.href="index.html";</c:if>
				 
			 }else{
				 alert(data);
			 }
		 });
	 }else{
		 alert("请输出正确的手机号码");
		 $("#phone").focus();
	 }
}
function fogetPwd(){
	var _d=/^1[3458]\d{9}$/; 
	alert("请在输入框内输入手机号码,系统将会发送6位初始密码到您的手机上，收到密码后请您及时修改！");
	var phone=$("#phone").val();
	if(phone==""){
		return false;
	}
	if(!_d.test(phone)){
		alert("请输入正确的手机号码");
		return false;
	}
	$.post("sendpwd.html",{phone:phone},function(data){
		if(data=="-1"){
			alert("手机号码不存在！");
		}else if(data=="0"){
			alert("发送成功！");
		}else{
			alert("未知错误");
		}
	});
}

document.onkeydown=function(event){
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13){
    	loginDo();
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
       		<div class="nav"><a id="sj" href="javascript:void(0)"  onclick="loginphone()">手机登录</a> │ <a id="wx" href="javascript:void(0)" onclick="loginweixin()" class="bule">微信登录</a></div>
       		<div class="login">
            	<div class="ad"><img src="images/ad.jpg" width="575" height="330" /></div>
                <div class="login_bar">

                    <div id="loginforphone" style="display: block;">
                    	
                        <label>已验证手机</label><input id="phone" name="phone" type="text" class="form-control" style="background:url(images/ico.jpg)right 5px no-repeat" value="${name }"/>
                        <label>密码</label><input id="passWord" name="passWord" type="password" class="form-control"  style="background:url(images/ico.jpg) right -25px no-repeat"value="${key }"/>
                   
                        <label><input id="save" name="save" type="checkbox"  />记住密码&nbsp;&nbsp;<a href="javascript:void(0)" onclick="fogetPwd()" class="bule">忘记密码？</a></label>
                        <button  onclick="loginDo();" class="yellow">立即登录</button>
                        
                    </div>
                    	<p id="foot">没有帐号，<a href="register.html" class="bule">立即注册</a></p>

					<div id="loginforweixin" style="text-align:center;display: none;">
						
						<img id="tempqr" src="${result.ret.qrUrl}" width="220" height="220" />
						<div style="text-align:center;display: block;margin-top: 5px;">请扫描二维码进行登录</div>
					</div>
					
					
               	</div>
                
                
        	</div>
      </div>
    </div>
    
    <div style="height:100px"></div>
    
     <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>

<script type="text/javascript">

<c:if test="${returl!=null&&returl!=''}">alert("请先登录");</c:if>
</script>
</body>
</html>
