package com.fp.shuttlecock.freeboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fp.shuttlecock.comments.CommentsServiceImpl;
import com.fp.shuttlecock.util.LikesVO;
import com.fp.shuttlecock.user.UserServiceImpl;
import com.fp.shuttlecock.util.PageCreate;
import com.fp.shuttlecock.util.PageVO;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequestMapping("/Freeboard")
public class FreeboardController {
	
	@Autowired
	private FreeboardServiceImpl service;
	@Autowired
	private CommentsServiceImpl comService;
	@Autowired
	private UserServiceImpl userService;
	
	// 테스트용 메소드
	@GetMapping("/")
	public void test() {
		System.out.println("화면출력");
	}
	
	
	// 자유게시판 이동
	@GetMapping("/freeList")
	public String getFree(Model model, PageVO vo) {
		System.out.println("자유게시판으로 이동");
		System.out.println("검색어" + vo.getKeyword());
		System.out.println("검색조건" + vo.getCondition());
		
		PageCreate pc = new PageCreate();
		pc.setPaging(vo);
		pc.setArticleTotalCount(service.getTotal(vo));
		
		System.out.println(pc);
		vo.setPagecnt((vo.getPageNum()-1) * vo.getCountPerPage());
		model.addAttribute("freeList", service.getFreeboard(vo));
		model.addAttribute("pc",pc);
		
		return "FreeBoard/freeList";
	}
	
	// 글쓰기 페이지 이동
	@GetMapping("/freeWrite")
	public void freeWrite() {
		System.out.println("글쓰기 페이지로 이동");
	}
	
	// 글 등록
	@PostMapping("/insertFreeboard")
	public String insertFreeboard(FreeboardDTO dto) {
		service.insertFreeboard(dto);
		
		System.out.println("insert 성공");
		return "redirect:/Freeboard/freeList";
	}
	
	// 글 상세 보기
	@GetMapping("/freeDetail")
	public void freeDetail(int freeboardId, String userId, Model model) {
		System.out.println("상세보기 페이지");
		model.addAttribute("Detail", service.freeDetail(freeboardId));
		
		LikesVO likes = new LikesVO();
		
		likes.setFreeboardId(freeboardId);
		likes.setUserId(userId);
		likes.setLikeType(1);
		model.addAttribute("like", service.findLike(freeboardId, userId));
		model.addAttribute("getLike", service.getLike(freeboardId, 1));
		service.hit(freeboardId);
	}
	
	// 좋아요
	@ResponseBody
	@PostMapping("/likeUp")
	public void likeUp(@RequestBody LikesVO vo) {
		System.out.println("controller 연결 성공");
		System.out.println(vo.getFreeboardId());
		System.out.println(vo.getUserId());
		System.out.println(vo.getLikeType());
		service.likeUp(vo.getFreeboardId(), vo.getUserId(), vo.getLikeType());
	}
	
	@ResponseBody
	@PostMapping("/likeDown")
	public void likeDown(@RequestBody LikesVO vo) {
		System.out.println("controller 연결 성공");
		System.out.println(vo.getFreeboardId());
		System.out.println(vo.getUserId());
		System.out.println(vo.getLikeType());
		service.likeUp(vo.getFreeboardId(), vo.getUserId(), vo.getLikeType());
	}
	
	// 글 삭제
	@GetMapping("/deleteFree")
	public String deleteFree(int freeboardId) {
		System.out.println("controller 연결" + freeboardId);
		service.deleteFree(freeboardId);
		return "redirect:/Freeboard/freeList";
	}
	
	// 글 수정 페이지 이동
	@GetMapping("/freeUpdate")
	public void updateFree(int freeboardId, Model model) {
		System.out.println(freeboardId + "번 게시물 수정");
		model.addAttribute("Detail", service.freeDetail(freeboardId));
	}
	
	// 글 수정
	@PostMapping("/updateFree")
	public String updateBoard(FreeboardDTO dto, RedirectAttributes ra) {
		System.out.println("게시물 수정 요청");
		System.out.println(dto.getFreeboardId());
		System.out.println(dto.getContent());
		System.out.println(dto.getTitle());
		
		service.updateFree(dto);
		ra.addFlashAttribute("msg", "updateSuccess");
		
		return "redirect:/Freeboard/freeDetail?freeboardId="+dto.getFreeboardId();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
