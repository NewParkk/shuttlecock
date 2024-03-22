package com.fp.shuttlecock.freeboard;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fp.shuttlecock.attachmentfile.NaverObjectStorage;
import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.comments.CommentsServiceImpl;
import com.fp.shuttlecock.likes.LikesDTO;
import com.fp.shuttlecock.recruitboard.RecruitboardDTO;
import com.fp.shuttlecock.recruitboard.RecruitboardServiceImpl;
import com.fp.shuttlecock.tradeboard.PageRequestDTO;
import com.fp.shuttlecock.tradeboard.PageResponseDTO;
import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.tradeboard.TradeboardServiceImpl;
import com.fp.shuttlecock.user.UserServiceImpl;
import com.fp.shuttlecock.util.PageCreate;
import com.fp.shuttlecock.util.PageVO;
import com.google.gson.JsonObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequiredArgsConstructor
@RequestMapping("/Freeboard")
public class FreeboardController {

	@Autowired
	private FreeboardServiceImpl service;
	@Autowired
	private CommentsServiceImpl commentService;
	@Autowired
	private NaverObjectStorage naverfile;
	@Autowired
	private UserServiceImpl userService;
	@Autowired
	private TradeboardServiceImpl badgeService;

	@GetMapping("/freeDetail/{freeboardId}")
	public String getBoardByBoardId(@PathVariable int freeboardId, Model model) {
		String view = "error";
		System.out.println("controller이동");
		System.out.println(freeboardId);

		FreeboardDTO freeboard = null;
		try {
			freeboard = service.getFreePostByFreeboardId(freeboardId);
			int badgeId = userService.getUserByUserId(freeboard.getUserId()).getBadgeId(); 
			String badgeName = badgeService.getBadgeNameById(badgeId);
//			model.addAttribute("pageInfo", pageRequest);
			if (freeboard != null) {
				List<CommentsDTO> commentList = commentService.getCommentList(freeboardId, 2);
				// FileRequest file = fileService.getBoardFileByTradeboardId(tradeboardId);
				service.hit(freeboardId);

				// model.addAttribute("file", file);
				model.addAttribute("freeboard", freeboard);
				model.addAttribute("commentList", commentList);
				System.out.println(commentList);
				model.addAttribute("badgeName", badgeName);
				view = "Freeboard/freeDetail";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	@GetMapping("/freeList")
	public String getFree(Model model, PageVO vo, HttpSession session) {
		if (session.getAttribute("userId") != null) {
			vo.setUserId(String.valueOf(session.getAttribute("userId")));
		}
		vo.setCountPerPage(10);
		System.out.println(vo);
		List<FreeboardDTO> freeboardList = service.getFreeboard(vo);
		int totalCount = service.getTotal(vo);
		PageCreate pageResponse = new PageCreate().builder().total(totalCount).pageAmount(vo.getCountPerPage()).vo(vo)
				.build();
		model.addAttribute("freeList", freeboardList);
		model.addAttribute("pageInfo", pageResponse);

		return "Freeboard/freeList";
	}

	// 글쓰기 페이지 이동
	@GetMapping("/freeWrite")
	public void freeWrite() {
		FreeboardDTO dto = new FreeboardDTO();
		dto.setUserId("1234"); // 임의로 userId 지정
		System.out.println("글쓰기 페이지로 이동");
	}

	@PostMapping("/insertFreeboard")
	public String insertFreeboard(FreeboardDTO dto, @RequestParam("file") MultipartFile file) {
		System.out.println("controller이동");
		String view = "error";
		boolean boardResult = false;
		try {
			if (!file.isEmpty()) { // 파일이 전송되었는지 확인

				String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				dto.setImageName(fileName);
				System.out.println(fileName);
				// 파일 처리 로직 추가
				// 예를 들어, 파일을 저장하거나 외부 서비스에 업로드하는 코드를 추가합니다.
				// 여기에서는 NaverObjectStorage를 사용하여 파일을 업로드하는 코드를 사용했다고 가정합니다.
				naverfile.ncpFileupload(file, fileName, 2);
			} else {
				System.out.println("파일이 전송되지 않았습니다.");
				// 파일이 전송되지 않은 경우에 대한 처리
			}

			boardResult = service.insertFreeboard(dto);
			if (boardResult) {
				service.increaseWriteCount(dto.getUserId());
				view = "redirect:/Freeboard/freeList";

				// 파일 업로드 후에 파일 삭제 메소드를 호출하여 파일을 삭제합니다.
//			    if (dto.getImageName() != null && dto.getImageName().equals("noImage")) {
//			        deleteFile(dto); // 파일 삭제 메소드 호출
//			    }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}

	@DeleteMapping(value = "/freeDelete/{freeboardId}")
	public ResponseEntity<String> deleteFree(@PathVariable int freeboardId, HttpSession session) {
		System.out.println("삭제 메소드 실행");
		boolean result = false;
		FreeboardDTO freeboard = service.getFreePostByFreeboardId(freeboardId);
		if (String.valueOf(session.getAttribute("userId")) != null
				&& (session.getAttribute("isAdmin") != null && ((boolean) session.getAttribute("isAdmin")
						|| freeboard.getUserId().equals(String.valueOf(session.getAttribute("userId")))))) {
			result = service.deleteFree(freeboardId); // deleteFree 메소드 호출하여 게시글 삭제
			if (result) {
				return ResponseEntity.ok("게시글 삭제 성공");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시글 삭제 실패");
			}
		} else {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body("삭제 권한 없음");
		}
	}

	@GetMapping("/update/{freeboardId}")
	public String updateFree(@PathVariable("freeboardId") int freeboardId, Model model) {
		FreeboardDTO freeboard = service.getFreePostByFreeboardId(freeboardId);

		model.addAttribute("freeboard", freeboard);
		// model.addAttribute("file", file);
		return "/Freeboard/freeUpdate";
	}

	@PostMapping("/update")
	public String updateBoard(FreeboardDTO freeboard, MultipartFile file, HttpSession session) {
		System.out.println(file);
		boolean result = false;
		if (String.valueOf(session.getAttribute("userId")) != null
				&& freeboard.getUserId().equals(String.valueOf(session.getAttribute("userId")))) {
			if (!file.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
				freeboard.setImageName(fileName);
				result = service.updateFreePost(freeboard);
				naverfile.ncpFileupload(file, fileName, 2);
			} else {
				System.out.println("이미지 데이터 : " + freeboard.getImageName());
				if(freeboard.getImageName() == null || freeboard.getImageName().equals("")) {
					freeboard.setImageName("noImage");
				}
				result = service.updateFreePost(freeboard);
			}

			if (result) {
				return "redirect:/Freeboard/freeDetail/" + freeboard.getFreeboardId();
			} else {
				return "error";
			}
		}
		return "redirect:/login";
	}

	public boolean deleteFile(FreeboardDTO dto) {
		String filePath = "/deleteFile/" + dto.getImageName(); // 파일의 경로를 지정합니다.

		// 파일 객체 생성
		File file = new File(filePath);

		// 파일이 존재하면 삭제하고 삭제 여부를 반환합니다.
		if (file.exists()) {
			return file.delete();
		} else {
			// 파일이 존재하지 않으면 삭제하지 않고 false를 반환합니다.
			return false;
		}
	}
}