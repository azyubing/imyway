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

import com.imyway.mobile.constants.Constants;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath*:/applicationContext.xml", "classpath*:/spring-servlet.xml" })
public class ProductControllerTest {
	@Autowired
	private ProductController product;

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
	public void testGetAllThemes() {
		product.getAllThemes(request, response);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetRecommendedThemeProducts() {
		product.getRecommendedThemeProducts(request, response);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetProducts() {
		product.getProducts(request, response, Constants.HotDesintations, Constants.AllServices, Constants.TopAttention, 0, 2);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetHotServices() {
		product.getHotServices(request, response, 0, 2);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetProductSearchOptions() {
		product.getProductSearchOptions(request, response);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetProductDetail() {
		product.getProductDetail(request, response, "P0000000000000000041");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetProductRouteDayInfo() {
		product.getProductRouteInfo(request, response, "P0000000000000000442");
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Test
	public void testGetProductComments() {
		product.getProductComments(request, response, "P0000000000000000047", 0, 20);
		try {
			System.out.println(response.getContentAsString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
