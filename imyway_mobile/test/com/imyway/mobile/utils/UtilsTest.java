package com.imyway.mobile.utils;

import org.junit.Test;

import com.imyway.common.utils.CommonUtils;
import com.imyway.mobile.constants.Constants;

import junit.framework.Assert;

public class UtilsTest {

	@Test
	public void testIsValid() {
		Assert.assertEquals(true, Utils.isValid("13904114356", Constants.phoneNumberPattern, false));
	}
	
	@Test
	public void testIsNotValid() {
		Assert.assertEquals(true, Utils.isValid("11104114356", Constants.phoneNumberPattern, false));
	}

	@Test
	public void testPassword() {
		System.out.println(CommonUtils.covertpw("123"));
	}
}
