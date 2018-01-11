<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="selectionInfo" class="beans.SelectionInfo" scope="request"/>
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
    int selectionEntries = 0;
    int selectionId = 1;
    SelectionInfo selection;
    while((selection = (SelectionInfo) selectionInfo.getSelectionById(selectionId)) != null) {
        String user = selection.getUser();
        if(user.equals(username)) {
            selectionEntries++;
        }
        selectionId++;
    }
%>
<%@include file="header.jsp"%>
<!-- Add code here -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Playmat</h2><br>
            <h4>
                <p>Below is the playmat.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <div id="playmat">Playmat!</div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>