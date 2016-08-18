package com.maiwei.ec.service.base;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * service  junit test base
 * @author hyh
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/applicationContext.xml",
		"file:src/spring-servlet.xml", "file:src/sqlMapConfig.xml" })
public class BaseServiceTest extends AbstractJUnit4SpringContextTests {

}
