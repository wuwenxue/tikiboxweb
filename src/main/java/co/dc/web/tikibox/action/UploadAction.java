package co.dc.web.tikibox.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.dc.commons.upyun.UpYun;

@Controller
public class UploadAction {

	@Resource
	private UpYun upyun;

	// 上传首页图片 http://v0.api.upyun.com/jsdfss
	@ResponseBody
	@RequestMapping("/upload")
	public String upload(@RequestParam(value = "file", required = false) MultipartFile file) {
		try {

			boolean flag = upyun.uploadFile(file.getOriginalFilename(),
					file.getBytes());
			
			if(flag){
				String path = upyun.getPath();
				return "{\"status\":0,\"path\":\""+path+"\"}";
			}else{
				return "{'status':1}";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "{'status':-1}";
		}

	}

}
