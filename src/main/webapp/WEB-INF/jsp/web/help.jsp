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
<%@include file="/WEB-INF/jsp/share/linkjs.jsp"%> 
<script language="javascript">
//Tab面板JS
$(function () {
	nTabs(null,'${i}');
});

function nTabs(thisObj,Num){
	if(thisObj!=null){
if(thisObj.className == "active")return;
	}
var tabObj = "myTab1";
var tabList = document.getElementById(tabObj).getElementsByTagName("li");
for(i=0; i <tabList.length; i++)
{
  if (i == Num)
  {
	  if(thisObj!=null){
   thisObj.className = "active"; 
	  }
      document.getElementById(tabObj+"_Content"+i).style.display = "block";
  }else{
	  if(thisObj!=null){
   tabList[i].className = "normal";
	  }
   document.getElementById(tabObj+"_Content"+i).style.display = "none";
  }
} 
}
function help(thisObj,i){
	 var name=thisObj.text;
	 window.location.href='help.html?name='+name+"&i="+i;
}
</script>
<link href="images/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="warp">
    <div class="head">
          <div class="centre">
            <div class="logo" ><a href="index.html"><img src="images/logo.png" width="236" height="45" /></a></div>
            <div class="sub_logo">帮助中心</div> 
            
 </div>
    </div>

	<div class="sub_bar"></div>
    
    <div class="centre">
    	 <div style="height:70px"></div>
    	 <div class="help" id=myTab1_Content0>
           	<h1 class="title">账号注册</h1>
            <h1>（1）如何注册？</h1>
            <p>注册支持邮箱或手机，手机需要验证码。</p>
            <h1>（2）注册哪些内容？</h1>
			<p>填写您的邮箱地址或手机号码、设置密码（长度不得少于 6 位、支持数字、字母、特殊字符）。</p>
            <h1>（3）账号注册需要激活吗？</h1>
            <p>注册账号不需要激活，但是购买票的时候需要认证。</p>
			<h1>（4）未注册用户的权限有哪些？</h1>
			<p>未注册用户可以浏览网站所有的页面，可以提问。但不能进行实质操作，比如购买，和访问个人中心。</p></div>



		<div class="help none"  id=myTab1_Content1>
           	<h1 class="title">登录</h1>
            <h1>（1）登录的用户名是什么？</h1>
