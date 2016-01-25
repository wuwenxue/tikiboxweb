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

<body>
<div class="warp">
       <div class="head">
        <%@include file="/WEB-INF/jsp/share/headOne.jsp"%>
    </div>
    
    <div class="bar">
        <%@include file="/WEB-INF/jsp/share/headThree.jsp"%>
    </div>
    
    <div class="centre">
    	<div style="height:55px"></div>
        
        <!-- <div class="special">
            <img src="images/special1.jpg" width="708" height="300" />
            <div>
                <h2>足球仲夏夜，2014舜天球票秒杀活动</h2>
                <h3>活动时间：<u>2014.7.1-2014.7.15</u></h3>
                <p>2013年专辑《安和桥北》爆红后，宋冬野这个名字开始进入文艺青年的视野。专辑通过虾米音乐人首发后，48小时内试听量直击百万，至今试听量已经突破2800万次。</p>
                <a href="#">我要参加</a>
            </div>
        </div> -->
        
        
        <nav>
        		<%@include file="/WEB-INF/jsp/share/page.jsp"%>
        </nav>
        
    </div>
      
    <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>
<script type="text/javascript">
 function help(thisObj,i){
	 var name=thisObj.text;
	 window.location.href='help.html?name='+name+"&i="+i;
 }
</script>
</body>
</html>
