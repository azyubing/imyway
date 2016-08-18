package com.imyway.mobile.controller;

import static org.junit.Assert.fail;

import java.io.UnsupportedEncodingException;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:/applicationContext.xml", "classpath*:/spring-servlet.xml" })
public class PriceControllerTest {
	@Autowired
	private PriceController price;

	private MockHttpServletRequest request;
	private MockHttpServletResponse response;

	@Before
	public void setup() {
		request = new MockHttpServletRequest();
		request.setCharacterEncoding("UTF-8");
		response = new MockHttpServletResponse();
		response.setCharacterEncoding("UTF-8");
	}

	@Test
	public void testGetHotelPriceCalendar() {
		price.getHotelPriceCalendar(request, response, "P0000000000000000583", "2016-07-01");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetPackagePriceCalendar() {
		price.getPackagePriceCalendar(request, response, "P0000000000000000424", "2016-08-01");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetVillaPriceCalendar() {
		price.getVillaPriceCalendar(request, response, "P0000000000000000048", "2016-07-01");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetEntertainmentPriceCalendar() {
		price.getEntertainmentPriceCalendar(request, response, "P0000000000000000552", "2016-07-01");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetVillaPriceDetail() {
		price.getVillaPriceDetail(request, response, "P0000000000000000051", "2016-08-15");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
