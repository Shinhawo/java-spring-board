package kr.co.won.domain;

import lombok.Data;

@Data
public class AttachFileDto {

	// 서버에서 Ajax의 결과로 브라우저에 전송해야 하는 데이터
	private String fileName;   //원본파일의 이름
	private String uploadPath; // 업로드 경로
	private String uuid;       // UUID 값
	private boolean image;     // 이미지 여부
}
