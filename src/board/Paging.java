package board;

import java.util.ArrayList;

public class Paging {
	private int contentAll; // 전체 글 목록
	private int onePageSize; // 한페이지에 담을 글
	private int maxPage;	// 마지막 페이지
	private int thisPage;  	// 현재 페이지 
	private int startContent;	// 페이지 별 최상단 글
	private int endContent;		// 페이지 별 최하단 글
	// 한번에 보여질 페이지
	private int startPage;	
	private int endPage;
	
	public Paging(int onePageSize, ArrayList<BoardDTO> list, int thisPage) {
		
		this.contentAll = list.size();
		this.onePageSize = onePageSize;
		this.thisPage = thisPage;
		
		if(contentAll%onePageSize != 0) {	// 나누어 떨어지지 않을 때
			maxPage = contentAll/onePageSize + 1;
		}
		else {								// 나누어 떨어질 때
			maxPage = contentAll/onePageSize;
		}
		
		// for 문에 들어갈 Content 변수
		startContent = (list.size()-1) - (onePageSize * (thisPage-1));
		endContent = startContent - (onePageSize-1);
		if(endContent < 0) {
			endContent = 0;
		}
		
		startPage = ((thisPage - 1) / 5) * 5 + 1;
		endPage = startPage + 4;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
	}
	
	
	public int getContentAll() {
		return contentAll;
	}


	public int getOnePageSize() {
		return onePageSize;
	}


	public int getMaxPage() {
		return maxPage;
	}


	public int getThisPage() {
		return thisPage;
	}


	public int getStartContent() {
		return startContent;
	}


	public int getEndContent() {
		return endContent;
	}


	public int getStartPage() {
		return startPage;
	}


	public int getEndPage() {
		return endPage;
	}


		
	
	
	
}
