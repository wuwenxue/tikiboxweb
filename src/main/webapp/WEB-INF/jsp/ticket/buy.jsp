<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<div class="popup" style="width:850px; height:650px; " id="step1">
    <div class="title" style="padding-bottom:30px;">订单确认<div class="plan"></div><u><button onclick="$.modal.close();">×</button></u></div>
    <div class="content">
        <form action="ticketBuyDo.html" method="post" id="myform">
        <input type="hidden" value="${ticketDto.id}"  name="ticketId">
        <input type="hidden" value="${ticketPriceDto.id}"  name="priceId">
        <input type="hidden" value="${count}"  name="count">
        <input type="hidden" value="${isIndex}"  name="isIndex">
        <input type="hidden" value="${siteSerial}"  name="siteSerial">
        <div class="form-group">
          <label class="lefttitile">订单信息：</label>
          <div class="form-control">
            <ul>
              <li>${ticketDto.ticketName}</li>
              <li>时间：${ticketDto.showTime} 场馆：${ticketDto.venuesName} 票价：${ticketPriceDto.ticketPrice}*${count}=${price }</li>
            </ul>
          </div>
          <div class="clear"></div>
        </div>
        <hr />
        
        <c:if test="${!empty buyDtos}">
        
        <div class="form-group">
          <label class="lefttitile">座位信息：</label>
          <div class="form-control">
            <ul>
              <li>${siteName}</li>
            </ul>
          </div>
          <div class="clear"></div>
        </div>
        <hr />
        </c:if>
        
        
      <div class="form-group">
          <label class="lefttitile">配送方式：</label>
          <div class="form-control">
          <input type="radio" name="sendType" value="1" checked="checked" onchange="sendTypeFun()" />上门自取<input type="radio" name="sendType"  value="0" onchange="sendTypeFun()" />快递<br /><br />
          <span class="blue" >自取地址：江苏省南京市玄武区苏园路6号</span><br />
          <span class="red"><u>500元以下顺丰到付，500元以上包邮。（港澳台除外）</u></span> </div>
          <div class="clear"></div>
        </div>
        <hr />
      <div class="form-group" id="addressDiv1" style="display: none;">
          <label class="lefttitile">收货地址：</label>
          <div class="form-control">
            <table border="0" cellpadding="0" cellspacing="0"  style="width: 550px;">
             <tr>
                    <td width=15%>收货人:</td>
                    <td><input id="consignee" name="consignee" type="text"  class="txt" style="float: left" onblur="check1(this.value)"
                    		<c:if test="${!empty orderDto}">value="${orderDto.consignee}"</c:if>/>
                    		
                    </td>
             </tr>
            
              <tr>
                  <td>详细地址:</td>
                  <td>
                  	<select name="provinceId" id="provinceId" onchange="select(this.value)" style="float: left;">
                          <c:forEach var="v" items="${plist}">
							<option value="${v.proId}" >${v.proName}</option>
							</c:forEach>
							</select>
							<select id="cityId" name="cityId" style="float: left;">
							<option value="1">北京市</option>
							</select><input name="detailedAddress" id="detailedAddress" type="text"  class="txt" 
                  	  <c:if test="${!empty orderDto}">value="${orderDto.address}"</c:if>>
                  </td>
              </tr>
                
                
            </table>
          </div>
          <div class="clear"></div>
        </div>
        <hr id="addressDiv2" style="display: none;" />
        
        
        
      <div class="form-group">
          <label class="lefttitile">支付方式：</label>
          <div class="form-control"><input type="radio" name="payType"  value="0" checked="checked" />支付宝支付</div>
          <div class="clear"></div>
        </div>
        <hr />
        
          <div class="form-group">
          		<label class="lefttitile">&nbsp;</label>
                  <div class="form-control">手机
						<input name="telephone" id="telephone" type="text"  class="txt"   onblur="check3(this.value)" 
                  		<c:if test="${empty orderDto}">value="${phone}"</c:if>
                  		<c:if test="${!empty orderDto}">value="${orderDto.mobile}"</c:if>/>
                  	</div>
                  	<div class="clear"></div>
      	</div>
        
        <div class="form-group">
            <label class="lefttitile">&nbsp;</label>
            <div class="form-control">留言 <input type="text" size="50" name="message"   class="txt" /> </div>
            <div class="clear"></div>
        </div>
        <hr />
        <div class="form-group">
            <label class="lefttitile">&nbsp;</label>
            <div class="form-control">商品总价:<span class="red">￥${price }</span></div>
        </div>
        
        <div class="form-group">
            <label class="lefttitile">&nbsp;</label>
            <div class="form-control">
            <button id="button" onclick="sumbitOrder()" type="button" style="float:left">提交订单</button>
            <div style=" float:left ;padding-top:18px; padding-left:5px"><input id="checkbox" type="checkbox" checked="checked"  onchange="check4()" >我已阅读并同意<a href="rule.html" target="blank" class="blue" >《购票服务条款》</a></div>
            
            </div>
        </div>

        </form>
    </div>
