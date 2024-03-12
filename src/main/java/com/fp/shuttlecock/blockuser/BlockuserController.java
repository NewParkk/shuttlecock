package com.fp.shuttlecock.blockuser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class BlockuserController {
	@Autowired
	BlockuserServiceImpl blockuserService;
	
	@PostMapping("/blockuser")
	public ResponseEntity<String> insertBlockuser(BlockuserDTO blockuser) {
		blockuserService.insertBlockuser(blockuser);
		return ResponseEntity.ok(blockuser.getBlockedUser() + "님이 차단되었습니다."); 
	}
	
	@GetMapping("/unblockuser")
	public ResponseEntity<String> deleteBlockuser(BlockuserDTO blockuser){
		blockuserService.deleteBlockuser(blockuser);
		return ResponseEntity.ok(blockuser.getBlockedUser() + "님이 차단해제되었습니다."); 
	}
}
