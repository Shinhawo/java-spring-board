package kr.co.won.mapper;

import kr.co.won.domain.BoardAttachVo;
import java.util.List;

public interface BoardAttachMapper {

	public void insert(BoardAttachVo vo);
	
	public void delete(String uuid);
	
	public List<BoardAttachVo> findByBno(Long Bno);
	
	public void deleteAll(Long bno);
	
	public List<BoardAttachVo> getOldFiles();
}
