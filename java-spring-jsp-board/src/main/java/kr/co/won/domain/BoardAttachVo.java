package kr.co.won.domain;

import lombok.Data;

@Data 
public class BoardAttachVo {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long bno;
}
