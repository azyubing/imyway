package com.imyway.services;

import java.util.List;

import com.imyway.model.Evaluation;
import com.imyway.services.base.BaseService;

public interface IEvaluationService extends BaseService {
	public List<Evaluation> getEvaluationListByPid(String pid);
}
