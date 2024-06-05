package dao;

import config.JDBIConnector;
import org.jdbi.v3.core.Jdbi;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class DatabaseCleanupScheduler {
    private static final Jdbi jdbi = JDBIConnector.me();

    public static void startScheduledCleanUp() {
        ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();
        executorService.scheduleAtFixedRate(DatabaseCleanupScheduler::deleteOldRecords, 0, 180, TimeUnit.SECONDS);
    }
    private static void deleteOldRecords() {
        String sql = "DELETE FROM logging_login WHERE timestamp < NOW() - INTERVAL 30 MINUTE";
        jdbi.useHandle(handle -> {
            int affectedRows = handle.createUpdate(sql).execute();
            System.out.println("Deleted " + affectedRows + " old records.");
        });
    }
    public static void main(String[] args) {
        startScheduledCleanUp();
    }
}
