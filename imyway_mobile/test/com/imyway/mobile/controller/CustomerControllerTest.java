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
public class CustomerControllerTest {
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
	public void testLoginSuccess() {
		try {
			customer.login(request, response, "junking1983", "123");
			System.out.println(response.getContentAsString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testLoginFailed() {
		try {
			customer.login(request, response, "junking1983", "1234");
			System.out.println(response.getContentAsString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdateUserName() {
		customer.login(request, response, "junking1983", "123");
		customer.updateUserName(request, response, "Gordon", null, null);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testUpdateCellPhoneNumber() {
		customer.login(request, response, "junking1983", "123");
		customer.updateCellPhoneNumber(request, response, "18842899841", "test");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testPassword() {
		customer.login(request, response, "junking1983", "123");
		customer.updatePassword(request, response, "456");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testRegister() {
		fail("Not yet implemented");
	}

	@Test
	public void testMyFavorites() {
		// customer.login(request, response, "junking1983", "123");
		customer.getMyFavorites(request, response, null, null, null, 2, 3);
		try {
			String result = response.getContentAsString();
			System.out.println(result);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}