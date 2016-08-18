package com.imyway.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.imyway.mapper.RolePermissionMapper;
import com.imyway.model.RolePermission;
import com.imyway.services.IRolePermissionService;

@Service
public class RolePermissionServiceImpl implements IRolePermissionService {

	@Autowired
	private RolePermissionMapper rolePermissionMapper;
	@Override
	public void saveRolePermission(List<RolePermission> rolePermissionList) {
		rolePermissionMapper.deleteRolePermission(rolePermissionList.get(0).getRoleId());
		for(RolePermission r:rolePermissionList){
			rolePermissionMapper.saveRolePermission(r);
		}
	}
	@Override
	public List<RolePermission> getRolePermissionList(String roleId) {
		return rolePermissionMapper.getRolePermissionList(roleId);
	}

}
