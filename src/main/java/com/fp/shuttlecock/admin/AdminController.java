package com.fp.shuttlecock.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;



@Controller
public class AdminController {
	
	@Autowired
	AdminService service;
	
	@GetMapping("/admin")
	public String getAllUserList(Model model) {
		List<UserDTO> userList = service.getAllUserList();
		model.addAttribute("userList", userList);
		
		return "admin/adminPage";
	}
	
	@GetMapping("/admin/{userId}")
	public String getUserByUserId(@PathVariable String userId, Model model) {
		UserDTO user = service.getUserByUserId();
		model.addAttribute("user" ,user);
		
		return "";
	}
	
}
