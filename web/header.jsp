<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DeckBox</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <form id="searchForm" action="SearchServlet" method="POST">
            <input type="hidden" name="action" value="search">
            <input type="hidden" name="username" value="<%=username%>">
        </form>
    </head>
    <body>
        <div id="menu">
            <nav class="navbar">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <ul class="nav navbar-nav">
                            <li>
                                <form id="indexForm" action="GameServlet" method="POST">
                                    <input type="hidden" name="action" value="index">
                                    <input type="hidden" name="username" value="<%=username%>">
                                    <a href="#" onclick="document.getElementById('indexForm').submit();">
                                        <img id="logo" src="images/gamersloglogo.png" alt="Gamer's Log">
                                    </a>
                                </form>
                            </li>
                            <li>
                                <br>
                            </li>
                            <li class="dropdown" id="menu_item">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h4><br>Title</h4></a>
                                <ul class="dropdown-menu" id="dropdown">
                                    <li>
                                        <form>
                                            <input type="hidden" name="action" value="actionValue">
                                            <input id="menu_submit" type="submit" value="Submenu">
                                        </form>
                                    </li>
                                    <li>
                                        <form>
                                            <input type="hidden" name="action" value="actionValue">
                                            <input id="menu_submit" type="submit" value="Submenu">
                                        </form>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown" id="menu_item">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h4><br>Title</h4></a>
                                <ul class="dropdown-menu" id="dropdown">
                                    <li>
                                        <form>
                                            <input type="hidden" name="action" value="actionValue">
                                            <input id="menu_submit" type="submit" value="Submenu">
                                        </form>
                                    </li>
                                    <li>
                                        <form>
                                            <input type="hidden" name="action" value="actionValue">
                                            <input id="menu_submit" type="submit" value="Submenu">
                                        </form>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown" id="menu_item">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><h4><br>Title</h4></a>
                                <ul class="dropdown-menu" id="dropdown">
                                    <li>
                                        <form>
                                            <input type="hidden" name="action" value="actionValue">
                                            <input id="menu_submit" type="submit" value="Submenu">
                                        </form>
                                    </li>
                                    <li>
                                        <form>
                                            <input type="hidden" name="action" value="actionValue">
                                            <input id="menu_submit" type="submit" value="Submenu">
                                        </form>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown" id="menu_item">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" onclick="document.getElementById('searchForm').submit();"><h4><br>Search</h4></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
