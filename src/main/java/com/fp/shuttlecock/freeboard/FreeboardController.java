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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fp.shuttlecock.comments.CommentsDTO;
import com.fp.shuttlecock.comments.CommentsServiceImpl;
import com.fp.shuttlecock.likes.LikesDTO;
import com.fp.shuttlecock.tradeboard.TradeboardDTO;
import com.fp.shuttlecock.util.LikesVO;
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

	// 테스트용 메소드
	@GetMapping("/")
	public void test() {
		System.out.println("화면출력");
	}

	// 자유게시판 이동
	@GetMapping("/freeList")
	public String getFree(Model model, PageVO vo, FreeboardDTO dto) {
		System.out.println("자유게시판으로 이동");
		System.out.println("검색어" + vo.getKeyword());
		System.out.println("검색조건" + vo.getCondition());

		dto.setUserId("1234"); // 임의로 userId 지정

		PageCreate pc = new PageCreate();
		pc.setPaging(vo);
		pc.setArticleTotalCount(service.getTotal(vo));

		System.out.println(pc);
		vo.setPagecnt((vo.getPageNum() - 1) * vo.getCountPerPage());
		model.addAttribute("freeList", service.getFreeboard(vo));
		model.addAttribute("pc", pc);

		return "Freeboard/freeList";
	}

	// 글쓰기 페이지 이동
	@GetMapping("/freeWrite")
	public void freeWrite() {
		FreeboardDTO dto = new FreeboardDTO();
		dto.setUserId("1234"); // 임의로 userId 지정
		System.out.println("글쓰기 페이지로 이동");
	}

	// 글 등록
	@PostMapping("/insertFreeboard")
	public String insertFreeboard(FreeboardDTO dto, Model model, HttpSession session,
	        @RequestParam("upload") MultipartFile file) {

		System.out.println("insertFreeboard  title : " + dto.getTitle());
//		dto.setUserId("1234"); // 임의로 userId 지정
		dto.setUserId(String.valueOf(session.getAttribute("userId")));
		try {
	        String imageUrl = uploadImage(file, session);
	        dto.setUploadPath(imageUrl);
	        dto.setUserId((String) session.getAttribute("userId"));
	        service.insertFreeboard(dto);
	    } catch (IOException e) {
	        e.printStackTrace();
	        // 업로드 실패 시 처리
	    }
		return "redirect:/Freeboard/freeList";
	}

	// 글 상세 보기
	@GetMapping("/freeDetail")
	public void freeDetail(int freeboardId, String userId, Model model) {
		System.out.println("상세보기 페이지");
		FreeboardDTO dto = service.freeDetail(freeboardId);
		if (dto != null) {
			List<CommentsDTO> commentList = commentService.getCommentList(freeboardId, 2);
			// FileRequest file = fileService.getBoardFileByTradeboardId(freeboardId);
			service.hit(freeboardId);

			// model.addAttribute("file", file);
			model.addAttribute("Freeboard", dto);
			model.addAttribute("commentList", commentList);
		}
		model.addAttribute("Detail", dto);
		service.hit(freeboardId);
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
	public String updateBoard(FreeboardDTO dto, RedirectAttributes ra, HttpSession session) {
		dto.setUserId(String.valueOf(session.getAttribute("userId")));
		System.out.println("게시물 수정 요청");

		System.out.println(dto.getFreeboardId());
		System.out.println(dto.getContent());
		System.out.println(dto.getTitle());

		service.updateFree(dto);
		ra.addFlashAttribute("msg", "updateSuccess");

		return "redirect:/Freeboard/freeDetail?freeboardId=" + dto.getFreeboardId();
	}
		
//	이미지 업로드

	@ResponseBody
	@RequestMapping(value = "fileupload.do")
	public void communityImageUpload(HttpServletRequest req, HttpServletResponse resp,
			MultipartHttpServletRequest multiFile) throws Exception { // JsonObject
		JsonObject jsonObject = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");

		if (file != null) {
			if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if (file.getContentType().toLowerCase().startsWith("image/")) {
					try {

						String fileName = file.getOriginalFilename();
						byte[] bytes = file.getBytes();

						String uploadPath = req.getSession().getServletContext()
								.getRealPath("/resources/images/free"); // 저장경로
						System.out.println("uploadPath:" + uploadPath);

						File uploadFile = new File(uploadPath);
						if (!uploadFile.exists()) {
							uploadFile.mkdir();
						}
						String fileName2 = UUID.randomUUID().toString();
						uploadPath = uploadPath + "/" + fileName2 + fileName;

						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);
						printWriter = resp.getWriter();
						String fileUrl = req.getContextPath() + "/resources/images/free/" + fileName2 + fileName; // url경로
						System.out.println("fileUrl :" + fileUrl);
						JsonObject json = new JsonObject();
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						printWriter.print(json);
						System.out.println(json);

					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						if (out != null) {
							out.close();
						}
						if (printWriter != null) {
							printWriter.close();
						}
					}
				}

			}

		}

	}
	
	private String uploadImage(MultipartFile file, HttpSession session) throws IOException {
	    if (file != null && !file.isEmpty() && file.getContentType().startsWith("image/")) {
	        String uploadPath = session.getServletContext().getRealPath("/resources/images/free");
	        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	        String filePath = uploadPath + File.separator + fileName;
	        File dest = new File(filePath);
	        file.transferTo(dest);
	        return "/resources/images/free/" + fileName;
	    }
	    return null;
	}
}