<p>在盒子房的登录用户名为注册时填写的email地址。 登录时请填写完整的email地址，如： xxxxx@gmail.com，也支持手机号码登录。</p>
          <h1>（2）登录密码可以修改吗？怎么修改？</h1>
		  <p>登录密码可以修改。登录盒子房进入个人中心后，点击“账户安全”在该页面完成邮箱和密码的修改。<br />
          请在登录页面点击“忘记密码”链接，系统会发邮件到您的邮箱，负责邮箱里提示的链接即可重设密码。也可以选择手机验证获取验证码。</p>
          <h1>（3）登录失败的原因有哪些？</h1>
       	  <p>1、没有注册，先去注册；<br />
      		2、注册email账号错误；<br />
        	3、帐号密码错误，点击“忘记密码”。<br />
        	4、验证码错误</p> </div>

		<div class="help none"  id=myTab1_Content2>
           	<h1 class="title">帐户安全</h1>
            <h1>（1）密码忘了如何找回？</h1>
            <p>1、您可以在登录页面点击链接：找回密码
            <br />
            2、填入注册用的Email地址或手机号码
            <br />
            3、点击“下一步”<br />
            4、a)邮箱地址：进入邮箱点击重新设置密码的链接进入重设密码页面设置您常用的密码。b)手机号码：进入手机校验码界面，系统会向您的手机发送6位数字字母组合的校验码，将校验码正确输入后点击“下一步”进行重设  密码页面设置您常用的密码。
            </p>
			<h1>（2）账号如何认证？</h1>
			<p>本网站只有通过实名认证后方可购票，您可以登录页面后点“我的盒子”，选择“账号安全”，输入真实姓名和身份证号即可完成认证，请仔细核对您的身份信息，因个人原因填写出错导致无法出票后或无法通过安检入场的需要本人承担经济损失。</p>
            <h1>（3）如何将账户绑定手机号码？</h1>
            <p>1、首先在页面顶部点击“我的盒子”，选择“账户安全”，找到对应的手机绑定选项
            <br />
            2、点击立即验证标签<br />
            3、输入您需要绑定的手机号码，获取验证码，输入验证码即可。
            </p>
			<h1>（4）如何将账户绑定邮件地址？</h1>
            <p>1、首先在页面顶部点击“我的盒子”，选择“账户安全”，找到对应的邮箱绑定选项<br />
            2、输入邮箱地址，选择点击立即验证标签<br />
            3、到绑定的邮箱激活即可。
            </p>
            <h1>（5）绑定手机号/邮箱地址是否可以更改？</h1>
            <p>可以更改，您可以登录页面后点“我的盒子”，选择“账号安全”，更换您绑定的手机号码/邮箱地址即可。</p>
         </div>

		<div class="help none"  id=myTab1_Content3>
       	    <h1 class="title">积分规则</h1>
            <h1>（1）积分的规则如下：</h1>
            <p>1、注册帐号：赠送100积分。只增加一次。<br />
            2、完成邮箱绑定，赠送100积分。只增加一次，可以修改不能解绑。<br />
            3、完成手机绑定：赠送200积分。只增加一次，可以修改不能解绑。
            <br />
            4、完成身份验证：赠送200积分。只增加一次，不可以修改。<br />
            5、登录：10积分。每天登录只取一次算有效积分。<br />
            6、购买票务有对应的返积分标识，订单成功就返积分，1元人民币=1积分。
            </p>
            <h1>（2）积分是否有有效期</h1>
            <p>积分的有效期为获取之日起的一年时长，即如果积分是2014年6月1日获取的，则到2015年6月1日失效。</p>
		 </div>

		<div class="help none"  id=myTab1_Content4>
           	<h1 class="title">订购方式</h1>
            <h1>（1）在线订购的流程是什么？</h1>
			<p>选择商品→确认订单→选择支付方式→查看订单</p>
            <h1>（2）电话订购的方法及注意事项?</h1>
            <p>全国统一服务热线：400-***-****温馨提示：由于热门商品的电话订购人数较多，可能会导致您不能及时打入电话进行订购，请您稍等一下再拨打或是通过我们的网站在线订购商品。对您造成的不便我们非常抱歉，感谢您对盒子房的支持与理解。 </p>
            <h1>（3）都哪些城市支持上门订购？公司具体地址是什么？</h1>
          <p>盒子房目前只支持南京地区上门订购。<br />
            盒子房南京站<br />
            地址：南京市鼓楼区大锏银巷17号艺术金陵园区博慧楼<br />
            客服电话: 025-86666888<br />
            营业时间：星期一至星期五:9:00-18:00 星期六至星期日:9:00-18:00<br />
            <a href="南京市鼓楼区大锏银巷17号艺术金陵园区博慧楼" class="c_blue">地图查看交通线路</a></p>
		</div>

		<div class="help none"  id=myTab1_Content5>
           	<h1 class="title">支付方式 </h1>
            <h1>1、盒子房支持哪些支付平台？</h1>
			<p>银联在线、支付宝、微支付<br />
          	<h1>2、我可以使用哪些网上银行支付？</h1>
			<p>目前支持17家银行的网上支付：<br />
            <img src="images/bank/zs.jpg" width="117" height="40" /><img src="images/bank/zx.jpg" width="112" height="40" /></p>
		</div>

		<div class="help none"  id=myTab1_Content6>
       	    <h1 class="title">配送方式</h1>
            <h1>（1）快递配送运费说明</h1> 
            <p>运至  南京市同城 运费：12元   满500元免运费,不满收12元<br />
            运至   安徽    运费：12元<br />  
            运至   浙江    运费：12元<br />
            运至   江苏    运费：12元<br />
            运至   上海    运费：12元<br />
            运至   澳门    运费：92元<br />
            运至   香港    运费：92元<br />
            运至   台湾    运费：92元<br />
            运至   其它城市   运费：22元  
			</p>
            <h1>（2）上门自取需要提供什么信息？</h1>
            <p>上门自取需携带订票人身份证并提供订票人姓名、手机号、订单号。
            若代领的话请出示订票人身份证原件及代领人身份证原件并提供订票人姓名、手机号、订单号。</p>

            <h1>（3）上门自取点有哪些？</h1>
          <p>盒子房目前只支持南京地区上门订购。<br/>
            盒子房南京站<br/>
            地址：南京市鼓楼区大锏银巷17号艺术金陵园区博慧楼<br/>
            客服电话：025-86666888<br />
            营业时间：星期一至星期五:9:00-18:00<br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;星期六至星期日:9:00-18:00<br/>
            <a href="南京市鼓楼区大锏银巷17号艺术金陵园区博慧楼" class="c_blue">地图查看交通线路</a> </p>
           </div>

		<div class="help none"  id=myTab1_Content7>
           	<h1 class="title">售后服务 </h1>
          	<h1>（1）盒子房退换货说明：</h1>
            a、不可抗力情况<br/>
			<p>因不可抗力因素导致演出取消或延期，盒子房会主动与您确认退票事宜，不收取任何手续费。<br/>
			办理退、换货的要求：<br/>
			（1） 符合退、换货时间规定（依据：主办方通知的因演出取消/延期安排的退票时间、转场时间段）；<br/>
			（2） 需将票品完好无损退回；<br/>
			（3） 如开发票，需将发票完好无损退回； </p> 
			b、非不可抗力情况
