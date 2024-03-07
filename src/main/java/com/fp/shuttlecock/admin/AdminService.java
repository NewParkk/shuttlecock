package com.fp.shuttlecock.admin;

import java.util.List;

public interface AdminService {
	
	List<UserDTO> getAllUserList();
	
	UserDTO getUserByUserId(String userId);
	
	boolean updateUserAdmin(UserDTO user);
	
	List<VisitorDTO> todayVisit();
}
