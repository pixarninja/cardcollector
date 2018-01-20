<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
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
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Site Information</h2><br>
            <h4>
                <p>Welcome to Card<span class="glyphicon glyphicon-globe" id="small-icon"></span>Collector, your personal Magic The Gathering collection logbook!</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h3>Contact Information<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
                <div class="row">
                    <div class="col-xs-3 col-md-2">
                        <p>Email</p>
                    </div>
                    <div class="col-xs-9 col-md-10">
                        fake@email.com<br><br>
                    </div>
                </div>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h3>Finding Cards<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
            </h4>
            <h3>Creating A Collection<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
            </h4>
            <h3>Logging Decks<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h4>
                <h3>Making Friends<hr></h3>
                <h4>
                    <p>Derp...</p>
                    <br>
                </h4>
                <h3>Writing Comments<hr></h3>
                <h4>
                    <p>Derp...</p>
                    <br>
                </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>