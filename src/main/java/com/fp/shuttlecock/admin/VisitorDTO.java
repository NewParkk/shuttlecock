package com.fp.shuttlecock.admin;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class VisitorDTO {
	private int totalVisitor;
	private Date date;
}
