package co.dc.web.tikibox.action;


import java.util.List;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.dc.commons.platform.PlatformConstant;
import co.dc.commons.upyun.UpYun;
import co.dc.server.ticket.dto.TicketDto;
import co.dc.server.ticket.dto.TicketPriceDto;
import co.dc.server.ticket.rmi.RmiTicketService;
import co.dc.server.webcontrol.rmi.RmiWebcontrolService;
import co.dc.server.webcontrol.rmi.WebcontrolDto;
import co.dc.server.member.dto.CouponDto;
import co.dc.server.member.dto.PointsDetailDto;
import co.dc.server.member.rmi.RmiMemberServer;
import co.dc.server.order.rmi.RmiOrderService;



@Controller
public class IndexAction extends BaseAction{
	
	@Resource
	public RmiMemberServer memberServer;
	
	@Resource
	public RmiOrderService orderService;

	@Resource
	private RmiWebcontrolService rmiWebcontrolService;
	@Resource
	private RmiTicketService rmiTicketService;
	@Resource
	private Configuration configuration;
	
	@RequestMapping("/index")
	public ModelAndView index(){
		List<WebcontrolDto> webBigConList = rmiWebcontrolService.getbigimage(PlatformConstant.TIKIBOX_WEB.getVal());
		WebcontrolDto dto = webBigConList.get(0);
		TicketDto ticketDto = rmiTicketService.getTicketInfoByTicketId(dto.getRootId());
		List<WebcontrolDto> webConList = rmiWebcontrolService.getimage(PlatformConstant.TIKIBOX_WEB.getVal());
		
		String siteurl=configuration.getString("siteurl");
		return new ModelAndView("index").addObject("webBigCon", dto).addObject("webConList", webConList).addObject("ticketDto", ticketDto).addObject("siteurl", siteurl);
	}
	
	
	
	@RequestMapping("/help")
	public ModelAndView help(String name,int i){
		return new ModelAndView("web/help").addObject("name", name).addObject("i", i);
	}
	
	
	
	@RequestMapping("/special")
	public ModelAndView special(){
		return new ModelAndView("web/special");
	}
	
	
	@RequestMapping("/register")
	public ModelAndView register(){
		return new ModelAndView("web/register");
	}
	
	@RequestMapping("/rule")
	public ModelAndView rule(){
		return new ModelAndView("web/rule");
	}
	
	
	@RequestMapping("/register_rule")
	public ModelAndView register_rule(){
		return new ModelAndView("web/register_rule");
	}
	
	
	
	@RequestMapping("/login")
	public ModelAndView login(String returl){
		if(StringUtils.isEmpty(returl)){
			return new ModelAndView("web/login");
		}else{
			return new ModelAndView("web/login").addObject("returl", returl);
		}
		
	}
	@RequestMapping("/seat")
	public ModelAndView seat(){
		return new ModelAndView("web/seat");
	}
	@RequestMapping("/password")
	public ModelAndView password(HttpServletRequest request){
		if(request.getSession().getAttribute(BaseAction.MEMBER)==null){
			return new ModelAndView("web/login");
		};
		return new ModelAndView("web/password");
	}
	@RequestMapping("/siteproxy")
	public ModelAndView siteproxy(String serial){
		return new ModelAndView("web/siteproxy").addObject("serial", serial);
	}

}



