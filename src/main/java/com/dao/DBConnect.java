package com.dao;

import java.sql.Connection;
import java.sql.SQLException;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBConnect {

    private static HikariDataSource dataSource;

    // Hardcode fallback directly to 'hms' so it NEVER defaults to 'defaultdb'
    private static final String DB_URL = System.getenv("DB_URL") != null ? 
            System.getenv("DB_URL") : "jdbc:mysql://mysql-128f00f0-adityaraut1423-cb36.d.aivencloud.com:21832/hms?sslMode=REQUIRED";
            
    private static final String DB_USER = System.getenv("DB_USER") != null ? 
            System.getenv("DB_USER") : "avnadmin";

    private static final String DB_PASS = System.getenv("DB_PASS") != null ? 
            System.getenv("DB_PASS") : "AVNS_WGecgMGbYlxtnc4GW3O";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            HikariConfig config = new HikariConfig();
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");
            config.setJdbcUrl(DB_URL);
            config.setUsername(DB_USER);
            config.setPassword(DB_PASS);

            // Pool settings for stability
            config.setMaximumPoolSize(5);
            config.setMinimumIdle(1);
            config.setIdleTimeout(300000);
            config.setConnectionTimeout(30000);

            dataSource = new HikariDataSource(config);
            System.out.println("✅ HikariCP connected to hms database successfully!");

        } catch (Exception e) {
            System.err.println("❌ HikariCP Initialization Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConn() {
        try {
            if (dataSource != null && !dataSource.isClosed()) {
                return dataSource.getConnection();
            }
        } catch (SQLException e) {
            System.err.println("❌ Error getting connection: " + e.getMessage());
        }
        return null;
    }
}