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
$(function(){
	var html="";
	var count='${count}';
	
	if(count==0){
		html+="<li><a >&laquo;</a></li>";
		html+="<li><a >"+1+"</a></li>";
		html+="<li><a >&raquo;</a></li>";
	}else{
		html+="<li><a >&laquo;</a></li>";
		var t=0;
		if(parseInt(count/4)==parseFloat(count/4)){
			t=parseInt(count/4);
		}else{
			t=parseInt(count/4)+1;
		}
		for(var i=1;i<t+1;i++){
			
			html+="<li><a href='score.html?page="+i+"'>"+i+"</a></li>";
		}
		html+="<li><a >&raquo;</a></li>";
	}
	$(".pagination").html(html);
});

<!--

//-->
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
                		<li ><a href="orderlist.html" >我的订单</a></li>
                    	<li class="on"><a href="score.html" class="bule">我的积分</a></li>
                        <li><a href="coupon.html">我的优惠劵</a></li>
               		</ul>
                </div>
                <div class="list">
                	<!-- <p><select>
                	  <option>交易时间</option>
                  </select><button class="gray">查询</button></p> -->
                	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table-striped">
                    	<thead>
                    	<tr>
                          <th width="27%">积分来源</th>
                          <th width="8%">积分数</th>
                          <th width="15%">获得原因</th>
                          <th width="8%">金额</th>
                          <th width="21%">获得时间</th>
                          <th width="21%">有效期</th>
                        </tr>
                        </thead>
                        
                        <tbody>
                        <c:forEach items="${list }" var="list">
                       		 <tr>
                          	<td>${list.productName }</td>
                          	<td>${list.point }</td>
                          	<td>${list.result }</td>
                          	<td>${list.price }</td>
                          	<td>${list.createDate }</td>
                          	<td>${list.validate }</td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
          </div>
                <div class="clear"></div>
                	<div class="clear"></div>
              	<nav>
                 <ul class="pagination">
         		 </ul>
         		 </nav>
                
                
            </div>
      </div>
    </div>
    
    <div style="height:100px"></div>
    
    <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>
</body>
</html>
