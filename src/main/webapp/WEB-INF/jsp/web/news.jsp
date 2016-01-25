<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
    	<c:forEach items="${pageView.records }" var="infolist" varStatus="v">
    		<div class="news-list">
    		<a href="news_detail.html?id=${infolist.id }" ><img src="${infolist.image}" width="230" height="150" /></a> 
    		<div class="news-txt">
    			<h1><a href="news_detail.html?id=${infolist.id }" >${infolist.title}</a></h1>
    			<h2>${infolist.infosource}${infolist.createDate}</h2>
    			<p>${fn:substring(infolist.desctext,0,200)}${fn:length(infolist.desctext)>200?'...':''}<a href="news_detail.html?id=${infolist.id }" class="bule">[全文]</a></p>
    		</div>
    		<div class="clear"></div>
    		</div>
    	</c:forEach>    
        
        <nav>
          	<%@include file="/WEB-INF/jsp/share/page.jsp"%>
        </nav>
    </div>
    
    <!--footer开始-->
    
    <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
    
    <!--footer结束-->
</div>
<script type="text/javascript">
 function help(thisObj,i){
	 var name=thisObj.text;
	 window.location.href='help.html?name='+name+"&i="+i;
 }
</script>
</body>
</html>

