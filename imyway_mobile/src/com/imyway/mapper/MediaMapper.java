package com.imyway.mapper;

import java.util.List;
import java.util.Map;

import com.imyway.mapper.base.BaseMapper;

public interface MediaMapper extends BaseMapper {

	List getMediaTags(Integer vid);

	List getMediaSimilars(Integer vid);

	List morePackage(Map param);

}
