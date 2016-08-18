package com.imyway.mobile.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.FileUpAndDown;
import com.imyway.common.utils.JSONProxy;
import com.imyway.mobile.constants.Constants;
import com.imyway.mobile.utils.Utils;
import com.imyway.services.ICommonService;

@Controller
public class CommonController {
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	@Autowired
	private ICommonService commonService;

	@RequestMapping(value = "/img/uploadFile")
	public void uploadFileList(HttpServletResponse response, HttpServletRequest request, RedirectAttributes attr,
			@RequestParam("uploadList") MultipartFile[] fileList) {
		boolean flg = true;
		List<String> imgUrlList = new ArrayList(1);
		for (int i = 0; i < fileList.length; i++) {
			if (null == checkFile(fileList[i]) || !"Y".equals(checkFile(fileList[i]))) {
				attr.addFlashAttribute("msg", checkFile(fileList[i]));
				flg = false;
				break;
			}
		}
		if (flg) {
			for (int i = 0; i < fileList.length; i++) {
				String resString = FileUpAndDown.fileUpload(fileList[i], fileList[i].getOriginalFilename());
				imgUrlList.add(resString);
			}
		}
		try {
			response.addHeader("Access-Control-Allow-Origin", "*");
			response.getWriter().print(Utils.getReturnedData(Constants.SUCCESS, imgUrlList, null));
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
	}

	private String checkFile(MultipartFile file) {
		try {
			String fileName = file.getOriginalFilename();
			String message = "Y";
			if (file == null || file.isEmpty()) {
				message = "对不起,你上传的文件不存在!!!";
			}
			if (!fileName.toLowerCase().endsWith(".jpg") && !fileName.toLowerCase().endsWith(".png")
					&& !fileName.toLowerCase().endsWith(".jpeg")) {
				message = "对不起,你上传的文件格式不允许!!!";
			}
			if (file.getSize() > 1048576) {
				message = "上传图片超过最大上传大小1M,请调整后重新上传。";
			}
			return message;
		} catch (Exception e) {
			logger.error(e.toString());
			return "操作失败！ 原因：" + e.toString();
		}
	}
}
