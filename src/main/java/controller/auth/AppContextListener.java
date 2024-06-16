package controller.auth;

import dao.DatabaseCleanupScheduler;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DatabaseCleanupScheduler.startScheduledCleanUp();
        System.out.println("Scheduled cleanup has started.");
    }
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Application is shutting down.");
            AbandonedConnectionCleanupThread.checkedShutdown();

    }

}

