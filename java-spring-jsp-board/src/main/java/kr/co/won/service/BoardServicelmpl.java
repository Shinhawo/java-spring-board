package kr.co.won.service;

import kr.co.won.domain.BoardAttachVo;
import kr.co.won.domain.BoardVo;
import kr.co.won.domain.Criteria;
import kr.co.won.mapper.BoardMapper;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServicelmpl implements BoardService {

	//spring 4.3 이상에서 자동 처리
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	

	
	@Override
	public BoardVo get(Long bno) {
		log.info("get......" + bno);
		return mapper.read(bno);
	}


	
//	@Override
//	public List<BoardVo> getList() {
//		log.info("list..........");
//		return mapper.getList();
//	}
	
	@Override
	public List<BoardVo> getList(Criteria cri) {
		
		log.info("get List with criteria " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	
	
}
