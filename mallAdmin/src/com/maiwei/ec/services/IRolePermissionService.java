package com.maiwei.ec.services;

import java.util.List;

import com.maiwei.ec.model.RolePermission;

public interface IRolePermissionService {
	public void saveRolePermission(List<RolePermission> rolePermissionList);
	public List<RolePermission> getRolePermissionList(String roleId);
}
