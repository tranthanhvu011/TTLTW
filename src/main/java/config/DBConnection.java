package config;

import java.util.Properties;

public class DBConnection {
    private static Properties prop = new Properties();

    static {
        try {
            prop.load(DBConnection.class.getClassLoader().getResourceAsStream("DB.properties"));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String host = prop.getProperty("db.host");
    public static String port = prop.getProperty("db.port");
    public static String dbName = prop.getProperty("db.name");
    public static String username = prop.getProperty("db.username");
    public static String pass = prop.getProperty("db.password");

}
