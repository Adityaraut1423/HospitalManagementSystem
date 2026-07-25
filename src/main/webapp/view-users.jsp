<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, com.dao.*, com.model.*" %>
<%@ page session="true" %>
<%
    // 1. Session Authentication Check
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // 2. Fetch All Registered Users Safely from Database
    List<User> userList = new ArrayList<>();
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBConnect.getConn();

        if (conn == null) {
            System.err.println("[DB ERROR] DBConnect.getConn() returned NULL! Check database credentials.");
        } else {
            // Priority 1: Check standard unified user tables
            String[] possibleTables = {"user_details", "user_dtls", "users", "user"};
            String targetTable = null;

            DatabaseMetaData dbmd = conn.getMetaData();
            for (String tableName : possibleTables) {
                rs = dbmd.getTables(null, null, tableName, null);
                if (rs.next()) {
                    targetTable = tableName;
                    rs.close();
                    break;
                }
                if (rs != null) rs.close();
            }

            if (targetTable != null) {
                // Query found table dynamically
                String sql = "SELECT * FROM " + targetTable + " ORDER BY id DESC";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));

                    // Flexible Column Mapping for Name
                    try { u.setName(rs.getString("name")); } 
                    catch (SQLException e1) {
                        try { u.setName(rs.getString("full_name")); } 
                        catch (SQLException e2) { u.setName(rs.getString("fullname")); }
                    }

                    // Email Mapping
                    try { u.setEmail(rs.getString("email")); } 
                    catch (SQLException e) { u.setEmail("N/A"); }

                    // Flexible Column Mapping for Phone/Mobile
                    try { u.setMobile(rs.getString("mobile")); } 
                    catch (SQLException e1) {
                        try { u.setMobile(rs.getString("phno")); } 
                        catch (SQLException e2) {
                            try { u.setMobile(rs.getString("phone")); } 
                            catch (SQLException e3) { u.setMobile("N/A"); }
                        }
                    }

                    // Role Mapping
                    try { u.setRole(rs.getString("role")); } 
                    catch (SQLException e) { u.setRole("User"); }

                    userList.add(u);
                }
            } else {
                System.out.println("[DB INFO] No standard user table found. Trying fallback scan for doctor & patient tables...");
                
                // Priority 2: Fallback union query if users, doctors, and patients are in separate tables
                String unionSql = "SELECT id, name, email, mobno AS mobile, 'Patient' AS role FROM patient " +
                                 "UNION ALL " +
                                 "SELECT id, fullName AS name, email, mobNo AS mobile, 'Doctor' AS role FROM doctor";
                try {
                    ps = conn.prepareStatement(unionSql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        User u = new User();
                        u.setId(rs.getInt("id"));
                        u.setName(rs.getString("name"));
                        u.setEmail(rs.getString("email"));
                        u.setMobile(rs.getString("mobile"));
                        u.setRole(rs.getString("role"));
                        userList.add(u);
                    }
                } catch (SQLException ex) {
                    System.err.println("[DB ERROR] Fallback union query failed: " + ex.getMessage());
                }
            }

            System.out.println("[SUCCESS] Total Users Loaded in view-users.jsp: " + userList.size());
        }
    } catch (Exception e) {
        System.err.println("[EXCEPTION] Error loading users in view-users.jsp: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All System Users | Hospital Management</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts (Inter) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #334155;
        }

        .page-header {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #ffffff;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-bottom: 4px solid #0284c7;
        }

        .card-custom {
            background: #ffffff;
            border: none;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        }

        .table-custom th {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.78rem;
            letter-spacing: 0.5px;
            padding: 12px 16px;
        }

        .table-custom td {
            padding: 14px 16px;
            vertical-align: middle;
            font-size: 0.9rem;
        }

        .role-badge {
            font-weight: 600;
            padding: 0.35rem 0.65rem;
            border-radius: 50px;
            font-size: 0.75rem;
            text-transform: capitalize;
        }

        .role-admin { background-color: #fee2e2; color: #991b1b; }
        .role-doctor { background-color: #e0f2fe; color: #075985; }
        .role-patient { background-color: #dcfce7; color: #166534; }
        .role-default { background-color: #f1f5f9; color: #475569; }
    </style>
</head>
<body>

<!-- Page Header -->
<div class="page-header">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <h3 class="fw-bold mb-1"><i class="fa-solid fa-users-gear me-2 text-info"></i>System Users Directory</h3>
            <p class="text-slate-300 mb-0 opacity-75 small">Manage all registered administrators, doctors, and patient accounts</p>
        </div>
        <div>
            <a href="admin-dashboard.jsp" class="btn btn-outline-light btn-sm px-3">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container mb-5">
    <div class="card card-custom p-4">
        
        <!-- Search Bar and Count Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h5 class="fw-bold text-dark mb-0">Registered Accounts (<%= userList.size() %>)</h5>
            <div class="w-25">
                <input type="text" id="userSearch" class="form-control form-control-sm" placeholder="Search by name, email or role...">
            </div>
        </div>

        <!-- Users Data Table -->
        <div class="table-responsive">
            <table class="table table-hover table-custom mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email Address</th>
                        <th>Mobile</th>
                        <th>System Role</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody id="userTableBody">
                    <% if (userList.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">
                                <i class="fa-solid fa-folder-open fa-2x mb-2 d-block opacity-50"></i>
                                No registered users found in the system. Check your Eclipse Console log for database details.
                            </td>
                        </tr>
                    <% } else { 
                        for (User u : userList) { 
                            String roleClass = "role-default";
                            String r = u.getRole() != null ? u.getRole().toLowerCase() : "";
                            if (r.contains("admin")) roleClass = "role-admin";
                            else if (r.contains("doctor")) roleClass = "role-doctor";
                            else if (r.contains("patient") || r.contains("user")) roleClass = "role-patient";
                    %>
                        <tr>
                            <td class="fw-bold text-secondary">#<%= u.getId() %></td>
                            <td class="fw-semibold text-dark"><%= u.getName() != null ? u.getName() : "N/A" %></td>
                            <td><%= u.getEmail() != null ? u.getEmail() : "N/A" %></td>
                            <td><%= u.getMobile() != null ? u.getMobile() : "N/A" %></td>
                            <td>
                                <span class="role-badge <%= roleClass %>">
                                    <%= u.getRole() != null ? u.getRole() : "User" %>
                                </span>
                            </td>
                            <td class="text-end">
                                <a href="edit-user.jsp?id=<%= u.getId() %>" class="btn btn-sm btn-outline-primary me-1" title="Edit User">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <a href="DeleteUserServlet?id=<%= u.getId() %>" class="btn btn-sm btn-outline-danger" 
                                   onclick="return confirm('Are you sure you want to delete this user?');" title="Delete User">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    <%   } 
                       } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Search Filter Script -->
<script>
    document.getElementById('userSearch').addEventListener('keyup', function() {
        var searchValue = this.value.toLowerCase();
        var rows = document.querySelectorAll('#userTableBody tr');

        rows.forEach(function(row) {
            var text = row.innerText.toLowerCase();
            if (text.indexOf(searchValue) > -1) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>

</body>
</html>