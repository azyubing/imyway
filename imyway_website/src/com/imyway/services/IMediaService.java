package com.imyway.services;

import java.util.List;

import com.imyway.model.Media;
import com.imyway.services.base.BaseService;

public interface IMediaService extends BaseService {

	Media mediaDetail(Integer vid);

	List morePackage(List mediatags);

}
