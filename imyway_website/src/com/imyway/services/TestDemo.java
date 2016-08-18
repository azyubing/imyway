package com.imyway.services;

import com.imyway.services.base.IBaseInfoService;

public interface TestDemo<T> extends IBaseInfoService<T> {

    boolean getCountType(T t);
    
}
