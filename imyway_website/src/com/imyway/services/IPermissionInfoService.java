package com.imyway.services;

import java.util.List;

import com.imyway.model.PermissionInfo;
import com.imyway.vo.PermissionInfoVO;

public interface IPermissionInfoService {
	/**
	 * 新增
	 * @param PermissionInfo
	 */
	public void savePermissionInfo(PermissionInfo permissionInfo);
	
	/**
	 * 获取两级的菜单
	 * @return
	 */
	public List<PermissionInfoVO> getTwoMenu();
	
	/**
	 * 用户拥有的权限
	 * @param lid
	 * @return
	 */
	public List<PermissionInfoVO> loginRolePermission(int lid,String roleId);
}
