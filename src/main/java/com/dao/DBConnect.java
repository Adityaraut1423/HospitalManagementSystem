package com.dao;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBConnect {

    private static HikariDataSource dataSource;

    // 1. Read DB_URL from environment; fallback to local MySQL URL
    private static final String DB_URL = System.getenv("DB_URL") != null ?
            System.getenv("DB_URL") : "jdbc:mysql://mysql-128f00f0-adityaraut1423-cb36.d.aivencloud.com:21832/defaultdb?useSSL=true&trustServerCertificate=true";
            
    // 2. Read DB_USER from environment; fallback to Aiven username "avnadmin", then "root"
    private static final String DB_USER = System.getenv("DB_USER") != null ?
            System.getenv("DB_USER") : "avnadmin";

    // 3. Read DB_PASSWORD (or DB_PASS) from environment; fallback to local default
    private static final String DB_PASS = System.getenv("DB_PASSWORD") != null ?
            System.getenv("DB_PASSWORD") : (System.getenv("DB_PASS") != null ? System.getenv("DB_PASS") : "AVNS_WGecgMGbYlxtnc4GW3O");

    static {
        try {
            HikariConfig config = new HikariConfig();

            // Database Configuration
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            config.setJdbcUrl(DB_URL);
            config.setUsername(DB_USER);
            config.setPassword(DB_PASS);

            // Connection Pool Tuning (Optimized for Render Free Tier)
            config.setMaximumPoolSize(5);           // Cap max connections
            config.setMinimumIdle(1);               // Keep 1 warm connection
            config.setIdleTimeout(300000);          // Close idle connections after 5 mins
            config.setConnectionTimeout(30000);     // Wait up to 30s to acquire connection
            config.setMaxLifetime(1800000);          // Max connection lifespan (30 mins)

            // MySQL Performance Optimizations
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

            dataSource = new HikariDataSource(config);
            System.out.println("✅ HikariCP Connection Pool initialized successfully.");

        } catch (Exception e) {
            System.err.println("❌ Failed to initialize HikariCP Connection Pool: " + e.getMessage());
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
            System.err.println("❌ Error borrowing connection from HikariCP pool: " + e.getMessage());
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
            System.out.println("🛑 HikariCP Connection Pool closed.");
        }
    }
}