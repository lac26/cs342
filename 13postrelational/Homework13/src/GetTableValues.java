import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by lac26 on 5/9/2017.
 */
public class GetTableValues {

    public static void execute(Connection connection) throws SQLException {
        Statement jdbcStatement = connection.createStatement();
        ResultSet resultSet2 = jdbcStatement.executeQuery("SELECT name, year, TO_CHAR(rank)  FROM Movie WHERE id = 92616");
        if(resultSet2.next()) {
        System.out.println(resultSet2.getString(1) + "\n"
                + resultSet2.getInt(2) + "\n"
                + resultSet2.getString(3));

        }
        resultSet2.close();

    }
}
