package com.fp.shuttlecock.admin;

import java.util.List;

import com.fp.shuttlecock.user.UserDTO;

public interface AdminService {
	
	List<UserDTO> getAllUserList();
	
	UserDTO getUserByUserId(String userId);
	
	boolean updateUserAdmin(UserDTO user);
	
//	List<VisitorDTO> todayVisit();

	boolean deleteUser(String userId);

	int countSearchedUsers(PageRequestDTO pageRequest);

	List<UserDTO> getSearchedUsers(PageRequestDTO pageRequest);

	List<UserDTO> getUserBySearchWithPage(PageRequestDTO pageRequest);

	int getTotalCount(PageRequestDTO pageRequest);
	
	UserDTO getMypage(String userId);
}
