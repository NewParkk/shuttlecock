package com.fp.shuttlecock.main.api;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class KakaoProfile 
{
	public Long id;
	public String connected_at;
	public Properties properties;
	public KakaoAccount kakao_account;
	
	@Data
	@JsonIgnoreProperties(ignoreUnknown = true)
	public class KakaoAccount 
	{
		public Boolean profile_nickname_needs_agreement;
		public Boolean profile_image_needs_agreement;
		public Profile profile;
		public Boolean has_email;
		public Boolean email_needs_agreement;
		public Boolean is_email_valid;
		public Boolean is_email_verified;
		public String email;
		public Boolean has_phone_number;
		public Boolean phone_number_needs_agreement;
		public String phone_number;
		public Boolean has_gender;
		public String gender;

		@Data
		@JsonIgnoreProperties(ignoreUnknown = true)
		public class Profile 
		{
			public String nickname;
			public String thumbnail_image_url;
			public String profile_image_url;
			public Boolean is_default_image;
		}
	}

	@Data
	@JsonIgnoreProperties(ignoreUnknown = true)
	static class Properties 
	{
		public String nickname;
		public String profile_image;
		public String thumbnail_image;
	}
	
	
}


