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
<link href="images/popup.css" rel="stylesheet" type="text/css" />
<%@include file="/WEB-INF/jsp/share/linkjs.jsp"%>
<script type="text/javascript">

$(document).ready(
		function() {
		var tid = '<%=session.getAttribute("ticketId") %>';
		var pid = '<%=session.getAttribute("priceId") %>';
		var cid = '<%=session.getAttribute("count") %>';
		var sid = '<%=session.getAttribute("siteSerial") %>';
			
			if(sid != 'null'&&sid!=""){
				$('#order_pay_id').modal({minHeight:550,minWidth:850,maxHeight:700,maxWidth:850,position:"center"});
				  $("#order_pay_id").load("siteTicketBuy.html", {isIndex:1,siteSerial:sid}, function(){
				  });
				  <%
				  session.removeAttribute("ticketId");
				  session.removeAttribute("priceId"); 
				  session.removeAttribute("count"); 
				  session.removeAttribute("siteSerial"); 
				  %>
				  return false;
			}
			if(tid != 'null'&&pid !='null'&&cid !='null'&&tid !=""&&pid !=""&&cid !=""){
				 $('#order_pay_id').modal({minHeight:550,minWidth:850,maxHeight:700,maxWidth:850,position:"center"});
				  $("#order_pay_id").load("ticketBuy.html", {isIndex:1,ticketId:tid,priceId:pid,count:cid}, function(){
				  });
				  <%
				  session.removeAttribute("ticketId");
				  session.removeAttribute("priceId"); 
				  session.removeAttribute("count"); 
				  session.removeAttribute("siteSerial"); 
				  %>
				  return false;
			}
		});

  function selectPrice(priceId){
      if($("#price_"+priceId).hasClass("select")){
          $(".priceClass").removeClass("select");
          $("#priceCount").val(0);
          $("#ticketPriceId").val(0);
      }else{
          $(".priceClass").removeClass("select");
          $("#price_"+priceId).addClass("select");
          $("#priceCount").val(1);
          $("#ticketPriceId").val(priceId);
      }
      
    }
  
  function addCount(){
      if($("#ticketPriceId").val()==0){
          alert("请先选择价格!");
          return;
      }
      var ticketCount = $("#priceCount").val();
      if(ticketCount==6){
          return 0;
      }else if(ticketCount==5){
    	  alert("亲，最多一次只能买五张哦!");
      }else{
      	  ticketCount++;
      	  $("#priceCount").val(ticketCount);
      }
  }

  function delCount(){
      
      if($("#ticketPriceId").val()==0){
          alert("请先选择价格!");
          return;
      }
      
      var ticketCount = $("#priceCount").val();
      if(ticketCount==0){
          return 0;
      }else if(ticketCount==1){
          alert("亲，最低起买数量是一张哦!");
      }else{
          ticketCount = ticketCount-1;
          $("#priceCount").val(ticketCount);
      }
  }

  function willStart(){
	  alert("此票即将开售，敬请期待......");
  }
  
  function nowBuy(tid){
	  if($("#ticketPriceId").val()==0){
          alert("请先选择价格!");
          return;
      }
	  buyDo(tid);
  }
  
  function buyDo(tid){
	  $('#order_pay_id').modal({minHeight:550,minWidth:850,maxHeight:550,maxWidth:850,position:"center"});
	  $("#order_pay_id").load("ticketBuy.html", {isIndex:1,ticketId: tid,priceId:$("#ticketPriceId").val(),count:$("#priceCount").val()}, function(){
	  });
  }
  
  
  function ticketOver(){
	  alert("亲，您来迟了哦，票已卖完了......");
  }
  
  function ticketDown(){
	  alert("亲，您来迟了哦，票已下架了......");
  }
  
  
  function siteBuy(serial){
	  siteBuyDo(serial);
  }
  
  function siteBuyDo(serial){
	  $('#order_pay_id').modal({minHeight:550,minWidth:850,maxHeight:700,maxWidth:850,position:"center"});
	  $("#order_pay_id").load("siteTicketBuy.html", {isIndex:1,siteSerial:serial}, function(){
	  });
  }
  
  
</script>
</head>

