package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import model.CommentDTO;
import model.CommuDTO;
import model.NoticeDTO;
import model.OrderDTO;

// 보드 폴더의 모든 액션은 BoardController 여기서 처리됨 : 게시판
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 3; // 화면에 표시되는 게시글 숫자
	private ServletRequest session;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	// 게시판 페이지 컨트롤
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String RequestURI = request.getRequestURI(); // 파일의 경로 path
		String contextPath = request.getContextPath(); // 프로젝트 경로 path
		String command = RequestURI.substring(contextPath.length()); // 총파일경로에서 프로젝트 경로를 뺀 path

		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");

		// 주문 수정 페이지 출력
		if (command.equals("/OrderListAction.do")) {// 등록된 주문 페이지 출력하기
			requestOrderList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./order/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/OrderViewAction.do")) {// 선택된 주문 상세 페이지 가져오기
			requestBoardView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/OrderView.do");
			rd.forward(request, response);
		} else if (command.equals("/OrderView.do")) { // 주문 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./order/view.jsp");
			rd.forward(request, response);
		}
		// 주문페이지 수정 삭제
		else if (command.equals("/OrderUpdateAction.do")) { // 선택된 글 수정
			requestOrderUpdate(request);
			RequestDispatcher rd = request.getRequestDispatcher("/OrderListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/OrderDeleteAction.do")) { // 선택된 글 삭제하기
			requestOrderDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/OrderListAction.do");
			rd.forward(request, response);
		}

		// 결산 페이지 출력
		else if (command.equals("/AccountListAction.do")) {// 결산 페이지 출력하기
			requestAccountList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./order/account.jsp");
			rd.forward(request, response);
		} else if (command.equals("/AccountViewAction.do")) {// 선택된 결산 상세 페이지 가져오기
			requestBoardView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/AccountView.do");
			rd.forward(request, response);
		} else if (command.equals("/AccountView.do")) { // 결산 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./order/accountView.jsp");
			rd.forward(request, response);
		}

		//
		// 공지사항 페이지 출력 (손님)
		else if (command.equals("/M_NoticeListAction.do")) {// 페이지 출력하기
			requestNoticeList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./notice/noticeList_m.jsp");
			rd.forward(request, response);
		} else if (command.equals("/M_NoticeViewAction.do")) {// 선택된 상세 페이지 가져오기
			requestNoticeView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/M_NoticeView.do");
			rd.forward(request, response);
		} else if (command.equals("/M_NoticeView.do")) { // 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./notice/noticeView_m.jsp");
			rd.forward(request, response);
		}

		//
		//
		// 공지사항 페이지 출력 (관리자)
		else if (command.equals("/NoticeListAction.do")) {// 페이지 출력하기
			requestNoticeList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./notice/noticeList.jsp");
			rd.forward(request, response);
		} else if (command.equals("/NoticeViewAction.do")) {// 선택된 상세 페이지 가져오기
			requestNoticeView(request);
			RequestDispatcher rd = request.getRequestDispatcher("/NoticeView.do");
			rd.forward(request, response);
		} else if (command.equals("/NoticeView.do")) { // 상세 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./notice/noticeView.jsp");
			rd.forward(request, response);
		}
		// 글 작성
		else if (command.equals("/NoticeWrite.do")) { // 글 등록 페이지 출력하기
			RequestDispatcher rd = request.getRequestDispatcher("./notice/noticeWrite.jsp");
			rd.forward(request, response);
		} else if (command.equals("/NoticeWriteAction.do")) {// 새로운 글 등록하기
			requestNoticeWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/NoticeListAction.do");
			rd.forward(request, response);
		}
		// 수정 삭제
		else if (command.equals("/NoticeUpdateAction.do")) { // 선택된 글 수정
			requestNoticeUpdate(request);
			RequestDispatcher rd = request.getRequestDispatcher("/NoticeListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/NoticeDeleteAction.do")) { // 선택된 글 삭제하기
			requestNoticeDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/NoticeListAction.do");
			rd.forward(request, response);
		}
	
	}

	//
	// 등록된 주문 목록 가져오기
	public void requestOrderList(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();
		List<OrderDTO> Orderlist = new ArrayList<OrderDTO>();

		int pageNum = 1; // 최초 페이지넘버는 1
		int limit = LISTCOUNT; // 화면 표시 게시글수

		if (request.getParameter("pageNum") != null) // 페이지 넘버가 있으면 그 값으로
			pageNum = Integer.parseInt(request.getParameter("pageNum"));

		// 검색데이터값을 기록하는 부분
		if (request.getParameter("newSearch") != null) {
			String items = request.getParameter("items"); // 제목, 본문, 글쓴이
			String text = request.getParameter("text"); // 검색어
			dao.setItems(items);
			dao.setText(text);
		}

		int total_record = dao.getListCount(dao.getItems(), dao.getText()); // 총 레코드(행) 개수
		Orderlist = dao.getOrderList(pageNum, limit, dao.getItems(), dao.getText()); // 화면에 표시할 보드리스트
		//

		// items 분류 지정 / text 검색어
		String items = request.getParameter("items");
		String text = request.getParameter("text");

		int total_page;

		if (total_record % limit == 0) { // 총 게시글의 숫자가 LISTCOUNT의 배수일때
			total_page = total_record / limit;
			Math.floor(total_page);
		} else { // 아닐때
			total_page = total_record / limit;
			Math.floor(total_page); // 소수점 생략
			total_page = total_page + 1; // 나머지가 있을때 +1 한다
		}
		// 리퀘스트에 페이지넘버, 전체 페이지 수, 전체 게시글수, 화면에 출력할 게시글 리스트
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("Orderlist", Orderlist);
	}

	// 등록된 결산 목록 가져오기
	public void requestAccountList(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();
		List<OrderDTO> Accountlist = new ArrayList<OrderDTO>();

		int pageNum = 1; // 최초 페이지넘버는 1
		int limit = LISTCOUNT; // 화면 표시 게시글수 

		if (request.getParameter("pageNum") != null) // 페이지 넘버가 있으면 그 값으로
			pageNum = Integer.parseInt(request.getParameter("pageNum"));

		// 검색데이터값을 기록하는 부분
		if (request.getParameter("newSearch") != null) {
			String items = request.getParameter("items"); // 제목, 본문, 글쓴이
			String text = request.getParameter("text"); // 검색어
			dao.setItems(items);
			dao.setText(text);
		}

		int total_record = dao.getListCount(dao.getItems(), dao.getText()); // 총 레코드(행) 개수
		Accountlist = dao.getAccountList(pageNum, limit, dao.getItems(), dao.getText()); // 화면에 표시할 보드리스트
		//

		// items 분류 지정 / text 검색어
		String items = request.getParameter("items");
		String text = request.getParameter("text");

		int total_page;

		if (total_record % limit == 0) { // 총 게시글의 숫자가 5의 배수일때
			total_page = total_record / limit;
			Math.floor(total_page);
		} else { // 아닐때
			total_page = total_record / limit;
			Math.floor(total_page); // 소수점 생략
			total_page = total_page + 1; // 나머지가 있을때 +1 한다
		}
		// 리퀘스트에 페이지넘버, 전체 페이지 수, 전체 게시글수, 화면에 출력할 게시글 리스트
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("Accountlist", Accountlist);
	}

	// 선택된 글 상세 페이지 가져오기
	public void requestBoardView(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		OrderDTO board = new OrderDTO();
		board = dao.getBoardByNum(num, pageNum);

		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("board", board);
	}

	// 선택된 글 내용 수정하기
	public void requestOrderUpdate(HttpServletRequest request) {

		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDAO dao = BoardDAO.getInstance();

		OrderDTO board = new OrderDTO();
		board.setO_num(num);
		board.setConditions(request.getParameterValues("conditions")[0]);
		board.setPostcode(request.getParameter("postcode"));
		board.setAddress(request.getParameter("address"));

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());
		board.setRegist_day(regist_day);
		
		dao.updateBoard(board);
	}

	// 선택된 글 삭제하기
	public void requestOrderDelete(HttpServletRequest request) {

		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDAO dao = BoardDAO.getInstance();
		dao.deleteBoard(num);
	}

	//
	// 등록된 공지사항 목록 가져오기
	public void requestNoticeList(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();
		List<NoticeDTO> noticelist = new ArrayList<NoticeDTO>();

		int pageNum = 1; // 최초 페이지넘버는 1
		int limit = LISTCOUNT; // 화면 표시 게시글수 

		if (request.getParameter("pageNum") != null) // 페이지 넘버가 있으면 그 값으로
			pageNum = Integer.parseInt(request.getParameter("pageNum"));

		// items 제목 본문 글쓴이 / text 검색어
		String items = request.getParameter("items");
		String text = request.getParameter("text");

		// 게시글이 몇개인지 (제목 또는 본문 또는 글쓴이), 검색어
		int total_record = dao.getNoticeListCount(items, text);
		// 화면에 보여줄 게시글을 가져온다. (페이지 넘버, 표시되는 게시글수(), 아이템, 검색어)
		noticelist = dao.getNoticeList(pageNum, limit, items, text);

		int total_page;

		if (total_record % limit == 0) { // 총 게시글의 숫자가 LISTCOUNT의 배수일때
			total_page = total_record / limit;
			Math.floor(total_page);
		} else { // 아닐때
			total_page = total_record / limit;
			Math.floor(total_page); // 소수점 생략
			total_page = total_page + 1; // 나머지가 있을때 +1 한다
		}
		// 리퀘스트에 페이지넘버, 전체 페이지 수, 전체 게시글수, 화면에 출력할 게시글 리스트
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("noticelist", noticelist);
	}

	// 새로운 공지사항 등록하기
	public void requestNoticeWrite(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();

		NoticeDTO notice = new NoticeDTO();
		notice.setName(request.getParameter("name"));
		notice.setSubject(request.getParameter("subject"));
		notice.setContent(request.getParameter("content"));

		System.out.println(request.getParameter("name"));
		System.out.println(request.getParameter("subject"));
		System.out.println(request.getParameter("content"));
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());

		notice.setHit(0);
		notice.setRegist_day(regist_day);
		notice.setIp(request.getRemoteAddr());

		dao.insertNotice(notice);
	}

	// 선택된 공지사항 상세 페이지 가져오기
	public void requestNoticeView(HttpServletRequest request) {

		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		NoticeDTO notice = new NoticeDTO();
		notice = dao.getNoticeByNum(num, pageNum);

		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("board", notice);
	}

	// 선택된 공지사항 내용 수정하기
	public void requestNoticeUpdate(HttpServletRequest request) {

		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDAO dao = BoardDAO.getInstance();

		NoticeDTO notice = new NoticeDTO();
		notice.setN_num(num);
		notice.setName(request.getParameter("name"));
		notice.setSubject(request.getParameter("subject"));
		notice.setContent(request.getParameter("content"));

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
				"yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());

		notice.setHit(0);
		notice.setRegist_day(regist_day);
		notice.setIp(request.getRemoteAddr());

		dao.updateNotice(notice);
	}

	// 선택된 공지사항 삭제하기
	public void requestNoticeDelete(HttpServletRequest request) {

		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDAO dao = BoardDAO.getInstance();
		dao.deleteNotice(num);
	}
	

		
	
}
