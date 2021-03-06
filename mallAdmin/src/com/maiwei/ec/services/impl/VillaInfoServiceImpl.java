package com.maiwei.ec.services.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maiwei.ec.mapper.ProductInfoMapper;
import com.maiwei.ec.mapper.VillaInfoMapper;
import com.maiwei.ec.model.VillaInfo;
import com.maiwei.ec.services.IVillaInfoService;

@Service
public class VillaInfoServiceImpl implements IVillaInfoService {

    @Autowired private VillaInfoMapper villaInfoMapper;
    @Autowired private ProductInfoMapper productInfoMapper;
    
    @Override
    public int getCount(Map<String, Object> param) {
        int i = 0;
        try{
            i = villaInfoMapper.getCount(param);
        }catch(Exception e){
            logger.error("login fail."+this.getClass()+".getCount:" + e.toString());
        }
        return i;
    }

    @Override
    public boolean deleteByPrimaryKey(VillaInfo t) throws Exception {
        int i = 0;
        i = villaInfoMapper.deleteByPrimaryKey(t);    
        i = productInfoMapper.deleteByPrimaryKey(t); 
        if(i == 1){
            return true;
        }else{
            throw new Exception("login fail."+this.getClass()+".deleteByPrimaryKey:"+i);
        }
    }

    @Override
    public boolean insert(VillaInfo t) throws Exception {
        int i = 0;
        i = productInfoMapper.insert(t);
        i = villaInfoMapper.insert(t);    
        if(i == 1){
            return true;
        }else{
            throw new Exception("login fail."+this.getClass()+".insert:"+i);
        }
    }

    @Override
    public boolean insertSelective(VillaInfo t) throws Exception {
        int i = 0;
        i = productInfoMapper.insertSelective(t); 
        i = villaInfoMapper.insertSelective(t);    
        if(i == 1){
            return true;
        }else{
            throw new Exception("login fail."+this.getClass()+".insertSelective:"+i);
        }
    }

    @Override
    public boolean updateByPrimaryKeySelective(VillaInfo t) throws Exception {
        int i = 0;
        i = productInfoMapper.updateByPrimaryKeySelective(t); 
        i = villaInfoMapper.updateByPrimaryKeySelective(t);
        if(i == 1){
            return true;
        }else{
            throw new Exception("login fail."+this.getClass()+".updateByPrimaryKeySelective:"+i);
        }
    }

    @Override
    public boolean updateByPrimaryKey(VillaInfo t) throws Exception {
        int i = 0;
        i = productInfoMapper.updateByPrimaryKey(t);
        i = villaInfoMapper.updateByPrimaryKey(t);
        if(i == 1){
            return true;
        }else{
            throw new Exception("login fail."+this.getClass()+".updateByPrimaryKey:"+i);
        }
    }

    @Override
    public VillaInfo selectByPrimaryKey(VillaInfo t) {
        VillaInfo info = null;
        try{
            info = villaInfoMapper.selectByPrimaryKey(t);
        }catch(Exception e){
            logger.error("login fail."+this.getClass()+".selectByPrimaryKey:" + e.toString());
        }
        return info;
    }

    @Override
    public List<VillaInfo> selectAllListByParam(Map<String, Object> param) {
        List<VillaInfo> list = null;
        try{
            list = villaInfoMapper.selectAllListByParam(param);
        }catch(Exception e){
            logger.error("login fail."+this.getClass()+".selectAllListByParam:" + e.toString());
        }
        return list;
    }

    @Override
    public VillaInfo selectVillaInfoByParam(Map<String, Object> param) {
        VillaInfo info = null;
        try{
            info = villaInfoMapper.selectVillaInfoByParam(param);
        }catch(Exception e){
            logger.error("login fail."+this.getClass()+".selectVillaInfoByParam:" + e.toString());
        }
        return info;
    }
    
    private static final Logger logger = LoggerFactory.getLogger(VillaInfoServiceImpl.class);

}
