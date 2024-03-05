package com.fp.shuttlecock.location;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Badmintonlocation {
	
	private int locationId;
	private String name;
	private double lat;
	private double lon;
	private double distance;
	
}
