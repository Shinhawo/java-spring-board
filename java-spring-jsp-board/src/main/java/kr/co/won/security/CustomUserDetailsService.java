package kr.co.won.security;

import kr.co.won.domain.MemberVo;
import kr.co.won.mapper.MemberMapper;
import kr.co.won.security.domain.CustomUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
	
		log.warn("Load User By UserName : " + userName);
		
		// userName means userid
		MemberVo vo = mapper.read(userName);
		
		log.warn("queried by member mapper: " + vo);
		
		return vo == null ? null : new CustomUser(vo);
	}

}
