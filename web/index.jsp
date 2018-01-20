<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username;
    String buffer;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
    buffer = username;
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Add code here -->
<%
    Exception ex = (Exception)request.getAttribute("error");
    if(ex != null) {
        %><h2>Database Error<hr></h2><h4>Stacktrace: <%=ex%></h4><br><%
    }
    int rank;
    int cap = 50;
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <%=username%>
    </div>
</div>
<%@include file="footer.jsp"%>