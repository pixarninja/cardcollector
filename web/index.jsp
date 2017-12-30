<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = (String)request.getAttribute("username");%>
<jsp:useBean id="recentReview" class="beans.RecentReview" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%@include file="header.jsp"%>
<!-- Add code here -->
<%
    Exception ex = (Exception)request.getAttribute("error");
    if(ex != null) {
        %>ERROR! Stacktrace: <%=ex%><%
    }
    int rank;
    int cap = 50;
%>
<div>
    <div class="container-fluid">
        <div class="row" align="left">
            <!-- Ad Bar -->
            <div class="hidden-xs col-sm-2">
                <div style="background-color:black;height:100%;">
                    Ad-Bar!
                </div>
            </div>
            <!-- Content -->
            <div id="content" class="col-xs-8">
                <div class="col-xs-12 col-md-6">
                <h1>Leaderboards</h1><br>
                <div class="panel panel-default" align="center">
                    <table class="table table-bordered">
                        <thead id="head_bar">
                            <tr>
                                <th>Deck Title</th>
                                <th>Username</th>
                                <th>Win/Loss Ratio</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
                <div class="col-xs-12 col-md-6">
                    <h1>Recent Reviews</h1><br>
                    <div class="panel panel-default" align="center">
                        <table class="table table-bordered">
                            <thead id="head_bar">
                                <tr>
                                    <th>Card Name</th>
                                    <th>Username</th>
                                    <th>Review</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    rank = 1;
                                    RecentReview review = (RecentReview) recentReview.getReview(rank);
                                    while(rank <= cap && review != null) {
                                %>
                                <tr>
                                </tr>
                                <%
                                        rank++;
                                        review = (RecentReview) recentReview.getReview(rank);
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Ad Bar -->
            <div class="hidden-xs col-sm-2">
                <div style="background-color:black;height:100%;">
                    Ad-Bar!
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
