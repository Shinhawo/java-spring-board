package kr.co.won.controller;

import kr.co.won.domain.Criteria;
import kr.co.won.domain.ReplyPageDTO;
import kr.co.won.domain.ReplyVo;
import kr.co.won.service.ReplyService;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;
	
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new",
				 consumes = "application/json",
				 produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVo vo){
		
		log.info("Reply Vo : " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
			   ? new ResponseEntity<>("success", HttpStatus.OK)
			   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	   
	}
	
	
	@GetMapping(value = "/pages/{bno}/{page}",
				produces = {
						MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
												@PathVariable("bno") Long bno,
												@PathVariable("page") int page) {
		log.info("getList...................");
		
		Criteria cri = new Criteria(page,10);
		log.info("get Reply List bno : " + bno);
		log.info("cri : " + cri);

		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}
	
	
	@GetMapping(value = "/{rno}",
				produces = {MediaType.APPLICATION_XML_VALUE,
						    MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVo> get(@PathVariable("rno") Long rno) {
		
		log.info("get : " + rno);
		
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@RequestBody ReplyVo vo,@PathVariable("rno") Long rno) {
		
		log.info("remove : " + rno);
		
		return service.remove(rno) == 1 
			   ? new ResponseEntity<>("success", HttpStatus.OK)
			   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH},
					value = "/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> Modify(@RequestBody ReplyVo vo, @PathVariable("rno") Long rno) {
		
		vo.setRno(rno);
		
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		
		return service.modify(vo) == 1
			   ? new ResponseEntity<>("success", HttpStatus.OK)
			   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
}
