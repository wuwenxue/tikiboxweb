package co.dc.web.tikibox.action;

import java.util.ArrayList;
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
import co.dc.server.member.dto.CouponDto;
import co.dc.server.member.dto.MemberDto;
import co.dc.server.member.dto.PointsDetailDto;
import co.dc.server.member.rmi.RmiMemberServer;
import co.dc.server.order.rmi.OrderDto;
import co.dc.server.order.rmi.RmiOrderService;
import co.dc.server.ticket.rmi.RmiTicketService;
import co.dc.server.webcontrol.rmi.RmiWebcontrolService;

@Controller
public class MemeberAction {

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

	@RequestMapping("/orderdetal")
	public ModelAndView orderdetal(HttpServletRequest request,long id) {
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		if (member == null) {
			return new ModelAndView("redirect:/login.html").addObject("returl","orderdetal.html");
		}
		
		OrderDto orderDto = orderService.findOrder(id);
		return new ModelAndView("rember/orderdetal").addObject("orderDto", orderDto);
	}

	@RequestMapping("/coupon")
	public ModelAndView coupon(HttpServletRequest request) {
		
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		if (member == null) {
			return new ModelAndView("redirect:/login.html").addObject("returl","coupon.html");
		}
		
		List<CouponDto> list = new ArrayList<CouponDto>();
		
		return new ModelAndView("rember/coupon").addObject("list", list);
	}

	@RequestMapping("/orderlist")
	public ModelAndView orderlist(HttpServletRequest request, Integer currentpage) {
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		if (member == null) {
			return new ModelAndView("redirect:/login.html").addObject("returl","orderlist.html");
		}
		
		
		if(currentpage==null){
			currentpage = 1;
		}

		PageView<OrderDto> pageView = new PageView<OrderDto>(currentpage,
				request);
		pageView.setForwardPath("orderlist.html");

		QueryResult<OrderDto> queryResult = orderService.orderList(
				pageView.getFirstIndex(), pageView.getMaxresult(), member.getId(),
				PlatformConstant.TIKIBOX_WEB.getVal(),0);

		pageView.setRecords(queryResult.getResultlist()); 
		pageView.setTotalrecord(queryResult.getTotalrecord());

		return new ModelAndView("rember/orderlist").addObject("pageView", pageView);
	}

	@RequestMapping("/score")
	public ModelAndView score(HttpServletRequest request) {
		
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		if (member == null) {
			return new ModelAndView("redirect:/login.html").addObject("returl","orderlist.html");
		}
		
		
		List<PointsDetailDto> list = new ArrayList<PointsDetailDto>();

		return new ModelAndView("rember/score").addObject("list", list);
	}


	

}
