package controller.auth;

import dao.DatabaseCleanupScheduler;

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
        // Cleanup resources or shut down executor service if needed
        System.out.println("Application is shutting down.");
    }
}
