package co.dc.web.tikibox.action;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.dc.commons.dto.RetStatus;
import co.dc.server.order.rmi.RmiOrderService;


@Controller
public class PayReturnAction {
	
	@Resource
	private RmiOrderService rmiOrderService;
	/**
	 * 支付宝回调
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws Exception
	 */
	@RequestMapping("/alipay/return_url")
	public ModelAndView returnUrl(HttpServletRequest request) throws UnsupportedEncodingException, Exception{
		
		
		
		ModelAndView modelAndView = new ModelAndView("ticket/payok");
		
		//获取支付宝GET过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}
		
		RetStatus<String> ret =  rmiOrderService.payUrlReturn(0, params);
		
		
		
		return modelAndView.addObject("ret",ret);
	}
	
	
	

}
