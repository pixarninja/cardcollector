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
        <link rel="shortcut icon" href="images/webicon.ico" type="image/x-icon">
        <link rel="icon" href="http://cardcollector-webapp.us-east-1.elasticbeanstalk.com/images/webicon.ico" type="image/x-icon">
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
                <div class="col-xs-12">
                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
                        <!-- icons and text and lines XS -->
                        <div id="custom-navbar" class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse" style="position: relative;top: 0px;left: 44px;">
                                <span class="glyphicon glyphicon-list" style="font-size: 18px;position: relative;top: 0px;"></span>
                            </button>
                            <form action="SearchServlet" method="POST" style="position:relative;top: 9px;left: -20px;">
                                <input type="hidden" name="username" value="pixarninja">
                                <input type="hidden" name="action" value="cards_quick">
                                <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -15px;left: -24px;" onclick="document.getElementById('indexForm').submit();"><span class="glyphicon glyphicon-globe" style="font-size: 38px;"></span></a>
                                <div style="position: absolute;left: 42px;">
                                    <input name="query" title="Quick search by name, type, text, flavor text, artist, or year" type="text" placeholder="Your Quick Search..." style="background-color: black !important;color: white;width:65%;border: none !important;padding: 8px;border-radius: 10px;">
                                    <button title="Quick Search" id="form-submit" type="submit" style="width: 3.5em !important;height: 2.4em;">Go!</button>
                                </div>
                            </form>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <div class="btn-group" style="position:relative;top: 7px;">
                                    <button type="button" class="btn btn-lg" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Your Collections
                                    </button>
                                </div>
                                <hr>
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Your Decks
                                    </button>
                                </div>
                                <hr>
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Your Profile
                                    </button>
                                </div>
                                <hr>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat<hr>
                                    </a>
                                </li>
                                -->
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;&nbsp;Help
                                    </button>
                                </div>
                                <hr>
                                <%if(username != null && !username.equals("")) {%>
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Notifications" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;Notifications (<%=notifications%>)
                                    </button>
                                </div>
                                <hr>
                                <%}%>
                                <%if(username == null || username.equals("")) {%>
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;Login
                                    </button>
                                </div>
                                <hr>
                                <%} else {%>
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;Logout
                                    </button>
                                </div>
                                <hr>
                                <%}%>
                                <div class="btn-group" style="position:relative;top: 2px;">
                                    <button type="button" class="btn btn-lg" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Advanced Search
                                    </button>
                                    <!--<button type="button" class="btn btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">&nbsp;
                                        <span class="caret" style="position: relative;left: -5px;"></span>&nbsp;
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu" style="border-right: 1px solid white !important;border-left: 1px solid white !important;border-bottom: 1px solid white !important;border-bottom-right-radius: 10px;border-bottom-right-radius: 10px;border-bottom-left-radius: 10px;">
                                        <li class="dropdown-header">Quick search by name, type, text, flavor text, artist, or year</li>
                                        <div class="dropdown-divider"></div>
                                        <form action="SearchServlet" method="POST" style="position:relative;top: 10px;">
                                            <input type="hidden" name="username" value="pixarninja">
                                            <input type="hidden" name="action" value="cards_quick">
                                            <input name="query" type="text" placeholder="Your Quick Search..." style="background-color: black !important;color: white;width:69%;position: relative;left: 20px;border: none !important;padding-top: 10px;padding-bottom: 10px;">
                                            <button title="Quick Search" id="form-submit" type="submit" style="width: 20% !important;height: 2.5em;position: relative;left: 20px;">Go!</button>
                                        </form>
                                    </div>-->
                                </div>
                                <hr>
                            </ul>
                        </div>
                    </div>
                    <!-- icons and text LG -->
                    <div class="hidden-xs hidden-sm hidden-md col-lg-12">
                        <div id="custom-navbar" class="navbar-header" style="position:relative;top: -4px;">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse" style="position: relative; top: 5px;">
                            <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -7px;font-size: 24px;" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector</a>
                            <ul class="nav navbar-nav">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Collections
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Decks
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Profile
                                    </button>
                                </div>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat<hr>
                                    </a>
                                </li>
                                -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;&nbsp;Help
                                    </button>
                                </div>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <%if(username != null && !username.equals("")) {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Notifications" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;Notifications (<%=notifications%>)
                                    </button>
                                </div>
                                <%}%>
                                <%if(username == null || username.equals("")) {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;Login
                                    </button>
                                </div>
                                <%} else {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;Logout
                                    </button>
                                </div>
                                <%}%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Search
                                    </button>
                                    <button type="button" class="btn btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">&nbsp;
                                        <span class="caret" style="position: relative;left: -5px;"></span>&nbsp;
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu" style="border-right: 1px solid white !important;border-left: 1px solid white !important;border-bottom: 1px solid white !important;border-bottom-right-radius: 10px;border-bottom-right-radius: 10px;border-bottom-left-radius: 10px;">
                                        <li class="dropdown-header">Quick search by name, type, text, flavor text, artist, or year</li>
                                        <div class="dropdown-divider"></div>
                                        <form action="SearchServlet" method="POST" style="position:relative;top: 10px;">
                                            <input type="hidden" name="username" value="pixarninja">
                                            <input type="hidden" name="action" value="cards_quick">
                                            <input name="query" type="text" placeholder="Your Quick Search..." style="background-color: black !important;color: white;width:69%;border: solid white 1px !important;padding: 8px;border-radius: 10px;position: relative;left: 15px;">
                                            <button title="Quick Search" id="form-submit" type="submit" style="width: 20% !important;height: 2.5em;position: relative;left: 20px;">Go!</button>
                                        </form>
                                    </div>
                                </div>
                            </ul>
                        </div>
                    </div>
                    <!-- only icons SM -->
                    <div class="hidden-xs col-sm-12 hidden-md hidden-lg">
                        <div id="custom-navbar" class="navbar-header" style="position:relative;top: -1px;">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse" style="position: relative; top: 5px;">
                            <a href="#" class="navbar-brand" style="position: relative; top: -5px;font-size: 20px;" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="medium-icon"></span>Collector</a>
                            <ul class="nav navbar-nav">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-book"></span>&nbsp;
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-inbox"></span>&nbsp;
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-user"></span>&nbsp;
                                    </button>
                                </div>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat<hr>
                                    </a>
                                </li>
                                -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-info-sign"></span>&nbsp;
                                    </button>
                                </div>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <%if(username != null && !username.equals("")) {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Notifications" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;(<%=notifications%>)
                                    </button>
                                </div>
                                <%}%>
                                <%if(username == null || username.equals("")) {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-gift"></span>&nbsp;
                                    </button>
                                </div>
                                <%} else {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-log-out"></span>&nbsp;
                                    </button>
                                </div>
                                <%}%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-search"></span>
                                    </button>
                                    <button type="button" class="btn btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">&nbsp;
                                        <span class="caret" style="position: relative;left: -5px;"></span>&nbsp;
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu" style="border-right: 1px solid white !important;border-left: 1px solid white !important;border-bottom: 1px solid white !important;border-bottom-right-radius: 10px;border-bottom-right-radius: 10px;border-bottom-left-radius: 10px;">
                                        <li class="dropdown-header">Quick search by name, type, text, flavor text, artist, or year</li>
                                        <div class="dropdown-divider"></div>
                                        <form action="SearchServlet" method="POST" style="position:relative;top: 10px;">
                                            <input type="hidden" name="username" value="pixarninja">
                                            <input type="hidden" name="action" value="cards_quick">
                                            <input name="query" type="text" placeholder="Your Quick Search..." style="background-color: black !important;color: white;width:69%;border: solid white 1px !important;padding: 8px;border-radius: 10px;position: relative;left: 15px;">
                                            <button title="Quick Search" id="form-submit" type="submit" style="width: 20% !important;height: 2.5em;position: relative;left: 20px;">Go!</button>
                                        </form>
                                    </div>
                                </div>
                            </ul>
                        </div>
                    </div>
                    <!-- only icons MD -->
                    <div class="hidden-xs hidden-sm col-md-12 hidden-lg">
                        <div id="custom-navbar" class="navbar-header" style="position:relative;top: -1px;">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse" style="position: relative; top: 5px;">
                            <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -7px;font-size: 24px;" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector</a>
                            <ul class="nav navbar-nav">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Collections" onclick="document.getElementById('yourCollectionsForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-book"></span>&nbsp;
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Decks" onclick="document.getElementById('yourDecksForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-inbox"></span>&nbsp;
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Your Profile" onclick="document.getElementById('profileForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-user"></span>&nbsp;
                                    </button>
                                </div>
                                <!--
                                <li>
                                    <a id="menu-item" title="Playmat" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat<hr>
                                    </a>
                                </li>
                                -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Help" onclick="document.getElementById('helpForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-info-sign"></span>&nbsp;
                                    </button>
                                </div>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <%if(username != null && !username.equals("")) {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Notifications" onclick="document.getElementById('notificationsForm').submit();">
                                        <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;(<%=notifications%>)
                                    </button>
                                </div>
                                <%}%>
                                <%if(username == null || username.equals("")) {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Login" onclick="document.getElementById('loginForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-gift"></span>&nbsp;
                                    </button>
                                </div>
                                <%} else {%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Logout" onclick="document.getElementById('logoutForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-log-out"></span>&nbsp;
                                    </button>
                                </div>
                                <%}%>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-lg" title="Advanced Search" onclick="document.getElementById('searchForm').submit();">
                                        &nbsp;<span class="glyphicon glyphicon-search"></span>
                                    </button>
                                    <button type="button" class="btn btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">&nbsp;
                                        <span class="caret" style="position: relative;left: -5px;"></span>&nbsp;
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <div class="dropdown-menu" style="border-right: 1px solid white !important;border-left: 1px solid white !important;border-bottom: 1px solid white !important;border-bottom-right-radius: 10px;border-bottom-right-radius: 10px;border-bottom-left-radius: 10px;">
                                        <li class="dropdown-header">Quick search by name, type, text, flavor text, artist, or year</li>
                                        <div class="dropdown-divider"></div>
                                        <form action="SearchServlet" method="POST" style="position:relative;top: 10px;">
                                            <input type="hidden" name="username" value="pixarninja">
                                            <input type="hidden" name="action" value="cards_quick">
                                            <input name="query" type="text" placeholder="Your Quick Search..." style="background-color: black !important;color: white;width:69%;border: solid white 1px !important;padding: 8px;border-radius: 10px;position: relative;left: 15px;">
                                            <button title="Quick Search" id="form-submit" type="submit" style="width: 20% !important;height: 2.5em;position: relative;left: 20px;">Go!</button>
                                        </form>
                                    </div>
                                </div>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    <div class="container-fluid">
        <div class="row" align="left">
            <!-- Ad Bar -->
            <div class="hidden-xs col-sm-1" style="background:url(images/wallart.jpg);height: 100%;position: fixed;left: 0px;background-position: center-x;"></div>
            <div class="hidden-xs col-sm-1" style="background:url(images/wallart.jpg);height: 100%;position: fixed;right: 0px;background-position: center-x;"></div>
            <div class="col-xs-12 col-sm-1"></div>
            <div id="content" class="col-xs-12 col-sm-10" style="background-color: black;background-repeat: repeat;min-height: 100%;">