</div>




<div class="popup" style="width:850px; height:700px; margin:80px;display: none;" id="step2">
	<div class="title" style="padding-bottom:30px;">订单支付
      <div class="plan" style="background-position:0 -39px"></div>
	  <u><button onclick="$.modal.close();">×</button></u></div>
    <div class="content">
    	
    	
    	<div class="form-group">
          <label class="lefttitile">订单信息：</label>
          <div class="form-control">
            <ul>
              <li >${ticketDto.ticketName}</li>
              <li>订单号：<span id="orderNoSpan"></span></li>
              <li>票价：${ticketPriceDto.ticketPrice}*${count}=${price }</li>
              
              <c:if test="${!empty buyDtos}">
        			<li>座位信息：${siteName}</li>
        		</c:if>
        
        
            </ul>
          </div>
          <div class="clear"></div>
          <div class="form-group">
            	<label class="lefttitile">&nbsp;</label>
            	<div class="form-control"><button type="button" onclick="$.modal.close();">请在弹出窗口中支付</button></div>
        	</div>
        	
        </div>
        
        
      
    </div>
</div>

<script type="text/javascript">

$(document).ready(
		function() {
		<%
		  session.removeAttribute("phone");
		%>
			$("#myform").validate({
				rules : {
					consignee : {
						required : true,
						nameReal:true
					},
					
					detailedAddress : {
						required : true,
					},
					telephone : {
						required : true,
						mobile:true
					}
				},
				messages : {
					consignee : {
						required : "姓名不能为空",
						nameReal : "请输入合法姓名"
					},
					
					detailedAddress : {
						required : "地址不能为空",
						
					},
					telephone : {
						required : "手机不能为空",
						mobile : "请输入正确的手机号"
					}
				}
			});
			
			<c:if test="${provinceId!=null&&provinceId!='' }">
				$("#provinceId").val(${provinceId });
				select(${provinceId });
			</c:if>

		}
);


function select(val){
	$.ajax({
		type:'POST',
		url:'getCity.html',
		data:{id:val},
		dataType:'json',
		success:function(result){
			var html="";
			if(result.length==0){
				html='<option >无</option>';
			}else{
				for(var i=0;i<result.length;i++){
					var v=result[i];
					html+='<option value="'+v.cityId+'">'+v.cityName+'</option>';
				}
			}
			$('#cityId').html(html);
			<c:if test="${cityId!=null&&cityId!='' }">
			$("#cityId").val(${cityId });
			</c:if>
		}
	});
}


function check4(){
	if(!document.getElementById("checkbox").checked){
		document.getElementById("button").style.backgroundColor="gray";
	}else{
		document.getElementById("button").style.backgroundColor="#f1651e";
	}
}

function check3(phone){
	 $("#phone1").css("display","none");
	 $("#phone2").css("display","none");
	 $("#phone3").css("display","none");
	 var _d=/^1[3458]\d{9}$/; 
	   
	    if(_d.test(phone)){
			$("#phone3").css("display","block");

	 }else{
		$("#phonewrong").css("display","block");
		$("#phoneone").focus();
	 }
	 
}


	function sendTypeFun(){
		var sendType = $("input[name='sendType']:checked").val();
		if(sendType==0){
			$("#addressDiv1").show();
			$("#addressDiv2").show();
		}else{
			$("#addressDiv1").hide();
			$("#addressDiv2").hide();
		}
	}
	
	function sumbitOrder(){
		if(!document.getElementById("checkbox").checked){
			return false;
		}
		if ($("#myform").validate().form()==true&&confirm("确认提交订单并付款吗？")==true) {
			
				var result;
				$.ajax({
				   type: "POST",
				   url: "ticketBuyDo.html",
				   cache:false,
				   async:false,
				   dataType:"json",
				   data: $('#myform').formSerialize(),
				   success: function(msg){
					   result = msg;
				   }
				});
				if(result.status == 11) {
					alert("请先登录");
					window.location = result.ret;
				}else if(result.status == 12) {
					window.location = result.ret;
				}else if(result.status == 0) {
					$("#orderNoSpan").text(result.ret);
					$("#step1").empty().append($("#step2").html());
					window.open("payDo.html?orderNo="+result.ret,"openwin");
				}else{
					alert(result.desc);
				}
		}
	}
	function okfun(orderNo){  
	    alert("订单号"+orderNo+"支付成功，将为您跳转订单页面");
	    window.location = "../orderlist.html";
	}  
</script>