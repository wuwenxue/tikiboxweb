package co.dc.web.tikibox.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import co.dc.commons.area.AreaService;
import co.dc.commons.area.CityDto;
import co.dc.commons.area.ProvinceDto;
import co.dc.commons.dto.RetStatus;
import co.dc.commons.json.JSONArray;
import co.dc.commons.json.JSONObject;
import co.dc.commons.page.QueryResult;
import co.dc.commons.platform.PlatformConstant;
import co.dc.server.member.dto.MemberDto;
import co.dc.server.member.rmi.RmiMemberServer;
import co.dc.server.order.rmi.OrderDto;
import co.dc.server.order.rmi.OrderGoodsDto;
import co.dc.server.order.rmi.RmiOrderService;
import co.dc.server.order.rmi.SubmitGoodsDto;
import co.dc.server.order.rmi.SubmitOrderDto;
import co.dc.server.site.dto.ToBuyDto;
import co.dc.server.site.rmi.RmiSiteServer;
import co.dc.server.ticket.dto.TicketDto;
import co.dc.server.ticket.dto.TicketPriceDto;
import co.dc.server.ticket.rmi.RmiTicketService;

@Controller
public class TicketAction {

	@Resource
	public RmiMemberServer memberServer;

	@Resource
	public RmiOrderService orderService;

	@Resource
	private RmiTicketService rmiTicketService;
	@Resource
	private Configuration configuration;
	@Resource
	private RmiSiteServer rmiSiteServer;

	@RequestMapping("/ticketDetail")
	public ModelAndView ticketDetail(long ticketId) {
		TicketDto ticketDto = rmiTicketService.getTicketInfoByTicketId(ticketId);
		String siteurl=configuration.getString("siteurl");
		return new ModelAndView("ticket/detail").addObject("ticketDto",ticketDto).addObject("siteurl", siteurl);
	}
	
