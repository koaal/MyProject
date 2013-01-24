package com.abc.myproject.common;

import junit.framework.Assert;

import org.junit.Test;

public class AESUtilsTest {

	@Test
	public void test() throws Exception {
		String seed = "test seed";
		String cleartext = "10000";
		String s1 = AESUtils.encrypt(seed, cleartext);
		String s2 = AESUtils.decrypt(seed, s1);
		Assert.assertEquals(cleartext, s2);
	}
}
