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
			if('${sessionScope.member.wid}'!=null&&'${sessionScope.member.wid}'!=""){
				$("#weixin").show();	
				$("#weixin1").hide();	
				$("#weixin2").hide();	
			}
			
		});
		
function logout(){
	 $.post('logout.html',function(r){
		 location.href="index.html";
	 });
}
var serialid = "";
var si = "";
var count = 0;

function qrlogin(){
	if(count>=60){
		$("#weixin1").show();
		$("#weixin2").hide();	
		clearInterval(si);
		count=0;
	}
	if(serialid!=""){
		$.post('bindingCheck.html',{serial:serialid},function(data){
			count++;
			var result = eval("("+data+")");
			if(result.status==20){
				console.info(result.desc);
				clearInterval(si);
			}
			if(result.status==10){
	
				console.info(result.desc+result.ret.id);
				bindingDo(result.ret.id);
				clearInterval(si);
			}else if(result.status==11){
				//弹框确认是否绑定		
			
				console.info(result.desc+result.ret.id);
				bindingDo(result.ret.id);
				clearInterval(si);
			}
		});
	}
}
function bindingDo(id){
	$.post('bindingDo.html',{id:id},function(data){
		var result = eval("("+data+")");
		if(result.status==0){
			alert("绑定成功");
			$("#weixin").show();	
			$("#weixin1").hide();	
			$("#weixin2").hide();	
		}else{
			alert(result.desc);
		}
	});
}

	
	
function bindingweixin(){
	
	$.post('getTempQr.html',function(data){
		var result = eval("("+data+")");
		if(result.status==0){
			serialid = result.ret.serial;
			 $("#tempqr").attr("src",result.ret.qrUrl); 
		}
	});
	$("#weixin1").hide();	
	$("#weixin2").show();
	si = setInterval("qrlogin()",2000);  
}

</script>

<body>
<div class="warp">
			<div class="head">
         <%@include file="/WEB-INF/jsp/share/headTwo.jsp"%>
    		</div>    
    <div class="sub_bar"></div>
    
    <div class="centre" >
   	  <div class="board">
       		<div class="nav">你好，<a href="binding.html" class="bule">${sessionScope.member.showName  }</a> <a href="javascript:void(0)" onclick="logout()">[退出]</a> │ <label id="lastLogin">上次登录时间 :${sessionScope.member.lastLogin  }</label></div>
   		<div class="personal">
            	<div class="sidebar">
                	<h1>我的帐户</h1>
                	<ul>
                		<li ><a href="improve.html" >完善资料</a></li>
                		<li class="on"><a href="binding.html" class="bule">绑定微信</a></li>
                		<li ><a href="password.html" >修改密码</a></li>
                		<li ><a href="orderlist.html" >我的订单</a></li>
                    	<li><a href="score.html">我的积分</a></li>
                        <li><a href="coupon.html">我的优惠劵</a></li>
               		</ul>
                </div>
                <div class="list">
                	<div style="width:80%; margin:40px auto">
                		<div id="weixin" style="margin-top:100px;margin-left:100px;display: none;">此账号已经绑定过微信号</div>
                		<div id="weixin1" style="margin-left:100px"><a href="javascript:void(0);" onclick="bindingweixin()"><img src="images/binding.png" width="220" height="220" /></a></div>
                		<div id="weixin2" style="margin-left:100px;display: none;"><img id="tempqr" src="${result.ret.qrUrl}" width="220" height="220" /></div>
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