	@RequestMapping("/ticketBuy")
	public ModelAndView buy(Integer isIndex,HttpServletRequest request,long ticketId,long priceId,int count,String siteSerial){
		
		TicketDto ticketDto = rmiTicketService.getTicketInfoByTicketId(ticketId);
		TicketPriceDto ticketPriceDto = rmiTicketService.getTicketPriceByPriceId(priceId);
		List<ProvinceDto> plist = AreaService.getAllProvince();

		String price = rmiTicketService.countPrice(priceId, count);
		
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		
		ModelAndView modelAndView = new ModelAndView();
		if(member==null){
			modelAndView = new ModelAndView("ticket/buy").addObject("ticketDto",ticketDto).
					addObject("ticketPriceDto",ticketPriceDto).addObject("count",count).
					addObject("price",price).addObject("isIndex", isIndex).addObject("plist", plist);
		}else{
			QueryResult<OrderDto> queryResult =orderService.orderList(0, 10000, member.getId(), PlatformConstant.TIKIBOX_WEB.getVal(), 0);
			if(queryResult.getResultlist().size()>0){
				
				
				OrderDto orderDto = queryResult.getResultlist().get(0);
				
				modelAndView = new ModelAndView("ticket/buy").addObject("ticketDto",ticketDto).
						addObject("ticketPriceDto",ticketPriceDto).addObject("count",count).
						addObject("price",price).addObject("isIndex", isIndex).addObject("plist", plist).addObject("orderDto", orderDto);
				
				
				String zipCode = orderDto.getZipcode();
				if(StringUtils.isNotEmpty(zipCode)){
					try{
						String[] zipArray = zipCode.split(",");
						String province = AreaService.getProvince(Integer.parseInt(zipArray[0])).getProName();
						String cityName = AreaService.getCity(Integer.parseInt(zipArray[1])).getCityName();
						orderDto.setAddress(orderDto.getAddress().replaceAll(province,"").replaceAll(cityName,""));
						modelAndView.addObject("provinceId", zipArray[0]);
						modelAndView.addObject("cityId", zipArray[1]);
					}catch(Exception e){
						e.printStackTrace();
					}
				}
			}else{
				String phone = member.getPhone();
				modelAndView = new ModelAndView("ticket/buy").addObject("ticketDto",ticketDto).
						addObject("ticketPriceDto",ticketPriceDto).addObject("count",count).
						addObject("price",price).addObject("isIndex", isIndex).addObject("plist", plist).addObject("phone", phone);
			}
		}

		return modelAndView;
	}
	
	
	@RequestMapping("/siteTicketBuy")
	public ModelAndView siteTicketBuy(Integer isIndex,HttpServletRequest request,String siteSerial){
		
		
		
		ModelAndView modelAndView = new ModelAndView("ticket/buy").addObject("isIndex", isIndex);
		List<ProvinceDto> plist = AreaService.getAllProvince();
		
		if(StringUtils.isNotEmpty(siteSerial)){
			List<ToBuyDto> buyDtos = rmiSiteServer.toBuy(siteSerial);
			modelAndView.addObject("buyDtos", buyDtos);
			StringBuffer sb = new StringBuffer();
			
			for(ToBuyDto buyDto : buyDtos){
				sb.append(buyDto.getSeatDesc()).append(" ");
			}
			
			TicketDto ticketDto = rmiTicketService.getTicketInfoByTicketId(buyDtos.get(0).getTid());
			TicketPriceDto ticketPriceDto = rmiTicketService.getTicketPriceByPriceId(buyDtos.get(0).getPriceId());
			
			String price = rmiTicketService.countPrice(buyDtos.get(0).getPriceId(), buyDtos.size());
			
			MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
			
			if(member==null){
				modelAndView.addObject("ticketDto",ticketDto).
				addObject("ticketPriceDto",ticketPriceDto).addObject("count",buyDtos.size()).
				addObject("price",price).addObject("siteName", sb.toString()).addObject("siteSerial", siteSerial).addObject("plist", plist);
			}else{
				QueryResult<OrderDto> queryResult =orderService.orderList(0, 10000, member.getId(), PlatformConstant.TIKIBOX_WEB.getVal(), 0);
				if(queryResult.getResultlist().size()>0){
					
					OrderDto orderDto = queryResult.getResultlist().get(0);
					modelAndView.addObject("ticketDto",ticketDto).
					addObject("ticketPriceDto",ticketPriceDto).addObject("count",buyDtos.size()).
					addObject("price",price).addObject("siteName", sb.toString()).addObject("siteSerial", siteSerial).addObject("plist", plist).addObject("orderDto", orderDto);
					
					String zipCode = orderDto.getZipcode();
					if(StringUtils.isNotEmpty(zipCode)){
						try{
							String[] zipArray = zipCode.split(",");
							String province = AreaService.getProvince(Integer.parseInt(zipArray[0])).getProName();
							String cityName = AreaService.getCity(Integer.parseInt(zipArray[1])).getCityName();
							orderDto.setAddress(orderDto.getAddress().replaceAll(province,"").replaceAll(cityName,""));
							modelAndView.addObject("provinceId", zipArray[0]);
							modelAndView.addObject("cityId", zipArray[1]);
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}else{
					String phone = member.getPhone();
					modelAndView.addObject("ticketDto",ticketDto).
					addObject("ticketPriceDto",ticketPriceDto).addObject("count",buyDtos.size()).
					addObject("price",price).addObject("siteName", sb.toString()).addObject("siteSerial", siteSerial).addObject("plist", plist).addObject("phone", phone);
				}
			}
		}
		
		
		return modelAndView;
	}
	

	
	@RequestMapping("/ticketBuyDo")
	@ResponseBody
	public String buyDo(Integer isIndex,HttpServletRequest request,long ticketId,long priceId,int count ,
			int sendType,String consignee,String detailedAddress,String telephone,int payType,String message,String siteSerial,int provinceId,int cityId){
		
		
		MemberDto member = (MemberDto)request.getSession().getAttribute(BaseAction.MEMBER);
		
		if (member == null) {
			request.getSession().setAttribute("ticketId", ticketId);
			request.getSession().setAttribute("priceId", priceId);
			request.getSession().setAttribute("count", count);
			//
			request.getSession().setAttribute("phone", telephone);
			request.getSession().setAttribute("siteSerial", siteSerial);
			if(isIndex!=null&&isIndex==1){
				return new JSONObject(new RetStatus<String>(11,"未登录","login.html")).toString();
			}else{
				return new JSONObject(new RetStatus<String>(12,"未登录","login.html?returl=ticketDetail.html?ticketId="+ticketId)).toString();
			}
			
		}
		
		SubmitOrderDto submitOrderDto = new SubmitOrderDto();
		submitOrderDto.setPlat(PlatformConstant.TIKIBOX_WEB.getVal());
		submitOrderDto.setMemberId(member.getId());
		submitOrderDto.setMobile(telephone);
		submitOrderDto.setPostscript(message);
		submitOrderDto.setSendType(sendType);
		if(sendType==0){
			String province = AreaService.getProvince(provinceId).getProName();
			String city = AreaService.getCity(cityId).getCityName();
			String zipcode = provinceId+","+cityId; 
			String address = province+city+detailedAddress;
			submitOrderDto.setZipcode(zipcode);
			submitOrderDto.setConsignee(consignee);
			submitOrderDto.setAddress(address);
			submitOrderDto.setSendType(0);
		}
		
		
		
		
		
		
		SubmitGoodsDto submitGoodsDto = new SubmitGoodsDto();
		if(StringUtils.isNotEmpty(siteSerial)){
			List<ToBuyDto> buyDtos = rmiSiteServer.toBuy(siteSerial);
			StringBuffer sb = new StringBuffer();
			
			for(ToBuyDto buyDto : buyDtos){
				sb.append(buyDto.getSeatId());
				sb.append(",");
			}
			
			if(sb.length()>0){
				sb = sb.deleteCharAt(sb.length()-1);
			}
			submitGoodsDto.setSiteIds(sb.toString());
		}
		
		
		submitGoodsDto.setGoodsId(ticketId);
		submitGoodsDto.setPriceId(priceId);
		submitGoodsDto.setGoodsCount(count);
		List<SubmitGoodsDto> goods = new ArrayList<SubmitGoodsDto>();
		goods.add(submitGoodsDto);

		RetStatus<String> ret = orderService.addOrder(submitOrderDto, goods);
		
		//ModelAndView modelAndView = new ModelAndView("ticket/alipaydo");
		//modelAndView.addObject("ret", ret.getRet().getSubmitForm());
		JSONObject json = new JSONObject(ret);
		return json.toString();
	}
	
	
	@RequestMapping("/payDo")
	public ModelAndView payDo(String orderNo){
		
		RetStatus<String> retPost = orderService.buildPayOrderPost(orderNo, configuration.getString("rooturl")+"alipay/return_url.html",0);
		
		return new ModelAndView("ticket/paydo").addObject("ret", retPost);
	}
	@RequestMapping("/getCity")
	@ResponseBody
	public String getCity(int id){
		List<CityDto> cities=AreaService.getCityList(id);
		return new JSONArray(cities).toString();
	}
}
