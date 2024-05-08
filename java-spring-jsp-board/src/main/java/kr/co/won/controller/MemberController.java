package kr.co.won.controller;

import kr.co.won.domain.Criteria;
import kr.co.won.domain.MemberUpdateForm;
import kr.co.won.domain.PageDTO;
import kr.co.won.service.UserService;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/user/*")
public class MemberController {

	private UserService userService;
	
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/profile")
	public void userInfo(String userid, Model model) {
		log.info("/profile?userid = " + userid);
		model.addAttribute("user", userService.getUserById(userid));
	}
	
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/modify")
	public void modifyForm(String userid, Model model) {
		log.info("/modify?userid= " + userid);
		model.addAttribute("user", userService.getUserById(userid));
	}
	
	@PreAuthorize("principal.username == #userid")
	@PostMapping("/update")
	public String modifyAction(String userid, MemberUpdateForm form) {
		
		log.info("update?userid= " + userid);
		
		userService.updateUser(form, userid);
		
		return "redirect:/user/profile?userid=" + userid;
	}
	
	@PreAuthorize("isAuthenticated() && #userid == authentication.principal.username")
	@GetMapping("/mypost")
	public void mypost(Criteria cri ,@RequestParam("userid")String userid, Model model) {
		
		log.info("list: " + cri);
		
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		}
		catch ( UnknownHostException e ) {
			e.printStackTrace();
		}
			
		if( local == null ) {
		}
		else {
			String ip = local.getHostAddress();
			log.info("ip ::" +ip);
		}
		
		int total = userService.getTotal(cri, userid);
		log.info("total: " + total);
		
		log.info("/mypost?userid=" + userid);
		model.addAttribute("list", userService.getUserPost(cri, userid));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
}
