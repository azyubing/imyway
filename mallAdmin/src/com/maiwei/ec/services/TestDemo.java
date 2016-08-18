package com.maiwei.ec.services;

import com.maiwei.ec.services.base.IBaseInfoService;

public interface TestDemo<T> extends IBaseInfoService<T> {

    boolean getCountType(T t);
    
}
