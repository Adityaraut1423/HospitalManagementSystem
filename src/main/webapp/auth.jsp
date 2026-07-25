<%@ page import="com.model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);

    if (sessionObj == null || sessionObj.getAttribute("user") == null) {
        response.sendRedirect("user-login.jsp?msg=Please login first");
        return;
    }

    User user = (User) sessionObj.getAttribute("user");
%>
