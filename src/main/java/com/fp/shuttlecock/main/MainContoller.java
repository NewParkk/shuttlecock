package com.fp.shuttlecock.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainContoller {
	
	@RequestMapping("/main")
    public String showMainPage() {
        return "main"; // "main"은 실제로 /WEB-INF/views/main.jsp에 매핑됩니다.
    }
	
	
}
