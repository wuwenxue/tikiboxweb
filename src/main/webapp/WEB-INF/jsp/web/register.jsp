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

var timer;
	function getcode(){
		if($("#phonecanuse").attr("style").indexOf("block")>=0){
			$("#codeget").removeAttr("onclick");
			var phone=$("#phoneone").val();
			$.post('code.html',{phone:phone},function(r){
				if(r=="0"||r==0){
					flag=false;
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
	
	function register(){
		if(!document.getElementById("checkbox").checked){
			return false;
		}
		
		if($("#phonecanuse").attr("style").indexOf("block")>=0&&$("#pwdr").attr("style").indexOf("block")>=0&&$("#pwdright").attr("style").indexOf("block")>=0&&$("#codes").val()!=null){
			var phone=$("#phoneone").val();
			var code=$("#codes").val();
			var pwd=$("#pwd2").val();
			$.post('registerDo.html',{"phone":phone,"code":code,"pwd":pwd},function(data){
				if(data=="-10"){
					alert("验证码输入不正确！");
				}
				var retobj = jQuery.parseJSON(data);
				if(retobj.status==0){
					$.post('loginDo.html',{phone:phone,passWord:pwd},function(data){
						if(data=="0"){
							 <c:if test="${returl==null||returl==''}">location.href="index.html";</c:if>
						 }else{
							 alert(data);
						 }
					});
				}
			});
		}
		
	}

	function check4(){
		if(!document.getElementById("checkbox").checked){
			document.getElementById("button").style.backgroundColor="gray";
		}else{
			document.getElementById("button").style.backgroundColor="#f1651e";
		}
	}
	
	document.onkeydown=function(event){
	    var e = event || window.event || arguments.callee.caller.arguments[0];
	    if(e && e.keyCode==13){
	    	register();
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
       		<div class="nav" >已有帐号，<a href="login.html" class="bule">立即登录</a></div>
       		<div class="register">
            	<div class="form-group">
                    <label><b>*</b>手机号码： </label>
                    <input id="phoneone"  onblur="checkPhone(this.value)" name="phone" type="text" class="form-control" style="width:240px"/>
                    <div id="phonecanuse" class="alert alert-success" style="display: none;">恭喜，手机号码可用</div>
                    <div id="phoneinuse" class="alert alert-warning" style="display: none;;color:#f00">此号码已被注册</div>
                    <div  id="phonewrong" class="alert alert-info" style="display: none;color:#f00">请填写正确的手机号码</div>
                    
                </div>
                
                <div class="form-group">
                    <label><b>*</b>验证码： </label>
                    <input id="codes" name="code" type="text"  class="form-control" style="width:115px"/>
                    <div><button id="codeget" class="gray" onclick="getcode();">获取验证码</button></div>
                </div>
                
                <div class="form-group">
                    <label><b>*</b>密码： </label>
                    <input id="pwd2" onblur="checkpwd(this.value)" onfocus="setin();"  name="passWord" type="password" class="form-control"  style="width:240px"/>
               		  <div id="pwdr" class="alert alert-success" style="display: none;">正确</div>
                    <div id="pwdcanuse" class="alert alert-info" style="display: block;">6-20位字符，可使用字母、数字的组合,<br />
    不可使用纯数字，纯字母</div>
					<div id="pwdnouse"  class="alert alert-warning"  style="display: none;">密码格式不正确！</div>
				</div>
                
                <div class="form-group">
                    <label><b>*</b>确认密码： </label>
                    <input id="pwd1" onblur="checktwopwd()"  onfocus="setinn();" name="passWord" type="password" class="form-control"  style="width:240px"/>
                    <div id="pwdright" class="alert alert-success" style="display: none;">正确</div>
                    <div id="pwdcopy" class="alert alert-warning" style="display: none;">两次密码输入不一致！</div>
                    <div id="pwdreset" class="alert alert-info" style="display: none;">请再次输入密码</div>
                </div>
              
                <div class="form-group">
                	<label></label>
                    <p><input id="checkbox" type="checkbox" checked="checked"  onchange="check4()" />我已阅读并同意<a href="register_rule.html" class="bule" target="blank">《用户注册协议》</a></p>
                </div>
                
                <div class="form-group">
                	<label></label>
                    <button id="button" onclick="register();" class="yellow" style="width:240px" >注 册</button>
                </div>
            </div>
      </div>
    </div>
    
    <div style="height:100px"></div>
    
     <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>
<script type="text/javascript">
	function checkPhone(phone){
		 $("#phonecanuse").css("display","none");
		 $("#phoneinuse").css("display","none");
		 $("#phonewrong").css("display","none");
		 var _d=/^1[3458]\d{9}$/; 
		    if(_d.test(phone)){
		    	 $.post('checkphone.html',{phone:phone},function(data){
		    		 var retobj = jQuery.parseJSON(data);
					  if(retobj.status==0){
						  $("#phonecanuse").css("display","block");
					  }if(retobj.status==-1){
						  $("#phoneinuse").css("display","block");
					  }if(retobj.status==1){
						  $("#phonewrong").css("display","block");
					  }
				  });
		 }else{
			$("#phonewrong").css("display","block");
			$("#phoneone").focus();
		 }
		 
	}
	
	function checkpwd(pwd){
		var reg=/(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{6,}$/ ;
		if(reg.test(pwd)){
			$("#pwdr").css("display","block");
			$("#pwdcanuse").css("display","none");
		}else{
			$("#pwdcanuse").css("display","none");
			$("#pwdnouse").css("display","block");
		}
		checktwopwd();
	}
	
	function checktwopwd(){
		$("#pwdright").css("display","none");
		 $("#pwdcopy").css("display","none");
		 $("#pwdreset").css("display","none");
		 if($("#pwd2").val()==""){
			 $("#pwdreset").css("display","block");
		 }else if($("#pwd1").val()!=$("#pwd2").val()){
			 $("#pwdcopy").css("display","block");
		}else{
			$("#pwdright").css("display","block");
		}
	}
	
	function setin(){
		$("#pwdnouse").css("display","none");
		$("#pwdr").css("display","none");
		$("#pwdcanuse").css("display","block");
	}
	
	function setinn(){
		$("#pwdright").css("display","none");
		 $("#pwdcopy").css("display","none");
		 $("#pwdreset").css("display","block");
	}
</script>
</body>
</html>
