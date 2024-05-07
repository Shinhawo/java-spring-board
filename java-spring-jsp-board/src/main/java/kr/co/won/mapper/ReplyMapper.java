package kr.co.won.mapper;

import kr.co.won.domain.Criteria;
import kr.co.won.domain.ReplyVo;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ReplyMapper {

	// foreign key를 사용하는 등록 작업
	public int insert(ReplyVo vo);
	
	public ReplyVo read(Long rno);
	
	public int delete (Long rno);
	
	public int update (ReplyVo vo);
	
	// 댓글을 페이징처리 하기 위한 작업
	public List<ReplyVo> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno
			);
	
	public int getCountByBno(Long bno);
}
