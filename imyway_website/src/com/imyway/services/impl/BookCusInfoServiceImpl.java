package com.imyway.services.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imyway.mapper.BookCusInfoMapper;
import com.imyway.model.BookCusInfo;
import com.imyway.services.IBookCusInfoService;

@Service
public class BookCusInfoServiceImpl implements IBookCusInfoService {

	@Autowired
	private BookCusInfoMapper bookCusInfoMapper;
	
	@Override
	public void saveBookCusInfo(BookCusInfo bookCusInfo) {
		bookCusInfoMapper.saveBookCusInfo(bookCusInfo);
	}

	@Override
	public void updateBookCusInfo(BookCusInfo bookCusInfo) {
		bookCusInfoMapper.updateBookCusInfo(bookCusInfo);
	}

	@Override
	public void deleteBookCusInfoById(int id) {
		bookCusInfoMapper.deleteBookCusInfoById(id);
	}

	@Override
	public void deleteBookCusInfoByParams(Map<String, Object> param) {
		bookCusInfoMapper.deleteBookCusInfoByParams(param);
		
	}

	@Override
	public int getBabyCount(String orderNo) {
		return bookCusInfoMapper.getBabyCount(orderNo);
	}

	@Override
	public int getChildCount(String orderNo) {
		return bookCusInfoMapper.getChildCount(orderNo);
	}

	@Override
	public int getAdultCount(String orderNo) {
		return bookCusInfoMapper.getAdultCount(orderNo);
	}

}
