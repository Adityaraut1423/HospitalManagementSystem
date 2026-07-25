package com.util;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DBCleanupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // App started
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Cleaning up JDBC drivers and MySQL cleanup thread...");

        // 1. Deregister JDBC Drivers
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistered JDBC driver: " + driver);
            } catch (SQLException e) {
                System.err.println("Error deregistering driver: " + driver + " - " + e.getMessage());
            }
        }

        // 2. Shut down the MySQL Abandoned Connection Cleanup Thread
        try {
            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL AbandonedConnectionCleanupThread successfully stopped.");
        } catch (Exception e) {
            System.err.println("Failed to shutdown MySQL cleanup thread: " + e.getMessage());
        }
    }
}