package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.BaseMapper;
import com.imyway.model.Evaluation;

public interface EvaluationMapper extends BaseMapper {

	List<Evaluation> getEvaluationListByPid(Map params);

	int getEvaluationCountByPid(String pid);
	
}
