package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 글쓰기
	public void boardWrite(BoardDTO dto) {
		LocalDateTime localDateTime = LocalDateTime.now();
		Timestamp date = Timestamp.valueOf(localDateTime);
		try {
			con = getConnection();
			String sql = "INSERT INTO commu VALUES(0,?,?,?,0,?)"; // c_num이랑 hit 0
			pstmt = con.prepareStatement(sql);
		
			pstmt.setString(1, dto.getM_id());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setTimestamp(4, date);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
	}

	// 지우기
	public void contentDelete(int c_num) {
		try {
			con = getConnection();
			
			
			String sql = "DELETE FROM commu WHERE c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			pstmt.executeUpdate();
			sql = "DELTE FROM comment WHERE c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			pstmt.executeUpdate();
			sql = "ALTER TABLE commu AUTO_INCREMENT=1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			
			// 중간에 빠지는 데이터 재정렬해서 순번 다시 매기기
			sql = "SET @CNT = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			sql = "UPDATE commu SET commu.c_num = @CNT:=@CNT+1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
	}

	// 수정
	public void contentUpdate(int c_num, BoardDTO dto) {

		try {
			con = getConnection();
			String sql = "UPDATE commu SET subject=?, content=? WHERE c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, c_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}

	}

	// 조회수 증가
	public void contentViews(int c_num) {
		try {
			con = getConnection();
			String sql = "UPDATE commu SET hit=hit+1 WHERE c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
	}

	// 상세보기
	public BoardDTO contentSelect(int c_num) {
		BoardDTO dto = new BoardDTO();
		try {
			con = getConnection();
			String sql = "SELECT * FROM commu WHERE c_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setM_id(rs.getString("m_id"));
				dto.setSubject(rs.getString("subject"));
				dto.setHit(rs.getInt("hit"));
				//dto.setFile(rs.getString("file"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setContent(rs.getString("content"));

			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}

		return dto;
	}

	// 리스트 생성
	public ArrayList<BoardDTO> boardSelect(int type) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			con = getConnection();
			String sql = "SELECT * FROM commu ORDER BY c_num DESC";
			pstmt = con.prepareStatement(sql);
			//pstmt.setInt(1, type);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setC_num(Integer.parseInt(rs.getString("c_num")));
				dto.setM_id(rs.getString("m_id"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				//dto.setFile(rs.getString("file"));
				dto.setHit(rs.getInt("hit"));
				dto.setDate(rs.getTimestamp("date"));
				list.add(dto);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}

		return list;
	}

	// 디비 닫기
	private void dbClose() {
		if (rs != null)
			try {
				rs.close();
			} catch (Exception e) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		if (con != null)
			try {
				con.close();
			} catch (Exception e) {
			}
	}

	// 게시판 디비연결
	private Connection getConnection() throws Exception {

		// 커넥션 풀 (Connection Pool)

		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/jsp_pj?serverTimezone=UTC&useSSL=false";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		return conn;
	}
}
