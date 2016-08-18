package com.imyway.mobile.controller;

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
public class DestinationControllerTest {
	@Autowired
	private DestinationController destination;
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
	public void testGetHotDesinations() {
		try {
			destination.getHotDesinations(response, request, 0, 100);
			System.out.println(response.getContentAsString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testGetDesinations() {
		try {
			destination.getDestinations(response, request, null, 0, 5);
			System.out.println(response.getContentAsString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
