package com.imyway.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.FileUpAndDown;
import com.imyway.common.utils.JSONProxy;
import com.imyway.common.utils.mail.MailSender;
import com.imyway.services.ICommonService;

/**
 * 
 * @author GM
 * www.msdkeji.com
 */
@Controller
@SuppressWarnings({"rawtypes","unchecked"})
public class CommController extends BaseController{

    private static final Logger logger = LoggerFactory.getLogger(CommController.class);
    
    @Autowired
	private ICommonService commonService;
    
    @RequestMapping(value = "/img/uploadFileList")
    public void uploadFileList(HttpServletResponse response, HttpServletRequest request,
    		RedirectAttributes attr, @RequestParam("uploadList") MultipartFile[] fileList) {
    	boolean flg = true;
    	List<String> imgUrlList = new ArrayList(1);
    	for (int i = 0; i < fileList.length; i++) {
    		if(null == checkFile(fileList[i]) || !"Y".equals(checkFile(fileList[i]))){		
    			attr.addFlashAttribute("msg", checkFile(fileList[i]));	
    			flg = false;
    			break;
    		}
    	}
    	if(flg){
    		for (int i = 0; i < fileList.length; i++) {
    			String resString = FileUpAndDown.fileUpload(fileList[i], fileList[i].getOriginalFilename());
    			imgUrlList.add(resString);
    		}
    	}
    	try {
    		response.getWriter().print(JSON.toJSONString(imgUrlList, JSONProxy.SYSTEM_FEATURE));
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
    }
    
	
	private String checkFile(MultipartFile file){
		try{
			String fileName = file.getOriginalFilename();
			String message="Y";
			 if(file == null || file.isEmpty() ){
	            	message="对不起,你上传的文件不存在!!!";
	            }
	            if(!fileName.toLowerCase().endsWith(".jpg")
	            		&&!fileName.toLowerCase().endsWith(".png")
	            		&&!fileName.toLowerCase().endsWith(".jpeg")
	            		){
	                message="对不起,你上传的文件格式不允许!!!";
	            }  
	            if(file.getSize()>1048576)
	            {   
	            	 message="上传图片超过最大上传大小1M,请调整后重新上传。"; 
	            }
	            return message;
		}catch(Exception e){
			logger.error(e.toString());
			return "操作失败！ 原因："+e.toString();
		}
	}
	
	@RequestMapping(value = "/autoCompleteList")
	public void autoCompleteList(HttpServletResponse response, HttpServletRequest request,String tblnm,String colnm) {
		List<String> retList = new ArrayList(1);
		retList = commonService.getAutoCompleteList(tblnm, colnm);
		
		try {
            response.getWriter().print(JSON.toJSONString(retList, JSONProxy.SYSTEM_FEATURE));
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	@RequestMapping(value = "/job")
    public ModelAndView tojob(HttpServletResponse response, HttpServletRequest request) {
        return new ModelAndView("job");
    }
	
	@RequestMapping(value = "/aboutUs")
    public ModelAndView aboutUs(HttpServletResponse response, HttpServletRequest request) {
        return new ModelAndView("aboutUs");
    }
	
	@RequestMapping(value = "/myCustom")
    public ModelAndView myCustom(HttpServletResponse response, HttpServletRequest request) {
        return new ModelAndView("myCustom");
    }
	
	@RequestMapping(value = "/sendRequestMail")
	public void sendRequestMail(HttpServletResponse response, HttpServletRequest request,
			String targetCity,String goDate,String contract, String days,String personCount){
		try {
//			if(targetCity==null || "".equals(targetCity)){
//				 response.getWriter().print("N");
//				 return;
//			}else if(contract==null || "".equals(contract)){
//				 response.getWriter().print("N");
//				 return;
//			}
//			String code = "";
//			code += "<p>目的地城市："+targetCity+"</p>";
//			code += "<p>出发日期："+goDate+"</p>";
//			code += "<p>联系方式："+contract+"</p>";
//			code += "<p>天数："+days+"</p>";
//			code += "<p>人数："+personCount+"</p>";
//			if(MailSender.send_custom_mail(code)){
//				response.getWriter().print("Y");
//			}else{
//				response.getWriter().print("N");
//			}
			response.getWriter().print("Y");
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
}
