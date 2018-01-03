<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!DOCTYPE html>
<%
    String font = "Quicksand|Poiret+One";
%>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DeckBox</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=<%=font%>" rel="stylesheet">
        <form id="indexForm" action="CardServlet" method="POST">
            <input type="hidden" name="action" value="index">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="collectionsForm" action="CardServlet" method="POST">
            <input type="hidden" name="action" value="collections">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="decksForm" action="CardServlet" method="POST">
            <input type="hidden" name="action" value="decks">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="profileForm" action="UserServlet" method="POST">
            <input type="hidden" name="action" value="profile">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
        <form id="playmatForm" action="CardServlet" method="POST">
            <input type="hidden" name="action" value="playmat">
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
            <input type="hidden" name="username" value="<%=username%>">
        </form>
    </head>
    <body onload="refresh();">
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
                            <a href="#" class="navbar-brand" onclick="document.getElementById('indexForm').submit();">DECKBOX</a>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a title="Your Collections" href="#" onclick="document.getElementById('collectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Your Collections<hr>
                                    </a>
                                </li>
                                <li>
                                    <a title="Your Decks" href="#" onclick="document.getElementById('decksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Your Decks<hr>
                                    </a>
                                </li>
                                <li>
                                    <a title="Your Profile" href="#" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Your Profile<hr>
                                    </a>
                                </li>
                                <li>
                                    <a title="Playmat" href="#" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat<hr>
                                    </a>
                                </li>
                                <li>
                                    <a title="Help" href="#" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;&nbsp;Help<hr>
                                    </a>
                                </li>
                                <li>
                                    <a title="Advanced Search" href="#" onclick="document.getElementById('searchForm').submit();">
                                        <span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Advanced Search<hr>
                                    </a>
                                </li>
                                <li>
                                    <a title="Login" href="#" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login<hr>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- icons and text -->
                    <div class="hidden-xs hidden-sm hidden-md col-lg-12">
                        <div id="custom-navbar" class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                            <a href="#" class="navbar-brand" onclick="document.getElementById('indexForm').submit();">DECKBOX</a>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a title="Your Collections" href="#" onclick="document.getElementById('collectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>&nbsp;Collections
                                    </a>
                                </li>
                                <li>
                                    <a title="Your Decks" href="#" onclick="document.getElementById('decksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>&nbsp;Decks
                                    </a>
                                </li>
                                <li>
                                    <a title="Your Profile" href="#" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>&nbsp;Profile
                                    </a>
                                </li>
                                <li>
                                    <a title="Playmat" href="#" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>&nbsp;Playmat
                                    </a>
                                </li>
                                <li>
                                    <a title="Help" href="#" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;Help
                                    </a>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li>
                                    <a title="Advanced Search" href="#" onclick="document.getElementById('searchForm').submit();">
                                        <span class="glyphicon glyphicon-search"></span>&nbsp;Search
                                    </a>
                                </li>
                                <li>
                                    <a title="Login" href="#" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-log-in"></span>&nbsp;Login
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- only icons -->
                    <div class="hidden-xs col-sm-12 hidden-lg">
                        <div id="custom-navbar" class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                <span class="glyphicon glyphicon-list"></span>
                            </button>
                            <a href="#" class="navbar-brand" onclick="document.getElementById('indexForm').submit();">DECKBOX</a>
                        </div>
                        <div id="custom-navbar" class="collapse navbar-collapse">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a title="Your Collections" href="#" onclick="document.getElementById('collectionsForm').submit();">
                                        <span class="glyphicon glyphicon-book"></span>
                                    </a>
                                </li>
                                <li>
                                    <a title="Your Decks" href="#" onclick="document.getElementById('decksForm').submit();">
                                        <span class="glyphicon glyphicon-inbox"></span>
                                    </a>
                                </li>
                                <li>
                                    <a title="Your Profile" href="#" onclick="document.getElementById('profileForm').submit();">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </a>
                                </li>
                                <li>
                                    <a title="Playmat" href="#" onclick="document.getElementById('playmatForm').submit();">
                                        <span class="glyphicon glyphicon-knight"></span>
                                    </a>
                                </li>
                                <li>
                                    <a title="Help" href="#" onclick="document.getElementById('helpForm').submit();">
                                        <span class="glyphicon glyphicon-info-sign"></span>
                                    </a>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li>
                                    <a title="Advanced Search" href="#" onclick="document.getElementById('searchForm').submit();">
                                        <span class="glyphicon glyphicon-search"></span>
                                    </a>
                                </li>
                                <li>
                                    <a title="Login" href="#" onclick="document.getElementById('loginForm').submit();">
                                        <span class="glyphicon glyphicon-log-in"></span>
                                    </a>
                                </li>
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
            <div class="hidden-xs col-sm-1" style="background-image:url(images/planeswalkers.jpg);height: 100%;overflow: hidden;margin-bottom: -9999px;padding-bottom: 9999px;background-repeat: repeat-y;background-position: center center;background-size: 100%;background-attachment: fixed;"></div>
            <div class="hidden-xs col-sm-1"></div>
            <div id="content" class="col-xs-12 col-sm-10" style="background-color: #06080c;background-repeat: repeat;min-height: 100%;">