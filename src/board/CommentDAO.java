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
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CommentDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 댓글 쓰기
	public void commentInsert(CommentDTO dto) {
		LocalDateTime localDateTime = LocalDateTime.now();
		Timestamp date = Timestamp.valueOf(localDateTime);
		try {
			conn = getConnection();
			String sql = "INSERT INTO comment VALUES(?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getC_num());
			pstmt.setString(2, dto.getM_id());
			pstmt.setString(3, dto.getContent());
			pstmt.setTimestamp(4, date);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			dbClose();
		}
	}

	// 댓글 불러오기
	public ArrayList<CommentDTO> commentSelect(int c_num)
			throws ClassNotFoundException, SQLException {
		ArrayList<CommentDTO> commList = new ArrayList<CommentDTO>();
		conn = getConnection();
		try {
			String sql = "SELECT * FROM comment WHERE c_num=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, c_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setM_id(rs.getString("m_id"));
				dto.setContent(rs.getString("content"));
				dto.setDate(rs.getTimestamp("date"));
				commList.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbClose();
		}
		return commList;
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
		if (conn != null)
			try {
				conn.close();
			} catch (Exception e) {
			}
	}

	// 디비 연결
	private Connection getConnection() throws ClassNotFoundException, SQLException {

		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/jsp_pj?serverTimezone=UTC&useSSL=false";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		return conn;
	}

}
