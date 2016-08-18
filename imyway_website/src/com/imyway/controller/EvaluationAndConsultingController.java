package com.imyway.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.imyway.common.utils.JSONProxy;
import com.imyway.model.Evaluation;
import com.imyway.services.IEvaluationService;


@Controller
public class EvaluationAndConsultingController extends BaseController{
	 private static final Logger logger = LoggerFactory.getLogger(EvaluationAndConsultingController.class);
	@Autowired
	private IEvaluationService evaluationService;
    /**
     * 评论列表
     * @param response
     * @param request
     * @param offset
     * @param limit
     */
	@RequestMapping(value = "/evaluation/evaluationList")
    public void evaluationList(HttpServletResponse response, HttpServletRequest request, String pid) {
        try {
        	 List<Evaluation> evaluationList = evaluationService.getEvaluationListByPid(pid);
            response.getWriter().print(JSON.toJSONString(evaluationList, JSONProxy.SYSTEM_FEATURE));

        } catch (Exception e) {
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("evaluationList fail. " + e.toString());
        }
    }
	 /**
     * 新增or修改评论
     * @param response
     * @param request
     * @param menu
     * @return
     */
    @RequestMapping(value = "/evaluation/addEvaluation")
    public void addEvaluation(HttpServletResponse response, HttpServletRequest request,@ModelAttribute("evaluation") Evaluation evaluation) {
        try {
        	if(evaluation.getId()==0){
        		evaluation.setCtdt(new Date());
        		evaluationService.insert(evaluation);
        	}
        	response.getWriter().print("success");
        } catch (Exception e) {
            e.printStackTrace();
            if (null != e.getMessage()) {
                System.out.println(e.toString());
            }
            logger.info("addEvaluation fail. " + e.toString());
        }
    }
    
   
    
}
