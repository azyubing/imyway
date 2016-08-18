package com.imyway.services;

import java.util.List;

import com.imyway.model.RolePermission;

public interface IRolePermissionService {
	public void saveRolePermission(List<RolePermission> rolePermissionList);
	public List<RolePermission> getRolePermissionList(String roleId);
}
