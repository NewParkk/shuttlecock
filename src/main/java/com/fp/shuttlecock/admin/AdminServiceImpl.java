package com.fp.shuttlecock.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.admin.PageRequestDTO;

@Service
public class AdminServiceImpl {

	@Autowired
	AdminMapper mapper;
	
	public List<UserDTO> getAllUserList(){
		return mapper.getAllUserList(); 
	}

	public UserDTO getUserByUserId(String userId) {
		return mapper.getUserByUserId(userId);
	}

	public boolean updateUserAdmin(UserDTO user) {
		boolean result = false;
		int res = mapper.updateUserAdmin(user);
		if(res != 0) {
			result = true;
		}
		return result;
	}

	public List<VisitorDTO> todayVisit() {
		return mapper.todayVisit();
	}

	public int countSearchedUsers(PageRequestDTO pageRequest) {
		return mapper.countSearchedUsers(pageRequest);
	}

	public List<UserDTO> getSearchedUsers(PageRequestDTO pageRequest) {
		return mapper.getSearchedUsers(pageRequest);
	}



}
