package kr.co.won.service;

import java.util.List;

import kr.co.won.domain.AuthVo;
import kr.co.won.domain.BoardVo;
import kr.co.won.domain.Criteria;
import kr.co.won.domain.MemberUpdateForm;
import kr.co.won.domain.MemberVo;
import kr.co.won.domain.ReplyVo;

public interface UserService {
	
	public MemberVo getUserByEmail(String userEmail);
	
	public MemberVo getUserById(String userid);
	
	public void insertUser(MemberVo member);
	
	public void insertRole(AuthVo auth);

	public void updateUser(MemberUpdateForm forn, String userid);

	public void kakaoJoin(MemberVo vo);
	
	public MemberVo kakapLogin(String snsId);
	
	public String findUserIdBySnsId(String snsId);
	
	public List<BoardVo> getUserPost(Criteria cri,String userid);
	
	public List<ReplyVo> getUserReply(Criteria cri,String userid);
	
	public int getTotal(Criteria cri, String userid);

	public int getRTotal(String userid);
}
