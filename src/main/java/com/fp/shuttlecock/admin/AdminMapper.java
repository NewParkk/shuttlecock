package com.fp.shuttlecock.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {

	public List<UserDTO> getAllUserList();

}
