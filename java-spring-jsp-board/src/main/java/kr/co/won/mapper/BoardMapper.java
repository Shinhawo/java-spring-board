package kr.co.won.mapper;

import kr.co.won.domain.BoardVo;
import kr.co.won.domain.Criteria;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BoardMapper {

	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVo> getList();
	
	public List<BoardVo> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void insert(BoardVo board);
	
	public void insertSelectKey(BoardVo board);

	public BoardVo read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVo board);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
}
