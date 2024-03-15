package com.fp.shuttlecock.location;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;


@Configuration
@Controller
public class LocationController {
	
	@Autowired
	LocationService locationservice;
	
	@Bean
    MappingJackson2JsonView jsonView(){
        return new MappingJackson2JsonView();
    }
	
	@PostMapping(value="/location")
	@ResponseBody
	public ModelAndView findlocation(@RequestBody Badmintonlocation badmintonlocation) 
	{
		double lat = badmintonlocation.getLat();
		double lon = badmintonlocation.getLon();
		List<Badmintonlocation> closestList = locationservice.getClosestLocations(lat,lon);
		ModelAndView mv = new ModelAndView("jsonView");
		String resultCode = "F000";
		if (closestList.size() > 0) {
			resultCode = "S000";
		}
		mv.addObject("closestList", closestList);
		mv.addObject("resultCode", resultCode);
		
		return mv;
	}
	
	
	
	
	
}