<body>
	<div class="warp">
		<div class="head">
			<%@include file="/WEB-INF/jsp/share/headOne.jsp"%>
		</div>


		<div class="content">
			<div class="bar">
				<%@include file="/WEB-INF/jsp/share/headThree.jsp"%>
			</div>

			<div class="banner"
				style="background:url(${webBigCon.image}) no-repeat center"></div>

			<div class="detail_btn">
				<div class="centre">
						<a href="${webBigCon.url }" class="white">查看详细>></a>
				</div>
			</div>
			
			<div class="ht"></div> 
			
		</div>

		<div class="buy">
			<div class="centre">
			<input type="hidden" id="bigImgId" value="${webBigCon.rootId }"/>
			<input type="hidden" id="ticketPriceId" name="ticketPriceId"></input>
				<h1>${webBigCon.title }
				
				<c:if test="${ticketDto.supportType==1&&ticketDto.ticketStatus==1}">
					<a href="javascript:void(0)"
						onclick="help_buy_id()"><img src="images/seat.png" width="108" height="31" /></a>
					</c:if>
				</h1>
				
				<div id="priceDiv" class="price">
					
					<c:if test="${ticketDto.ticketStatus!=1}">
						<c:forEach items="${ticketDto.ticketPriceList }" var="price" varStatus="t">
								<%-- <a class="gray" >${price.ticketPrice }(${price.ticketType })</a> --%>
						</c:forEach>
						<%-- <div class="alert alert-warning">${ticketDto.ticketStatusDesc}</div> --%>
						<p>演出时间：${ticketDto.showTime }</p>
						<p>演出地点：${ticketDto.venuesName }</p>
					</c:if>
					<c:if test="${ticketDto.ticketStatus==1}">
						<c:forEach items="${ticketDto.ticketPriceList }" var="price" varStatus="t">
							<c:if test="${price.priceSaleStatus!=0}">
								 <a class="gray" >${price.ticketPrice }(${price.ticketType })</a> 
							</c:if>
							<c:if test="${price.priceSaleStatus==0}">
								<a id="price_${price.id}" class="priceClass" onclick="selectPrice(${price.id})">${price.ticketPrice }(${price.ticketType })</a>
							</c:if>
						</c:forEach>
					</c:if>
				</div>
				<!-- class="gray"  select -->
				<c:if test="${ticketDto.ticketStatus==1}">
				<div class="count">
					<label>数量：</label>
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td><button type="button" onclick="delCount()">－</button></td>
							<td><input id="priceCount" name="priceCount" type="text" size="3" value="0" readonly/></td>
							<td><button type="button" onclick="addCount()">＋</button></td>
						</tr>
					</table>
				</div>
				</c:if>
				<c:if test="${ticketDto.ticketStatus==0}">
				<div class="btn gray" >
					即 将<br />开 售
				</div>
				</c:if>
				<c:if test="${ticketDto.ticketStatus==2}">
				<div class="btn gray" >
					票 已<br />售 罄
				</div>
				</c:if>
				<c:if test="${ticketDto.ticketStatus==3}">
				<div class="btn gray" >
					票 已<br />下 架
				</div>
				</c:if>
				<c:if test="${ticketDto.ticketStatus ==1 }">
					<div class="btn" onclick="nowBuy(${ticketDto.id})">立 即<br />购 买</div>
				</c:if>
			</div>
		</div>
		<div class="more">
			<div class="centre">
				<h1>更多演唱会</h1>
				<ul>
					<c:forEach items="${webConList }" var="webConList" varStatus="v">
						<c:if test="${v.index<2 }">
							<a href="${webConList.url }" ><li>
								<p class="white;" style="font-size:20px; line-height:1.4; display:block; margin-bottom:10px;">${webConList.title }</p>
								<p>${webConList.description }</p></li></a>
							<li class="img">
									<a href="${webConList.url }" class="white"><img src="${webConList.image }" width="250" height="250" /></a>
								</li>
						</c:if>
						<c:if test="${v.index>=2&& v.index<4}">
							<li class="img">
									<a href="${webConList.url }" class="white"><img src="${webConList.image }" width="250" height="250" /></a>
								</li>
							<a href="${webConList.url }" ><li class="yellow">
									<p class="white" style="font-size:20px; line-height:1.4; display:block; margin-bottom:10px;">${webConList.title }</p>
								<b>${webConList.description }</b></li></a>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<div id="order_pay_id" style="display: none">	
		<img src="images/loading.gif"/>
	</div>
	
	<div id="seat_id" style="display: none">	
		<iframe scrolling="no" frameborder="0" src="${siteurl}showStadiumByTidAndSid.html?tid=${ticketDto.id}&sid=0" width="1032px" height="794px"></iframe>
	</div>
	
	
	<%@include file="/WEB-INF/jsp/share/footOne.jsp"%>

	<script type="text/javascript">
		function help(thisObj, i) {
			var name = thisObj.text;
			window.location.href='help.html?name=' + name + "&i=" + i;
		}
		 
		 function help_buy_id(){
			 $('#seat_id').modal();
		 };
		 
		 function seatRet(serial){
			
			 $.modal.close();
			 if(serial!=null&&serial!=""){
				 siteBuy(serial);
			 }
			 
		 }
		 
		 
	</script>
	
	
	
</body>
</html>

