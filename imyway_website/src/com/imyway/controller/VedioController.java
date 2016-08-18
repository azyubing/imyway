package com.imyway.controller;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.imyway.common.utils.CommonUtils;
import com.imyway.common.utils.mail.MailSender;
import com.imyway.model.Media;
import com.imyway.services.IDiscountInfoService;
import com.imyway.services.IMediaService;
import com.imyway.services.IPackageInfoService;
import com.imyway.services.IThemeProductService;
import com.imyway.services.IThemeService;
import com.imyway.services.IVillaInfoService;
import com.imyway.sms.SmsClientSend;



/**
 * 
 * @author GM
 * 
 */
@Controller
public class VedioController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(VedioController.class);
    
    @Autowired private IMediaService mediaService;
    
    @RequestMapping(value = "/vedioDetail")
    public ModelAndView vedioDetail(Integer vid,
            HttpServletResponse response, HttpServletRequest request) {
        try {
        	if(null == vid || vid == 0){
        		
        	}else{
        		Media media = (Media) mediaService.mediaDetail(vid);
        		
        		//List morePackage = mediaService.morePackage(media.getMediatags());
        		request.setAttribute("media", media);
        		//request.setAttribute("morePackage", morePackage);
        	}
        } catch (Exception e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("vedioDetail fail. " + e.toString());
        }
        return new ModelAndView("/vedioDetail");
    }
   
}
