package com.fp.shuttlecock.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fp.shuttlecock.user.UserDTO;

@Mapper
public interface AdminMapper {

	public List<UserDTO> getAllUserList();

	public UserDTO getUserByUserId(String userId);

	public int updateUserAdmin(UserDTO user);

//	public List<VisitorDTO> todayVisit();

	public int countSearchedUsers(PageRequestDTO pageRequest);

	public List<UserDTO> getSearchedUsers(PageRequestDTO pageRequest);

	public List<UserDTO> getUserBySearchWithPage(PageRequestDTO pageRequest);

	public int getTotalCount(PageRequestDTO pageRequest);

	public UserDTO getMypage(String userId);
	
	public int deleteUser(String userId);

}
