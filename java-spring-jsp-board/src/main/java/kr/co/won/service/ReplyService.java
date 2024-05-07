package kr.co.won.service;

import kr.co.won.domain.Criteria;
import kr.co.won.domain.ReplyPageDTO;
import kr.co.won.domain.ReplyVo;
import java.util.List;

public interface ReplyService {

	public int register(ReplyVo vo);
	
	public ReplyVo get(Long rno);
	
	public int modify(ReplyVo vo);
	
	public int remove(Long rno);
	
	public List<ReplyVo> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
