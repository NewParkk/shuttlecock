package com.fp.shuttlecock.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fp.shuttlecock.user.UserDTO;

@Service
public class AdminServiceImpl {

	@Autowired
	private AdminMapper mapper;
	
	public List<UserDTO> getAllUserList(){
		return mapper.getAllUserList(); 
	}

	public UserDTO getUserByUserId(String userId) {
		return mapper.getUserByUserId(userId);
	}
	
	public boolean deleteUser(String userId) {
		int result = mapper.deleteUser(userId);
		if (result == 1) {
			return true;
		}
		return false;
	}

	
	public boolean updateUserAdmin(UserDTO user) {
		boolean result = false;
		int res = mapper.updateUserAdmin(user);
		if(res != 0) {
			result = true;
		}
		return result;
	}

//	public List<VisitorDTO> todayVisit() {
//		return mapper.todayVisit();
//	}

	public int countSearchedUsers(PageRequestDTO pageRequest) {
		return mapper.countSearchedUsers(pageRequest);
	}

	public List<UserDTO> getSearchedUsers(PageRequestDTO pageRequest) {
		return mapper.getSearchedUsers(pageRequest);
	}

	public List<UserDTO> getUserBySearchWithPage(PageRequestDTO pageRequest) {
		return mapper.getUserBySearchWithPage(pageRequest);
	}

	public int getTotalCount(PageRequestDTO pageRequest) {
		return mapper.getTotalCount(pageRequest);
	}

	public UserDTO getMypage(String userId) {
		return mapper.getMypage(userId);
	}



}
