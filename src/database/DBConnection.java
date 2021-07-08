package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	// 디비 연결 클래스 리턴값이 커넥션 conn
	public static Connection getConnection() throws SQLException, ClassNotFoundException {

		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/jsp_pj?useSSL=false";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		return conn;
	}
}