　　			<p>1、关于无理由退换票品说明<br/>
根据《网络交易管理办法》中关于：“其他根据商品性质并经消费者在购买时确认不宜退货的商品，不适用无理由退货。”的规定，鉴于文体演出票品特殊性，演出门票为联网售票，门票和座位都是唯一的，具有时效性、唯一性、数字化等特殊属性，一旦票品售出，不支持无理由退换，请您在购买时务必仔细核对您的订单信息并审慎下单。（因不可抗力因素导致演出取消或延期除外）。</p>
 
            <h1>（2）如何获取发票</h1>
            <p>配送：发票与演出门票同时送到您指定地址（特殊项目除外）<br/>
            自取：您上门取票时可同时获取发票（特殊项目除外）<br/>
            演出结束后统一开具发票，发票可通过上门自取、挂号信、平信方式获取；若需快递，快递费到付。</p>

            <h1>（3）发票怎么备注</h1>
            <p>（1）网上订单<br/>
              请您将“发票抬头”填写至“我要开发票”内，并确认发票信息<br/>
            （2）电话订单<br/>
            请您将“发票抬头”告知客服人员</p>

<h1>（4）发票注意事项</h1>
<p>(1）发票为“机打”或“手写”，此发票可以用作单位报销使用<br/>
(2）发票内容为“票款”【如购买的是演唱会，也可能会是 ***演唱会票款】<br/>
(3）配送费金额不包含在订单发票金额中<br/>
(4）发票抬头不能为空，抬头不能开“南京”、“公司”之类的泛称<br/>
(5）部分城市演出门票即是发票，不另开发票<br/>
(6）订单生效后（演出开始前），可补开发票，演出一旦结束则无法为您提供补开发票服务。</p> </div>
        
        
        
        
        <div class="help-bar">
        	<h1>帮助中心</h1>
            <ul id="myTab1">
            	<li onclick="nTabs(this,0);"><a>账号注册</a></li>
                <li onclick="nTabs(this,1);"><a>登录</a></li>
                <li onclick="nTabs(this,2);"><a>帐户安全</a></li>
                <li onclick="nTabs(this,3);"><a>积分规则</a></li>
                <li onclick="nTabs(this,4);"><a>订购方式</a></li>
                <li onclick="nTabs(this,5);"><a>支付方式</a></li>
                <li onclick="nTabs(this,6);"><a>配送方式</a></li>
                <li onclick="nTabs(this,7);"><a>售后服务</a></li>
                
            </ul>
        </div>
        <div class="clear"></div>
    </div>
    
    <div style="height:100px"></div>
    
    <%@include file="/WEB-INF/jsp/share/footTwo.jsp"%>
    
</div>
</body>
</html>
