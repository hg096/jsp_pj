package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;

import database.DBConnection;


//보드 DTO를 사용하는 메소드들을 정의(DB연결 등 처리)
public class BoardDAO {
	// 싱글톤 static instance
	private static BoardDAO instance; // 멤버 변수로 선언
	private Connection conn; // 초기값은 항상 null
	private PreparedStatement pstmt;
	private ResultSet rs;

	// get set을 만들어서 여기 저장
	private String items;
	private String text;

	public String getItems() {
		return items;
	}

	public void setItems(String items) {
		this.items = items;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	private BoardDAO() { // 객체생성을 다른 클래스에서 못함
	}

	public static BoardDAO getInstance() {
		if (instance == null)
			instance = new BoardDAO(); // instance객체가 없으면 하나 만들기
		return instance; // instance 메소드로 1개인 보드 DAO로 가져감
	}

	// orders 테이블의 레코드 개수
	public int getListCount(String items, String text) {

		int x = 0;

		String sql;

		if (items == null && text == null)
			sql = "select  count(*) from orders";
		else
			sql = "SELECT   count(*) FROM orders where " + items + " like '%" + text + "%'";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);

		} catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			closeAll();
		}
		return x;
	}

	// 주문 테이블의 레코드 가져오기
	public ArrayList<OrderDTO> getOrderList(int page, int limit, String items, String text) {
		// 총 게시글수
		int total_record = getListCount(items, text);
		int start = (page - 1) * limit; // 페이지에 따라서 보여줄 첫번째 게시글 번호
		int index = start + 1; // 0번은 없어서 + 1

		String sql;

		if (items == null && text == null) // 그냥 게시판을 클릭하면 전체게시판 불러오기
			sql = "select * from orders ORDER BY o_num DESC";
		else // 검색대상과 검색어가 있을경우
			sql = "SELECT  * FROM orders where " + items + " like '%" + text
					+ "%' ORDER BY o_num DESC ";

		// 리스트 생성
		ArrayList<OrderDTO> Olist = new ArrayList<OrderDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) { // 반복문 인덱스 번호에 맞는 레코드를 가져온다
				OrderDTO Order = new OrderDTO();
				Order.setO_num(rs.getInt("o_num"));
				Order.setP_name(rs.getString("p_name"));
				Order.setAmount(rs.getInt("amount"));
				Order.setM_name(rs.getString("m_name"));
				Order.setRegist_day(rs.getString("regist_day"));
				Order.setT_Price(rs.getInt("t_Price"));
				Order.setConditions(rs.getString("conditions"));
				Order.setPostcode(rs.getString("postcode"));
				Order.setAddress(rs.getString("address"));
				Olist.add(Order); // 리스트에 추가

				// 인덱스 < (0+5) 1부터 5까지 59번 줄에서 1부터 시작
				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return Olist;
		} catch (Exception ex) {
			System.out.println("getOrderList() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	// 주문 결산 테이블의 레코드 가져오기
	public ArrayList<OrderDTO> getAccountList(int page, int limit, String items, String text) {
		// 총 게시글수
		int total_record = getListCount(items, text);
		int start = (page - 1) * limit; // 페이지에 따라서 보여줄 첫번째 게시글 번호
		int index = start + 1; // 0번은 없어서 + 1

		String sql;

		if (items == null && text == null) // 상태1의 결과를 가져오기
			sql = "SELECT * FROM orders WHERE conditions='배송완료' ORDER BY o_num DESC";
		else // 검색대상과 검색어가 있을경우
			sql = "SELECT * FROM orders WHERE conditions = '배송완료' and " + items + " LIKE '%" + text
					+ "%' ORDER BY o_num DESC";

		// 리스트 생성
		ArrayList<OrderDTO> Alist = new ArrayList<OrderDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) { // 반복문 인덱스 번호에 맞는 레코드를 가져온다
				OrderDTO Account = new OrderDTO();
				Account.setO_num(rs.getInt("o_num"));
				Account.setP_name(rs.getString("p_name"));
				Account.setAmount(rs.getInt("amount"));
				Account.setM_name(rs.getString("m_name"));
				Account.setRegist_day(rs.getString("regist_day"));
				Account.setT_Price(rs.getInt("t_Price"));
				Account.setConditions(rs.getString("conditions"));
				Account.setPostcode(rs.getString("postcode"));
				Account.setAddress(rs.getString("address"));
				Alist.add(Account); // 리스트에 추가

				// 인덱스 < (0+5) 1부터 5까지 59번 줄에서 1부터 시작
				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return Alist;
		} catch (Exception ex) {
			System.out.println("getAccountList() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	//
	// 선택된 주문글 상세 내용 가져오기
	public OrderDTO getBoardByNum(int num, int page) {
		OrderDTO board = null;

		String sql = "select * from orders where o_num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new OrderDTO();
				board.setO_num(rs.getInt("o_num"));
				board.setP_name(rs.getString("p_name"));
				board.setAmount(rs.getInt("amount"));
				board.setM_name(rs.getString("m_name"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setT_Price(rs.getInt("t_Price"));
				board.setConditions(rs.getString("conditions"));
				board.setPostcode(rs.getString("postcode"));
				board.setAddress(rs.getString("address"));
			}

			return board;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	// 선택된 주문글 내용 수정하기
	public void updateBoard(OrderDTO board) {
		try {
			String sql = "update orders set conditions=?, postcode=?, address=? where o_num=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			conn.setAutoCommit(false);

			pstmt.setString(1, board.getConditions());
			pstmt.setString(2, board.getPostcode());
			pstmt.setString(3, board.getAddress());

			pstmt.setInt(4, board.getO_num());

			pstmt.executeUpdate();
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateBoard() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 선택된 주문글 삭제하기
	public void deleteBoard(int num) {
		String sql = "delete from orders where o_num=?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 디비 연결 닫기
	private void closeAll() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception ex) {
			throw new RuntimeException(ex.getMessage());
		}
	}

	//
	// 공지사항 테이블의 레코드 개수
	public int getNoticeListCount(String items, String text) {

		int x = 0;

		String sql;

		if (items == null && text == null)
			sql = "select  count(*) from Notice";
		else
			sql = "SELECT   count(*) FROM Notice where " + items + " like '%" + text + "%'";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);

		} catch (Exception ex) {
			System.out.println("getListNoticeCount() 에러: " + ex);
		} finally {
			closeAll();
		}
		return x;
	}

	// 공지사항
	public ArrayList<NoticeDTO> getNoticeList(int page, int limit, String items, String text) {
		// 총 게시글수
		int total_record = getNoticeListCount(items, text);
		int start = (page - 1) * limit; // 페이지에 따라서 보여줄 첫번째 게시글 번호
		int index = start + 1; // 0번은 없어서 + 1

		String sql;

		if (items == null && text == null) // 그냥 게시판을 클릭하면 전체게시판 불러오기
			sql = "select * from notice ORDER BY n_num DESC";
		else // 검색대상과 검색어가 있을경우
			sql = "SELECT  * FROM notice where " + items + " like '%" + text
					+ "%' ORDER BY n_num DESC ";

		// 리스트 생성
		ArrayList<NoticeDTO> list = new ArrayList<NoticeDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) { // 반복문 인덱스 번호에 맞는 레코드를 가져온다
				NoticeDTO notice = new NoticeDTO();
				notice.setN_num(rs.getInt("n_num"));
				notice.setName(rs.getString("name"));
				notice.setSubject(rs.getString("subject"));
				notice.setContent(rs.getString("content"));
				notice.setRegist_day(rs.getString("regist_day"));
				notice.setHit(rs.getInt("hit"));
				notice.setIp(rs.getString("ip"));
				list.add(notice); // 리스트에 추가

				// 인덱스 < (0+5) 1부터 5까지 59번 줄에서 1부터 시작
				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getNoticeList() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	// 새로운 공지사항 쓰기
	public void insertNotice(NoticeDTO notice) {
		try {
			conn = DBConnection.getConnection();

			String sql = "insert into notice values(?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice.getN_num());
			pstmt.setString(2, notice.getName());
			pstmt.setString(3, notice.getSubject());
			pstmt.setString(4, notice.getContent());
			pstmt.setString(5, notice.getRegist_day());
			pstmt.setInt(6, notice.getHit());
			pstmt.setString(7, notice.getIp());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertNotice() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 선택된 공지사항의 조회수 증가하기
	public void updateHit(int num) {
		try {
			conn = DBConnection.getConnection();

			String sql = "select hit from notice where n_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;

			sql = "update notice set hit=? where n_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 선택된 공지사항 상세 내용 가져오기
	public NoticeDTO getNoticeByNum(int num, int page) {
		NoticeDTO notice = null;

		updateHit(num);
		String sql = "select * from notice where n_num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setN_num(rs.getInt("n_num"));
				notice.setName(rs.getString("name"));
				notice.setSubject(rs.getString("subject"));
				notice.setContent(rs.getString("content"));
				notice.setRegist_day(rs.getString("regist_day"));
				notice.setHit(rs.getInt("hit"));
				notice.setIp(rs.getString("ip"));
			}

			return notice;
		} catch (Exception ex) {
			System.out.println("getNoticeByNum() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	// 선택된 글 내용 수정하기
	public void updateNotice(NoticeDTO notice) {
		try {
			String sql = "update notice set name=?, subject=?, content=? where n_num=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			conn.setAutoCommit(false);

			pstmt.setString(1, notice.getName());
			pstmt.setString(2, notice.getSubject());
			pstmt.setString(3, notice.getContent());

			pstmt.setInt(4, notice.getN_num());

			pstmt.executeUpdate();
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateNotice() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 선택된 글 삭제하기
	public void deleteNotice(int num) {
		String sql = "delete from notice where n_num=?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteNotice() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	//

	// 커뮤니티 테이블의 레코드 개수
	public int getCommuListCount(String items, String text) {

		int x = 0;

		String sql;

		if (items == null && text == null)
			sql = "select  count(*) from commu";
		else
			sql = "SELECT   count(*) FROM commu where " + items + " like '%" + text + "%'";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);

		} catch (Exception ex) {
			System.out.println("getCommuListCount() 에러: " + ex);
		} finally {
			closeAll();
		}
		return x;
	}

	// 커뮤니티
	public ArrayList<CommuDTO> getCommuList(int page, int limit, String items, String text) {
		// 총 게시글수
		int total_record = getCommuListCount(items, text);
		int start = (page - 1) * limit; // 페이지에 따라서 보여줄 첫번째 게시글 번호
		int index = start + 1; // 0번은 없어서 + 1

		String sql;

		if (items == null && text == null) // 그냥 게시판을 클릭하면 전체게시판 불러오기
			sql = "select * from commu ORDER BY c_num DESC";
		else // 검색대상과 검색어가 있을경우
			sql = "SELECT  * FROM commu where " + items + " like '%" + text
					+ "%' ORDER BY c_num DESC ";

		// 리스트 생성
		ArrayList<CommuDTO> list = new ArrayList<CommuDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) { // 반복문 인덱스 번호에 맞는 레코드를 가져온다
				CommuDTO commu = new CommuDTO();
				commu.setC_num(rs.getInt("c_num"));
				commu.setM_id(rs.getString("m_id"));
				commu.setSubject(rs.getString("subject"));
				commu.setContent(rs.getString("content"));
				commu.setRegist_day(rs.getString("regist_day"));
				commu.setHit(rs.getInt("hit"));
				commu.setIp(rs.getString("ip"));
				list.add(commu); // 리스트에 추가

				// 인덱스 < (0+5) 1부터 5까지 59번 줄에서 1부터 시작
				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getCommuList() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	// 새로운 커뮤니티 글 쓰기
	public void insertCommu(CommuDTO commu) {
		try {
			conn = DBConnection.getConnection();

			String sql = "insert into commu values(?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commu.getC_num());
			pstmt.setString(2, commu.getM_id());
			pstmt.setString(3, commu.getSubject());
			pstmt.setString(4, commu.getContent());
			pstmt.setString(5, commu.getRegist_day());
			pstmt.setInt(6, commu.getHit());
			pstmt.setString(7, commu.getIp());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertCommu() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 선택된 커뮤 조회수 증가하기
	public void updateCommuHit(int c_num) {
		try {
			conn = DBConnection.getConnection();

			String sql = "select hit from commu where c_num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;

			sql = "update commu set hit=? where c_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit);
			pstmt.setInt(2, c_num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateCommuHit() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	// 선택된 커뮤 상세 내용 가져오기
	public CommuDTO getCommuByNum(int c_num, int page) {
		CommuDTO commu = null;

		updateCommuHit(c_num); //조회수 증가 실행
		String sql = "select * from commu where c_num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				commu = new CommuDTO();
				commu.setC_num(rs.getInt("c_num"));
				commu.setM_id(rs.getString("m_id"));
				commu.setSubject(rs.getString("subject"));
				commu.setContent(rs.getString("content"));
				commu.setRegist_day(rs.getString("regist_day"));
				commu.setHit(rs.getInt("hit"));
				commu.setIp(rs.getString("ip"));
			}

			return commu;
		} catch (Exception ex) {
			System.out.println("getCommuByNum() 에러 : " + ex);
		} finally {
			closeAll();
		}
		return null;
	}

	// 선택된 커뮤 내용 수정하기
	public void updateCommu(CommuDTO commu) {
		try {
			String sql = "update commu set m_id=?, subject=?, content=? where c_num=?";

			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			conn.setAutoCommit(false);

			pstmt.setString(1, commu.getM_id());
			pstmt.setString(2, commu.getSubject());
			pstmt.setString(3, commu.getContent());

			pstmt.setInt(4, commu.getC_num());

			pstmt.executeUpdate();
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateCommu() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}
	// 커뮤 글 지우기
	public void deleteCommu(int c_num) {
		String sql = "delete from commu where c_num=?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteCommu() 에러 : " + ex);
		} finally {
			closeAll();
		}
	}

	
	
	// 댓글 가져오기
		public ArrayList<CommentDTO> getCommentList(int c_num) {					
			// 리스트 생성
			ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
			
			String sql = "SELECT * FROM comment WHERE c_num="+c_num+"";


			try {
				
				conn = DBConnection.getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					CommentDTO commu = new CommentDTO();
					commu.setC_num(rs.getInt("c_num"));
					commu.setM_id(rs.getString("m_id"));
					commu.setContent(rs.getString("content"));
					commu.setDate(rs.getString("date"));
					
					list.add(commu); // 리스트에 추가					
				}
				return list;
			} catch (Exception ex) {
				System.out.println("getCommentList() 에러 : " + ex);
			} finally {
				closeAll();
			}
			return null;
		}

	// 댓글 쓰기
		public void insertComment(CommentDTO Comment) {
			try {
				conn = DBConnection.getConnection();
				String sql = "insert into comment values(?, ?, ?, ?)";

				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Comment.getC_num());
				pstmt.setString(2, Comment.getM_id());
				pstmt.setString(3, Comment.getContent());
				pstmt.setString(4, Comment.getDate());
	

				pstmt.executeUpdate();
			} catch (Exception ex) {
				System.out.println("insertCommu() 에러 : " + ex);
			} finally {
				closeAll();
			}
		}

}
