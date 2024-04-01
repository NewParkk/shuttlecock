package com.fp.shuttlecock.main.api;

import lombok.Data;

@Data
public class GoogleProfile {
	private String id;
	private String email;
	private boolean verified_email;
	private String name;
	private String given_name;
	private String family_name;
	private String picture;
	private String locale;
}
