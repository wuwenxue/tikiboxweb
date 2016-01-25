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
<link href="css/news.css" rel="stylesheet" type="text/css" />
<%@include file="/WEB-INF/jsp/share/linkjs.jsp"%> 
<script type="text/javascript">

</script>
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
    	<div style="height:70px"></div>
    	<div class="news-title">
            <h1><a href="news.html">${info.title}</a></h1>
            <h2>${info.infosource}${info.createDate}</h2>
		</div>
        <div>${info.description}</div>
		<div style="height:100px;"></div>
        
        
    </div>
    
    
    
    
    
   <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>
</body>
</html>
