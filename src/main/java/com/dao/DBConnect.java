package com.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBConnect {

    private static HikariDataSource dataSource;

    // ✅ FIX: Use environment variables with fallback defaults
    private static final String DB_URL = System.getenv("DB_URL") != null ?
            System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/hms?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DB_USER = System.getenv("DB_USER") != null ?
            System.getenv("DB_USER") : "root";
    private static final String DB_PASS = System.getenv("DB_PASS") != null ?
            System.getenv("DB_PASS") : "root";

    static {
        try {
            HikariConfig config = new HikariConfig();

            // Database Configuration
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            config.setJdbcUrl(DB_URL);
            config.setUsername(DB_USER);
            config.setPassword(DB_PASS);

            // Connection Pool Tuning
            config.setMaximumPoolSize(10);          // Maximum open connections in pool
            config.setMinimumIdle(5);               // Minimum idle connections to keep warm
            config.setIdleTimeout(300000);          // Close idle connections after 5 minutes
            config.setConnectionTimeout(30000);     // Wait up to 30s to acquire connection
            config.setMaxLifetime(1800000);         // Maximum connection lifespan (30 mins)

            // MySQL Performance Optimizations
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

            dataSource = new HikariDataSource(config);
            System.out.println("✅ HikariCP Connection Pool initialized successfully.");

        } catch (Exception e) {
            System.err.println("❌ Failed to initialize HikariCP Connection Pool");
            e.printStackTrace();
        }
    }

    /**
     * Borrows an active database connection from the HikariCP pool.
     */
    public static Connection getConn() {
        try {
            if (dataSource != null) {
                return dataSource.getConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Closes the entire pool upon server shutdown.
     */
    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}