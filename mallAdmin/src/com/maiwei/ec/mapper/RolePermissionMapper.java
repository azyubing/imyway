package com.maiwei.ec.mapper;

import java.util.List;

import com.maiwei.ec.model.RolePermission;

public interface RolePermissionMapper {
	public void saveRolePermission(RolePermission rolePermission);
	public void deleteRolePermission(String roleId);
	public List<RolePermission> getRolePermissionList(String roleId);
}
