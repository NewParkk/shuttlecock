package com.fp.shuttlecock.location;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;



@Primary
@Service
public class LocationServiceImpl implements LocationService{
	
	@Autowired
	LocationMapper locationmapper;
	
	@Override
	public ArrayList<Badmintonlocation> getAllLocation() {
		return locationmapper.getAllLocation();
	}
	
	@Override
	public List<Badmintonlocation> getClosestLocations(double currentLat, double currentLon) {
		//조건 내 위치 저장할 리스트
		ArrayList<Badmintonlocation> nearestLocations = new ArrayList<>();
		//모든 위치 불러오기
		ArrayList<Badmintonlocation> alllocation = locationmapper.getAllLocation();
		
		//현재 위치와 모든 위치를 비교하여 거리 계산
		for (Badmintonlocation location : alllocation) {
			double distance = calculateDistance(currentLon, currentLat, location.getLat(), location.getLon());
			//반경 15km이내의 위치 저장
			if (distance <= 10.0) {
				location.setDistance(distance);
				nearestLocations.add(location);
			}
		}
//		가장 가까운 10개로 가져올경우
//		Collections.sort(nearestLocations, Comparator.comparingDouble(Badmintonlocation::getDistance));
//		return nearestLocations.subList(0, Math.min(10, nearestLocations.size()));
		return nearestLocations;
	}
	
	// 두 지점간 유클리디안거리 계산 함수
	private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // 지구의 반지름 (단위: km)

        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);
        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = R * c; // 유클리디안 거리

        return distance;
    }
	
	
}
