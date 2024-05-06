package kr.co.won.service;

import kr.co.won.domain.AuthVo;
import kr.co.won.domain.MemberUpdateForm;
import kr.co.won.domain.MemberVo;

public interface UserService {
	
	public MemberVo getUserByEmail(String userEmail);
	
	public MemberVo getUserById(String userid);
	
	public void insertUser(MemberVo member);
	
	public void insertRole(AuthVo auth);

	public void updateUser(MemberUpdateForm forn, String userid);

	public void kakaoJoin(MemberVo vo);
	
	public MemberVo kakapLogin(String snsId);
	
	public String findUserIdBySnsId(String snsId);
}
