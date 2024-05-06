package kr.co.won.security.domain;

import kr.co.won.domain.MemberVo;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	
	private MemberVo member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(MemberVo vo) {
	    super(vo.getUserid(), vo.getUserpw(), 
	          vo.getAuthList() != null ? vo.getAuthList().stream()
	              .map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList())
	              : Collections.emptyList());

	    this.member = vo;
	}
	
	public List<GrantedAuthority> getList(MemberVo vo) {
	    if (vo == null || vo.getAuthList() == null) {
	        return Collections.emptyList();
	    }

	    return vo.getAuthList().stream()
	        .map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
	        .collect(Collectors.toList());
	}

}
