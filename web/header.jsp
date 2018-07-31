<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!DOCTYPE html>
<%
    String font = "Quicksand|Poiret+One";
%>
<%@page import="beans.*"%>
<jsp:useBean id="headerNotificationInfo" class="beans.NotificationInfo" scope="request"/>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Card Collector</title>
        <link rel="shortcut icon" href="http://cardcollector.us-east-1.elasticbeanstalk.com/images/webicon.ico" type="image/x-icon">
        <link rel="icon" href="http://cardcollector.us-east-1.elasticbeanstalk.com/images/webicon.ico" type="image/x-icon">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=<%=font%>" rel="stylesheet">
        <form id="indexForm" action="CardServlet" method="POST">
            <input type="hidden" name="action" value="index">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="yourCollectionsForm" action="CollectionServlet" method="POST">
            <input type="hidden" name="action" value="your_collections">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="yourDecksForm" action="DeckServlet" method="POST">
            <input type="hidden" name="action" value="your_decks">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="profileForm" action="UserServlet" method="POST">
            <input type="hidden" name="action" value="profile">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="playmatForm" action="PlaymatServlet" method="POST">
            <input type="hidden" name="action" value="playmat">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="notificationsForm" action="UserServlet" method="POST">
            <input type="hidden" name="action" value="notifications">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="searchForm" action="SearchServlet" method="POST">
            <input type="hidden" name="action" value="search">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="helpForm" action="UserServlet" method="POST">
            <input type="hidden" name="action" value="help">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="loginForm" action="UserServlet" method="POST">
            <input type="hidden" name="action" value="login">
        </form>
        <form id="logoutForm" action="UserServlet" method="POST">
            <input type="hidden" name="action" value="logout">
        </form>
    </head>
    <body onload="refresh();">
        <%
            int countSpecial = 1;
            int notifications = 0;
            NotificationInfo headerNotification;
            while((headerNotification = headerNotificationInfo.getNotificationByNum(countSpecial)) != null) {
                if(headerNotification.getOwner().equals(username)) {
                    notifications++;
                }
                countSpecial++;
            }
        %>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container-fluid">
                <div class="hidden-xs hidden-sm col-md-1"></div>
                <div class="col-xs-12 col-md-10">
                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
                        <!-- icons and text and lines -->
                        <div id="custom-navbar" class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                            <a href="#" class="navbar-brand" style="position: relative; top: 1px;font-size: 24px;" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector</a>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a id="menu-item" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Your Collections<hr>
                                    </a>
                                </li>
                                <li>
                                    <a id="menu-item" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Your Decks<hr>
                                    </a>
                                </li>
                                <li>
                                    <a id="menu-item" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Your Profile<hr>
                                    </a>
                                </li>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat<hr>
                                    </a>
                                </li>
                                -->
                                <li>
                                    <a id="menu-item" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-question-sign"></span>&nbsp;&nbsp;Help<hr>
                                    </a>
                                </li>
                                <%if(username != null && !username.equals("")) {%>
                                <li>
                                    <a id="menu-item" title="Notifications (<%=notifications%>)" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;Notifications (<%=notifications%>)<hr>
                                    </a>
                                </li>
                                <%}%>
                                <li>
                                    <a id="menu-item" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        <span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Advanced Search<hr>
                                    </a>
                                </li>
                                <%if(username == null || username.equals("")) {%>
                                <li>
                                    <a id="menu-item" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login<hr>
                                    </a>
                                </li>
                                <%} else {%>
                                <li>
                                    <a id="menu-item" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;Logout<hr>
                                    </a>
                                </li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                    <!-- icons and text -->
                    <div class="hidden-xs hidden-sm hidden-md col-lg-12">
                        <div id="custom-navbar" class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                            <a href="#" class="navbar-brand" style="position: relative; top: 0px;font-size: 22px;" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="small-icon"></span>Collector</a>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a id="menu-item" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book" id="small-icon"></span>&nbsp;&nbsp;Collections
                                    </a>
                                </li>
                                <li>
                                    <a id="menu-item" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox" id="small-icon"></span>&nbsp;&nbsp;Decks
                                    </a>
                                </li>
                                <li>
                                    <a id="menu-item" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user" id="small-icon"></span>&nbsp;&nbsp;Profile
                                    </a>
                                </li>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight" id="small-icon"></span>&nbsp;Playmat
                                    </a>
                                </li>
                                -->
                                <li>
                                    <a id="menu-item" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-question-sign" id="small-icon"></span>&nbsp;&nbsp;Help
                                    </a>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <%if(username != null && !username.equals("")) {%>
                                <li>
                                    <a id="menu-item" title="Notifications (<%=notifications%>)" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift" id="small-icon"></span>&nbsp;&nbsp;(<%=notifications%>)
                                    </a>
                                </li>
                                <%}%>
                                <li>
                                    <a id="menu-item" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        <span class="glyphicon glyphicon-search" id="small-icon"></span>&nbsp;&nbsp;Search
                                    </a>
                                </li>
                                <%if(username == null || username.equals("")) {%>
                                <li>
                                    <a id="menu-item" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login
                                    </a>
                                </li>
                                <%} else {%>
                                <li>
                                    <a id="menu-item" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;Logout
                                    </a>
                                </li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                    <!-- only icons -->
                    <div class="hidden-xs col-sm-12 hidden-lg">
                        <div id="custom-navbar" class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                            <a href="#" class="navbar-brand" style="position: relative; top: 0px;font-size: 26px;" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="medium-icon"></span>Collector</a>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a id="menu-item" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>
                                    </a>
                                </li>
                                <li>
                                    <a id="menu-item" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>
                                    </a>
                                </li>
                                <li>
                                    <a id="menu-item" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </a>
                                </li>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>
                                    </a>
                                </li>
                                -->
                                <li>
                                    <a id="menu-item" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-question-sign"></span>
                                    </a>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <%if(username != null && !username.equals("")) {%>
                                <li>
                                    <a id="menu-item" title="Notifications (<%=notifications%>)" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;(<%=notifications%>)
                                    </a>
                                </li>
                                <%}%>
                                <li>
                                    <a id="menu-item" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        <span class="glyphicon glyphicon-search"></span>
                                    </a>
                                </li>
                                <%if(username == null || username.equals("")) {%>
                                <li>
                                    <a id="menu-item" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-log-in"></span>
                                    </a>
                                </li>
                                <%} else {%>
                                <li>
                                    <a id="menu-item" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        <span class="glyphicon glyphicon-log-out"></span>
                                    </a>
                                </li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="hidden-xs hidden-sm col-md-1"></div>
            </nav>
        </div>
    <div class="container-fluid">
        <div class="row" align="left">
            <!-- Ad Bar -->
            <div class="hidden-xs col-sm-1" style="background:url(images/wallart.jpg);height: 100%;position: fixed;background-position: center-x;"></div>
            <div class="hidden-xs col-sm-1"></div>
            <div id="content" class="col-xs-12 col-sm-10" style="background-color: black;background-repeat: repeat;min-height: 100%;">