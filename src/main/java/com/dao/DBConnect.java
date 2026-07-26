package com.dao;

import java.sql.Connection;
import java.sql.SQLException;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBConnect {

    private static HikariDataSource dataSource;

    private static final String DEFAULT_URL = "jdbc:mysql://mysql-128f00f0-adityaraut1423-cb36.d.aivencloud.com:21832/hms?sslMode=REQUIRED";
    private static final String DEFAULT_USER = "avnadmin";
    private static final String DEFAULT_PASS = "AVNS_WGecgMGbYlxtnc4GW3O";

    private static synchronized void initPool() {
        if (dataSource != null && !dataSource.isClosed()) {
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            
            // Read either DB_PASSWORD or DB_PASS from Render environment
            String pass = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : System.getenv("DB_PASS");

            if (url == null || url.trim().isEmpty()) {
                url = DEFAULT_URL;
            }
            if (user == null || user.trim().isEmpty()) {
                user = DEFAULT_USER;
            }
            if (pass == null || pass.trim().isEmpty()) {
                pass = DEFAULT_PASS;
            }

            HikariConfig config = new HikariConfig();
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            config.setJdbcUrl(url);
            config.setUsername(user);
            config.setPassword(pass);

            // Pool settings optimized for Render free tier & cloud databases
            config.setMaximumPoolSize(5);
            config.setMinimumIdle(1);
            config.setIdleTimeout(300000);       // 5 minutes
            config.setConnectionTimeout(30000);  // 30 seconds
            config.setMaxLifetime(1800000);      // 30 minutes
            config.setValidationTimeout(5000);   // 5 seconds test query timeout

            // Keep connections alive during cold starts
            config.setConnectionTestQuery("SELECT 1");

            dataSource = new HikariDataSource(config);
            System.out.println("✅ HikariCP initialized successfully and connected to HMS database.");

        } catch (Exception e) {
            System.err.println("❌ HikariCP Initialization Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    static {
        initPool();
    }

    public static Connection getConn() {
        try {
            // Re-initialize pool if it crashed or closed
            if (dataSource == null || dataSource.isClosed()) {
                initPool();
            }

            if (dataSource != null) {
                Connection conn = dataSource.getConnection();
                // Ensure connection borrowed from pool is active and usable
                if (conn != null && !conn.isClosed()) {
                    return conn;
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error borrowing connection from HikariCP pool: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("🛑 HikariCP connection pool closed.");
        }
    }
}