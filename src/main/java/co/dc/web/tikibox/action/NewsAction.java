package co.dc.web.tikibox.action;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.dc.commons.page.PageView;
import co.dc.commons.page.QueryResult;
import co.dc.commons.platform.PlatformConstant;
import co.dc.commons.upyun.UpYun;
import co.dc.server.member.rmi.RmiMemberServer;
import co.dc.server.order.rmi.OrderDto;
import co.dc.server.order.rmi.RmiOrderService;
import co.dc.server.ticket.rmi.RmiTicketService;
import co.dc.server.webcontrol.rmi.RmiWebcontrolService;
import co.dc.server.webcontrol.rmi.WebinfoDto;
@Controller
public class NewsAction {

	@Resource
	public RmiMemberServer memberServer;
	
	@Resource
	public RmiOrderService orderService;

	@Resource
	private UpYun upyun;
	@Resource
	private RmiWebcontrolService rmiWebcontrolService;
	@Resource
	private RmiTicketService rmiTicketService;
	@RequestMapping("/news")
	public ModelAndView news(HttpServletRequest request,Integer currentpage){
		if(currentpage==null){
			currentpage = 1;
		}
		PageView<WebinfoDto> pageView = new PageView<WebinfoDto>(currentpage,request);
		pageView.setForwardPath("news.html");
		QueryResult<WebinfoDto> queryResult = rmiWebcontrolService.getinfo(pageView.getFirstIndex(), pageView.getMaxresult(),PlatformConstant.TIKIBOX_WEB.getVal());
		pageView.setRecords(queryResult.getResultlist()); 
		pageView.setTotalrecord(queryResult.getTotalrecord());
		return new ModelAndView("web/news").addObject("pageView", pageView);
	}
	
	@RequestMapping("/news_detail")
	public ModelAndView news_detail(long id){
		WebinfoDto dto = rmiWebcontrolService.findInfoById(id);
		return new ModelAndView("web/news_detail").addObject("info", dto);
	}
}
