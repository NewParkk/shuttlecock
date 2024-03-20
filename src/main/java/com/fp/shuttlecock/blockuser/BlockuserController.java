package com.fp.shuttlecock.blockuser;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fp.shuttlecock.tradeboard.PageRequestDTO;

import jakarta.servlet.http.HttpSession;


@Controller
public class BlockuserController {
	@Autowired
	BlockuserServiceImpl blockuserService;
	
	@PostMapping("/blockuser")
	public ResponseEntity<String> insertBlockuser(BlockuserDTO blockuser) {
		blockuserService.insertBlockuser(blockuser);
		return ResponseEntity.ok(blockuser.getBlockedUser() + "님이 차단되었습니다."); 
	}
	
	@PostMapping("/unblockuser")
	public ResponseEntity<String> deleteBlockuser(@ModelAttribute BlockuserDTO blockuser){
		System.out.println(blockuser.toString());
		blockuserService.deleteBlockuser(blockuser);
		return ResponseEntity.ok(blockuser.getBlockedUser() + "님이 차단해제되었습니다."); 
	}
	
	@GetMapping("/manageBlockedUser")
	public String getMethodName(PageRequestDTO pagerequest, HttpSession session, Model model) {
		String view = "error";
		if(session.getAttribute("userId") != null) {
			
			List<BlockuserDTO> blockeduserList = blockuserService.getBlockedUserList(pagerequest);
			model.addAttribute("blockeduserList", blockeduserList);
			view = "/mypage/manageBlockedUser";
		}
		return view;
	}
	
}
