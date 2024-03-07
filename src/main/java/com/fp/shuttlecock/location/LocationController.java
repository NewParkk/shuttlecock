package com.fp.shuttlecock.location;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;


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
	public ModelAndView findlocation(@RequestBody Badmintonlocation badmintonlocation) {
//		System.out.println(locationservice.getAllLocation().size());
//		System.out.println(locationservice.getClosestLocations(126.9943648, 37.500447).toString());
		double lat = badmintonlocation.getLat();
		double lon = badmintonlocation.getLon();
		System.out.println("current lat : " +lat + " current lon: " + lon);
		List<Badmintonlocation> closestList = locationservice.getClosestLocations(lat,lon);
		System.out.println(closestList.toString());
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
