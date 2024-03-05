package com.fp.shuttlecock.location;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class LocationController {
	
	@Autowired
	LocationServiceImpl locationservice;
	
	@GetMapping("/location")
	public String findlocation() {
		System.out.println(locationservice.getAllLocation().size());
		System.out.println(locationservice.getClosestLocations(126.9943648, 37.500447).toString());
		
		return new String();
	}
	
	
	
	
	
}
