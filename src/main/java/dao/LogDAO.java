package dao;

import config.JDBIConnector;
import model.Log;

import java.util.List;

public class LogDAO {
    public int insertLog(int userID, String ipAddress, String level, String beforeData, String afterData, String action) {
        String query = "INSERT INTO log (userID, ipAddress, level, beforeData, afterData, action) VALUES (?, ?, ?, ?, ?, ?)";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, userID)
                        .bind(1, ipAddress)
                        .bind(2, level)
                        .bind(3, beforeData)
                        .bind(4, afterData)
                        .bind(5, action)
                        .execute()
        );
        return result;
    }
    public List<Log> getAllLog() {
        String query = "SELECT * FROM log";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(Log.class)
                        .list()
        );
    }
    public boolean deleteLog(int id) {
        String query = "DELETE FROM log WHERE id = ?";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, id)
                        .execute()
        );
        return result > 0;
    }
    public static void main(String[] args) {
        LogDAO logDAO = new LogDAO();
       logDAO.insertLog(1,"ddsds","ddsds","ddsds","ddsds","ddsds");
    System.out.println(logDAO.getAllLog());
    }
}
