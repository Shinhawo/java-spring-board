package kr.co.won.service;

import kr.co.won.domain.BoardAttachVo;
import kr.co.won.domain.BoardVo;
import kr.co.won.domain.Criteria;
import java.util.List;

public interface BoardService {

	public void register(BoardVo board);
	
	public BoardVo get(Long bno);
	
	//public boolean modify(BoardVo board);
	
	//public boolean remove(Long bno);
	
	//public List<BoardVo> getList();
	
	public List<BoardVo> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVo> getAttachList(Long bno);
	
}
