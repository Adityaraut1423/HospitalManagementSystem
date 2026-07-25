package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Import HttpSession
import org.json.JSONObject;

@WebServlet("/api/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();

        try {
            // Read JSON input body from client
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject jsonInput = new JSONObject(sb.toString());
            String email = jsonInput.optString("email", "").trim();
            String password = jsonInput.optString("password", "").trim();

            if (email.isEmpty() || password.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("message", "Email and password are required.");
                out.print(jsonResponse.toString());
                return;
            }

            // Authenticate user role
            String role = authenticateUser(email, password);

            if (role != null) {
                // ========================================================
                // 🔑 CRITICAL FIX: CREATE HTTP SESSION FOR JSP SECURITY
                // ========================================================
                HttpSession session = request.getSession(true);
                
                if ("admin".equalsIgnoreCase(role)) {
                    session.setAttribute("admin", email); // Satisfies (admin == null) check in admin-dashboard.jsp
                } else if ("doctor".equalsIgnoreCase(role)) {
                    session.setAttribute("doctor", email);
                } else if ("patient".equalsIgnoreCase(role) || "user".equalsIgnoreCase(role)) {
                    session.setAttribute("user", email);
                }

                response.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.put("status", "success");
                jsonResponse.put("token", session.getId()); // Pass session ID as token
                jsonResponse.put("role", role);
                jsonResponse.put("message", "Login successful!");
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                jsonResponse.put("message", "Invalid email or password.");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("message", "Server error: " + e.getMessage());
        }

        out.print(jsonResponse.toString());
        out.flush();
    }

    private String authenticateUser(String email, String password) {
        if (email.equalsIgnoreCase("admin@hospital.com") && password.equals("admin123")) {
            return "admin";
        } else if (email.equalsIgnoreCase("doctor@hospital.com") && password.equals("doc123")) {
            return "doctor";
        } else if (email.equalsIgnoreCase("patient@hospital.com") && password.equals("patient123")) {
            return "patient";
        }
        return null;
    }
}