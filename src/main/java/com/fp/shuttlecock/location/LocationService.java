package com.fp.shuttlecock.location;

import java.util.ArrayList;
import java.util.List;

public interface LocationService {
	
	ArrayList<Badmintonlocation> getAllLocation();
	
	List<Badmintonlocation> getClosestLocations(double currentLat, double currentLon);
}
