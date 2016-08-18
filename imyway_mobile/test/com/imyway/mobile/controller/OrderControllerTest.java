package com.imyway.mobile.controller;

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
public class OrderControllerTest {
	@Autowired
	private OrderController order;
	@Autowired
	private CustomerController customer;

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
	public void testGetOrdersSearchOptions() {
		order.getOrderSearchOptions(request, response);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetMyOrders() {
		customer.login(request, response, "junking1983", "123");
		order.getMyOrders(response, request, "1", null, null, null, 0, 5);
		try {
			String result = response.getContentAsString();
			System.out.println(result);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
