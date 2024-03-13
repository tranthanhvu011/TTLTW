package config;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;

public class JDBIConnector {

    private static Jdbi jdbi;


    public static void connect() {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL("jdbc:mysql://" + DBConnection.host + ":" + DBConnection.port + "/" + DBConnection.dbName);
        dataSource.setUser(DBConnection.username);
        dataSource.setPassword(DBConnection.pass);

        try {
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        jdbi = Jdbi.create(dataSource);
    }


    private JDBIConnector() {
    }

    public static Jdbi me() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }

}


