package kr.co.won.mapper;

import kr.co.won.domain.AuthVo;
import kr.co.won.domain.MemberVo;

import org.apache.ibatis.annotations.Select;

public interface MemberMapper {

	public MemberVo read(String userId);

	public MemberVo getUserById(String userid);

	public MemberVo getUserByEmail(String userEmail);
	
	public void insert(MemberVo member);

	public void insertRole(AuthVo auth);
	
	public void updateUser(MemberVo member);
	
	 //snsId로 회원정보얻기
    @Select("SELECT USERID, USERNAME, USEREMAIL FROM TBL_MEMBER WHERE SNSID = #{snsId}")
    MemberVo kakaoSelect(String snsId);

    //snsId로 회원 아이디찾기
    @Select("SELECT USERID FROM TBL_MEMBER WHERE SNSID = #{snsId}")
    String findUserIdBySnsId(String snsId);
	
	void kakaoInsert(MemberVo member);
}
