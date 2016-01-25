<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="popup" style="width:850px; height:700px; margin:80px" id="step2">
	<div class="title" style="padding-bottom:30px;">订单支付
      <div class="plan" style="background-position:0 -39px"></div>
	  <button onclick="$.modal.close();">×</button></div>
    <div class="content">
    	
    	
    	<div class="form-group">
          <label>订单信息：</label>
          <div class="form-control">
            <ul>
              <li>周杰伦2014魔天伦世界巡回演唱会太原站</li>
              <li>订单号：SN2014091100002 票价：${ticketPriceDto.ticketPrice}*${count}=${price }</li>
            </ul>
          </div>
          <div class="clear"></div>
          <div class="form-group">
            	<label>&nbsp;</label>
            	<div class="form-control"><input class="popbutton" type="button" onclick="$.modal.close();" value="请在弹出窗口中支付"></div>
        	</div>
        </div>
        
      
    </div>
</div>