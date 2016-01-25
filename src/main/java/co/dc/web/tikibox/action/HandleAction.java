package co.dc.web.tikibox.action;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import co.dc.commons.dto.RetStatus;
import co.dc.commons.json.JSONException;
import co.dc.commons.json.JSONObject;
import co.dc.commons.platform.PlatformConstant;
import co.dc.commons.utils.MD5Utils;
import co.dc.commons.utils.ValidateUtils;
import co.dc.server.member.dto.MemberDto;
import co.dc.server.member.rmi.RmiMemberServer;
import co.dc.server.order.rmi.RmiOrderService;
import co.dc.server.site.rmi.RmiSiteServer;
import co.dc.server.weixin.rmi.RmiWeixinService;
import co.dc.server.weixin.rmi.TempQrDto;
import co.dc.sms.server.rmi.RmiSmsService;


@Controller
public class HandleAction extends BaseAction{
	
	@Resource
	public RmiSiteServer rmiSiteServer;
	@Resource
	public RmiSmsService rmiSmsService;
	@Resource
	public RmiOrderService orderService;
	@Resource
	public RmiMemberServer memberServer;
	@Resource
	public RmiWeixinService rmiWeixinService;
	
	
	@RequestMapping("/checkphone")
	@ResponseBody
	public String checkphone(String phone){
		RetStatus ret=memberServer.isPhone(phone,PlatformConstant.TIKIBOX_WEB.getVal());
		return new JSONObject(ret).toString();
	}
	
	@RequestMapping("/code")
	@ResponseBody
	public String code(String phone,HttpServletRequest request){
		if(!ValidateUtils.isMobile(phone)){
			return "-1";
		}
			Random ran = new Random();
		int	r = ran.nextInt(899999) + 100001;
		request.getSession().setAttribute("code", r+"");
		rmiSmsService.sendSms(PlatformConstant.TIKIBOX_WEB.getVal(), phone, "您获取的验证码："+r+"【盒子房】");
		return "0";
	}
	
	@RequestMapping("/sendpwd")
	@ResponseBody
	public String sendpwd(String phone){
		RetStatus ret=memberServer.isPhone(phone,PlatformConstant.TIKIBOX_WEB.getVal());
		if(ret.getStatus()==1||ret.getStatus()==0){
			return "-1";
		}
		String uuid=UUID.randomUUID().toString();
		uuid=uuid.substring(uuid.length()-8,uuid.length());
		updatePassword(uuid, phone);
		rmiSmsService.sendSms(PlatformConstant.TIKIBOX_WEB.getVal(), phone, "您的新密码为："+uuid+"【盒子房】");
		return "0";
	}
	
	@RequestMapping("/registerDo")
	@ResponseBody
	public String registerDo(String phone,String code,String pwd,HttpServletRequest request){
		String codes=(String)request.getSession().getAttribute("code");
		if(!code.equals(codes)||codes==null){
			return "-10";
		}
		String typeOfmember=PlatformConstant.TIKIBOX_WEB.getVal();
		RetStatus ret=memberServer.addUser(phone, pwd,  typeOfmember);
		return new JSONObject(ret).toString();
	}
	
	@RequestMapping("/loginDo")
	@ResponseBody
	public String loginDo(HttpServletRequest request,String phone,String passWord){
		
		RetStatus<MemberDto> ret = memberServer.login(phone, passWord,PlatformConstant.TIKIBOX_WEB.getVal());
		if(ret.getStatus()==0){
			request.getSession().setAttribute(BaseAction.MEMBER, ret.getRet());
			return 0+"";
		}else{
			return ret.getDesc();
		}
	}
	
	
	@RequestMapping("/logout")
	public ModelAndView logout(String phone,HttpServletRequest request){
		request.getSession().removeAttribute(BaseAction.MEMBER);
		return new ModelAndView("index");
	}
	
	
	@RequestMapping("/updatePassword")
	@ResponseBody
	public String updatePassword(String pwd,String name){
		String uuid = UUID.randomUUID().toString();
		uuid=uuid.substring(uuid.length()-8,uuid.length());
		String passWord=MD5Utils.getMD5(MD5Utils.getMD5(pwd)+uuid);
		RetStatus ret=memberServer.updatePassword(passWord, uuid, name,PlatformConstant.TIKIBOX_WEB.getVal());
		return ret.getStatus()+"";
		}
	
	@RequestMapping("/getTempQr")
	@ResponseBody
	public String getTempQr(){
		RetStatus<TempQrDto> ret = new RetStatus<TempQrDto>();
		ret = rmiWeixinService.buildLoginTempQr();
		return new JSONObject(ret).toString();
	}
	

	@RequestMapping("/qrLogin")
	@ResponseBody
	public String qrLogin(HttpServletRequest request,String serial){
		RetStatus<MemberDto> ret = new RetStatus<MemberDto>();
		ret = rmiWeixinService.qrIsLogin(serial);
		if(ret.getStatus()==0){
			request.getSession().setAttribute(BaseAction.MEMBER, ret.getRet());
		}
		return new JSONObject(ret).toString();
	}
	
	@RequestMapping("/binding")
	public ModelAndView binding(HttpServletRequest request) {
		
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		if (member == null) {
			return new ModelAndView("redirect:/login.html");
		}
		return new ModelAndView("web/binding");
	}
	
	@RequestMapping("/bindingCheck")
	@ResponseBody
	public String bindingCheck(HttpServletRequest request,String serial){
		RetStatus<MemberDto> ret = new RetStatus<MemberDto>();
		ret = rmiWeixinService.qrIsLogin(serial);
		if(ret.getRet()!=null){
			if(StringUtils.isNotEmpty(ret.getRet().getPhone())){
				ret.set(20, "已绑定过手机号", ret.getRet());
				return new JSONObject(ret).toString();
			}
		}
		if(ret.getStatus()==0){
			MemberDto dto = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
			if(StringUtils.isEmpty(dto.getWid())){
				ret.set(10, "可以绑定", ret.getRet());
				return new JSONObject(ret).toString();
			}else{
				ret.set(11, "覆盖绑定",  ret.getRet());
				return new JSONObject(ret).toString();
			}
		}
		return new JSONObject(ret).toString();
	}
	
	@RequestMapping("/bindingDo")
	@ResponseBody
	public String bindingDo(HttpServletRequest request,long id){
		
		RetStatus<MemberDto> ret = new RetStatus<MemberDto>();
		long formal = ((MemberDto)request.getSession().getAttribute(BaseAction.MEMBER)).getId();
//		System.out.println(formal+"---"+id);
		ret = memberServer.bindMemberByTiki(formal, id);
		if(ret.getStatus()==0){
			request.getSession().setAttribute(BaseAction.MEMBER,ret.getRet());
		}
		return new JSONObject(ret).toString();
	}
	
	@RequestMapping("/improve")
	public ModelAndView improve(HttpServletRequest request) {
		
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		if (member == null) {
			return new ModelAndView("redirect:/login.html");
		}
		return new ModelAndView("web/improve");
	}
	
	@RequestMapping("/improveDo")
	@ResponseBody
	public String improveDo(String phone,String code,String pwd,HttpServletRequest request){
		String codes=(String)request.getSession().getAttribute("code");
		if(!code.equals(codes)||codes==null){
			return "-10";
		}
		long id = ((MemberDto)request.getSession().getAttribute(BaseAction.MEMBER)).getId();
		RetStatus<MemberDto> ret = new RetStatus<MemberDto>();
		ret=memberServer.completeMessage(id, phone, pwd);
		System.out.println(ret);
		return new JSONObject(ret).toString();
	}
	
	
}
