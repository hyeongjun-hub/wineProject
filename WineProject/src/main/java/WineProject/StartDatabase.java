package WineProject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class StartDatabase {

	public static void main(String[] args) {
		Connection conn = null;
		Statement stmt = null;

		try {
			String jdbcDriver = "jdbc:mariadb://localhost:3306/wineProject";
			String dbUser = "root";
			String dbPass = "1221";
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();

			String query3 = "insert into winegrade values ('00005','5th', 0.1);";

			stmt.executeUpdate(query3);

			System.out.println("table insert successed");

//			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
