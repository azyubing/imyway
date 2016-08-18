package com.imyway.services;

import java.util.List;
import java.util.Map;

import com.imyway.model.Evaluation;
import com.imyway.services.base.BaseService;

public interface IEvaluationService extends BaseService {
	public List<Evaluation> getEvaluationListByPid(Map params);

	public int getEvaluationCountByPid(String pid);
}
