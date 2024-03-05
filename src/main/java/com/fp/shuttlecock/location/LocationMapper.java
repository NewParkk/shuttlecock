package com.fp.shuttlecock.location;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LocationMapper {

	ArrayList<Badmintonlocation> getAllLocation();
	
	
}
