package kr.co.won.service;

import kr.co.won.domain.AuthVo;
import kr.co.won.domain.BoardVo;
import kr.co.won.domain.Criteria;
import kr.co.won.domain.MemberUpdateForm;
import kr.co.won.domain.MemberVo;
import kr.co.won.domain.ReplyVo;
import kr.co.won.mapper.MemberMapper;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService{

	private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	
	@Override
	public MemberVo getUserByEmail(String userEmail) {
		
		return mapper.getUserByEmail(userEmail);
	}
	
	@Override
	public MemberVo getUserById(String userid) {
		return mapper.getUserById(userid);
	}
	
	@Override
	public void insertRole(AuthVo auth) {

		mapper.insertRole(auth);
	}
	
	@Override
	public void insertUser(MemberVo member) {

		String  encryptedPassword = passwordEncoder.encode(member.getUserpw());
		member.setUserpw(encryptedPassword);
		
		mapper.insert(member);
	}
	
	@Override
	public void updateUser(MemberUpdateForm form, String userid) {

		MemberVo member = mapper.getUserById(userid);
		
		String encyptedPassword = passwordEncoder.encode(form.getUserpw());
		
		member.setUserEmail(form.getUserEmail());
		member.setUserpw(encyptedPassword);
		
		mapper.updateUser(member);
	}
	
	@Override
	public String findUserIdBySnsId(String snsId) {
		
		return mapper.findUserIdBySnsId(snsId);
	}
	
	@Override
	public void kakaoJoin(MemberVo vo) {
		mapper.kakaoInsert(vo);
		String userid = vo.getUserid();
		log.info("userId : " +userid);
	}
	
	@Override
	public MemberVo kakapLogin(String snsId) {
		log.info("snsId : " + snsId);
		return mapper.kakaoSelect(snsId);
	}
	
	@Override
	public int getTotal(Criteria cri, String userid) {
		return mapper.getTotalCount(cri, userid);
	}

	@Override
	public List<BoardVo> getUserPost(Criteria cri,String userid) {
		
		return mapper.getUserPost(cri, userid);
	}
	
	@Override
	public List<ReplyVo> getUserReply(String userid) {
		return mapper.getUserReply(userid);
	}
}
