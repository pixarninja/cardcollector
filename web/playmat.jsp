<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = null;
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    boolean found = false;

    if( cookies != null ) {
       for (int i = 0; i < cookies.length; i++) {
          cookie = cookies[i];
          if(cookie.getName().equals("username")) {
              username = cookie.getValue();
              found = true;
              break;
          }
       }
    }
    if(!found) {
        if((String)request.getAttribute("username") == null) {
            username = request.getParameter("username");
        }
        else {
            username = (String)request.getAttribute("username");
        }
    }
    if(username == null || username.equals("null")) {
        username = "";
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