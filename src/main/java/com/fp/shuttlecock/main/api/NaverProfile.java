package com.fp.shuttlecock.main.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class NaverProfile 
{
	public String resultcode;
	public String message;
	public Response response;
	
	@Data
	@JsonIgnoreProperties(ignoreUnknown = true)
	public class Response 
	{
		public String id;
		public String nickname;
		public String profileImage;
		public String gender;
		public String email;
		public String name;
	}
}


