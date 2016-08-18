package com.maiwei.ec.service;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.maiwei.ec.model.PermissionInfo;
import com.maiwei.ec.service.base.BaseServiceTest;
import com.maiwei.ec.services.IPermissionInfoService;
import com.maiwei.ec.vo.PermissionInfoVO;

public class PermissionInfoServiceTest extends BaseServiceTest {
	@Autowired
	private IPermissionInfoService permissionInfoService;
	
	@Test
	public void saveTest(){
//		PermissionInfo permissionInfo = new PermissionInfo();
//		permissionInfo.setPermissionName("后台用户列表");
//		permissionInfo.setPermissionStatus(1);
//		permissionInfo.setPermissionUrl("<%=basePath%>user/userAdmin.html");
//		permissionInfo.setParentPid("P00000000007");
//		permissionInfo.setPermissionGroupOrder(8);
//		permissionInfo.setCtdt(new Date());
//		permissionInfo.setCtuser(0+"");
//		permissionInfo.setNeedCheck(0);
//		permissionInfoService.savePermissionInfo(permissionInfo);
//		
//		PermissionInfo permissionInfo1 = new PermissionInfo();
//		permissionInfo1.setPermissionName("角色列表");
//		permissionInfo1.setPermissionStatus(1);
//		permissionInfo1.setPermissionUrl("<%=basePath%>role/roleAdmin.html");
//		permissionInfo1.setParentPid("P00000000007");
//		permissionInfo1.setPermissionGroupOrder(8);
//		permissionInfo1.setCtdt(new Date());
//		permissionInfo1.setCtuser(0+"");
//		permissionInfo1.setNeedCheck(0);
//		permissionInfoService.savePermissionInfo(permissionInfo1);
//		
//		PermissionInfo permissionInfo2 = new PermissionInfo();
//		permissionInfo2.setPermissionName("城市管理");
//		permissionInfo2.setPermissionStatus(1);
//		permissionInfo2.setPermissionUrl("<%=basePath%>city/cityAdmin.html");
//		permissionInfo2.setParentPid("P00000000007");
//		permissionInfo2.setPermissionGroupOrder(8);
//		permissionInfo2.setCtdt(new Date());
//		permissionInfo2.setCtuser(0+"");
//		permissionInfo2.setNeedCheck(0);
//		permissionInfoService.savePermissionInfo(permissionInfo2);
	}
	
	@Test
	public void getTwoMenuTest(){
		List<PermissionInfoVO> list =  permissionInfoService.getTwoMenu();
		System.out.println(list);
		
	}
}
