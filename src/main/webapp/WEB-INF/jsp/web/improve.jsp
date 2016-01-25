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
$(document).ready(
		function() {
			if('${sessionScope.member.phone}'!=null&&'${sessionScope.member.phone}'!=""){
				$("#wanshan").show();	
				$("#wanshan1").hide();	
			}
			
		});

function logout(){
	 $.post('logout.html',function(r){
		 location.href="index.html";
	 });
}

function improveInfo(){
	
	if($("#phonecanuse").attr("style").indexOf("inline")>=0&&$("#pwdr").attr("style").indexOf("inline")>=0&&$("#pwdright").attr("style").indexOf("inline")>=0&&$("#codes").val()!=null){
		var phone=$("#phoneone").val();
		var code=$("#codes").val();
		var pwd=$("#pwd2").val();
		$.post('improveDo.html',{"phone":phone,"code":code,"pwd":pwd},function(data){
			if(data=="-10"){
				alert("验证码输入不正确！");
				return false;
			}
			var retobj = jQuery.parseJSON(data);
			alert(retobj.desc);
			if(retobj.status==0){
				$.post('loginDo.html',{phone:phone,passWord:pwd},function(data){
					if(data=="0"){
						 <c:if test="${returl!=null&&returl!=''}">location.href="${returl}";</c:if>
						 <c:if test="${returl==null||returl==''}">location.href="index.html";</c:if>
					 }else{
						 alert(data);
					 }
				});
			}
		});
	}
	
}	

function checkPhone(phone){
	 $("#phonecanuse").hide();
	 $("#phoneinuse").hide();
	 $("#phonewrong").hide();
	 var _d=/^1[3458]\d{9}$/; 
	    if(_d.test(phone)){
	    	 $.post('checkphone.html',{phone:phone},function(data){
	    		 var retobj = jQuery.parseJSON(data);
				  if(retobj.status==0){
					  $("#phonecanuse").css("display","inline");
				  }if(retobj.status==-1){
					  $("#phoneinuse").css("display","inline");
				  }if(retobj.status==1){
					  $("#phonewrong").css("display","inline");
				  }
			  });
	 }else{
		$("#phonewrong").show();
		$("#phoneone").focus();
	 }
}

var timer;
function getcode(){
	if($("#phonecanuse").attr("style").indexOf("inline")>=0){
		$("#codeget").removeAttr("onclick");
		var phone=$("#phoneone").val();
		$.post('code.html',{phone:phone},function(r){
			if(r=="0"||r==0){
				timer=	window.setInterval(showNumber, 1000);
			}else{
				$("#codeget").text("未知错误");
				window.refresh();
			}
			
		});
		
	}else{
		$("#phoneone").focus();
	}
}


var r=60;
function showNumber(){
		if(r==-1){
			window.clearInterval(timer);
			$("#codeget").attr("onclick","getcode()");
			$("#codeget").text("获取验证码");
			r=60;
			return false;
			
		}
		$("#codeget").text("重新获取("+r+")");
		r--;
}


function checkpwd(pwd){
	var reg=/(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}$/ ;
	if(reg.test(pwd)){
		$("#pwdr").css("display","inline");
		$("#pwdcanuse").hide();
	}else{
		$("#pwdcanuse").hide();
		$("#pwdnouse").show();
	}
	checktwopwd();
}

function checktwopwd(){
	$("#pwdright").hide();
	 $("#pwdcopy").hide();
	 $("#pwdreset").hide();
	 if($("#pwd2").val()==""){
		 $("#pwdreset").show();
	 }else if($("#pwd1").val()!=$("#pwd2").val()){
		 $("#pwdcopy").show();
	}else{
		$("#pwdright").css("display","inline");
	}
}

function setin(){
	$("#pwdnouse").hide();
	$("#pwdr").hide();
	$("#pwdcanuse").show();
}

function setinn(){
	$("#pwdright").hide();
	 $("#pwdcopy").hide();
	 $("#pwdreset").show();
}

document.onkeydown=function(event){
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if(e && e.keyCode==13){
    	//
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
       		<div class="nav">你好，<a href="improve.html" class="bule">${sessionScope.member.showName  }</a> <a href="javascript:void(0)" onclick="logout()">[退出]</a> │ <label id="lastLogin">上次登录时间 :${sessionScope.member.lastLogin  }</label></div>
   		<div class="personal">
            	<div class="sidebar">
                	<h1>我的帐户</h1>
                	<ul>
                		<li class="on"><a href="improve.html" class="bule">完善资料</a></li>
                		<li ><a href="binding.html">绑定微信</a></li>
                		<li ><a href="password.html">修改密码</a></li>
                		<li ><a href="orderlist.html" >我的订单</a></li>
                    	<li><a href="score.html">我的积分</a></li>
                        <li><a href="coupon.html">我的优惠劵</a></li>
               		</ul>
                </div>
                <div class="list">
                
                	<div id="wanshan" style="margin-top:100px;margin-left:100px;display: none;">此账号资料已经完善，该服务只针对于通过微信直接登录网页版且未注册的用户</div>
                	<div id="wanshan1" style="width:80%; margin:40px auto">
                	<div style="margin-bottom:10px">
                    <label>手机号码</label>
                    <input id="phoneone"  onblur="checkPhone(this.value)" name="phone" type="text" class="form-control" style="width:240px"/>
                    <span id="phonecanuse" class=" alert-success" style="display: none;">恭喜，手机号码可用</span>
                    <span id="phoneinuse" class=" alert-warning" style="display: none;">此号码已被注册</span>
                    <span  id="phonewrong" class=" alert-warning" style="display: none;">请填写正确的手机号码</span>
                    </div>
                	
                	<div style="margin-bottom:10px">
                    <label>验证码</label>
                    <input id="codes" name="code" type="text"  class="form-control" style="width:115px"/>
                    <span><button id="codeget" class="gray" onclick="getcode();">获取验证码</button></span>
                	</div>
                	
                	 <div style="margin-bottom:10px">
                    <label>密码</label>
                    <input id="pwd2" onblur="checkpwd(this.value)" onfocus="setin();"  name="passWord" type="password" class="form-control"  style="width:240px"/>
               		  <span id="pwdr" class=" alert-success" style="display: none;">正确</span>
                    <span id="pwdcanuse" class=" alert-success" style="display: inline;">6-20位字母数字的组合</span>
					<span id="pwdnouse"  class=" alert-warning"  style="display: none;">密码格式不正确！</span>
					</div>
                	
                	<div style="margin-bottom:10px">
                    <label>确认密码</label>
                    <input id="pwd1" onblur="checktwopwd()"  onfocus="setinn();" name="passWord" type="password" class="form-control"  style="width:240px"/>
                    <span id="pwdright" class=" alert-success" style="display: none;">正确</span>
                    <span id="pwdcopy" class=" alert-warning" style="display: none;">两次密码输入不一致！</span>
                    <span id="pwdreset" class=" alert-success" style="display: none;">请再次输入密码</span>
                	</div>
                	
                	
                        <div style="margin-left:100px"><button onclick="improveInfo()" class="gray" style="margin:0">确认提交</button></div>
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
