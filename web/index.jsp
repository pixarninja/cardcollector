<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="recentInfo" class="beans.RecentInfo" scope="request"/>
<jsp:useBean id="deckFavoriteInfo" class="beans.DeckFavoriteInfo" scope="request"/>
<jsp:useBean id="collectionFavoriteInfo" class="beans.CollectionFavoriteInfo" scope="request"/>
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
<%
    Exception ex = (Exception)request.getAttribute("error");
    if(ex != null) {
        %><h2>Database Error<hr></h2><h4>Stacktrace: <%=ex%></h4><br><%
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Welcome To Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector!</h2><br>
            <h4>
                <p>
                    We invite you to use this website to log your collections and decks of Magic The Gathering Cards. By creating content on this website, you are leaving it publicly available for other users to look at, favorite, and comment on.
                <p><br>
                <p>
                    Below are recently updated decks and collections.
                </p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <div class="row">
                <div class="col-xs-6">
                    <h3>Recent Decks<hr></h3>
                </div>
                <div class="col-xs-6">
                    <h3>Recent Collections<hr></h3>
                </div>
            </div>
            <h4>
                <%
                    int count = 1;
                    RecentInfo recent;
                    RecentInfo tmp;
                    while((recent = recentInfo.getRecentsByNum(count)) != null) {
                        DeckInfo deck = recent.getDeck();
                        CollectionInfo collection = recent.getCollection();
                %>
                <div class="row">
                    <div class="col-xs-6">
                        <%
                            if(deck != null) {
                                int id = deck.getId();
                                DeckFavoriteInfo favorite;
                                boolean favorited = false;
                                int num = 1;
                                while((favorite = deckFavoriteInfo.getFavoriteByNum(num)) != null) {
                                    if(favorite.getUser().equals(username) && favorite.getDeckId() == id) {
                                        favorited = true;
                                        break;
                                    }
                                    num++;
                                }
                                String top = deck.getTop();
                                if(top == null) {
                                    top = "images/magic_card_back.jpg";
                                }
                                String bottom = deck.getBottom();
                                if(bottom == null) {
                                    bottom = "images/magic_card_sleeves_default.jpg";
                                }
                        %>
                        <div class="col-xs-12 col-sm-6">
                            <div class="deck-image">
                                <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img">
                                <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img">
                            </div>
                            <%if(deck.getUser().equals(username)) {%>
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Deck" onclick="document.getElementById('editForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                </div>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                </div>
                            </div>
                            <form id="editForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <%
                                } else {
                                    if(username != null && !username.equals("")) {
                            %>
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <%
                                    if(favorited) {
                                %>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                                <%} else {%>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add Deck To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                                </div>
                                <%}%>
                            </div>
                            <form id="favoriteForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <%} else {%>
                            <br>
                            <%}}%>
                            <p align="center" style="position: relative;top: -5px;">
                                <a id="menu-item" onclick="document.getElementById('deckForm<%=id%>').submit();">
                                    <%=deck.getName()%> by <%=deck.getUser()%>
                                </a>
                            </p>
                            <form id="deckForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <%
                            }
                            tmp = recentInfo.getRecentsByNum(count + 1);
                            if(tmp != null) {
                                deck = tmp.getDeck();
                            }
                            else {
                                deck = null;
                            }
                        %>
                        <div class="col-xs-12 col-sm-6">
                            <%
                                if(deck != null) {
                                    int id = deck.getId();
                                    DeckFavoriteInfo favorite;
                                    boolean favorited = false;
                                    int num = 1;
                                    while((favorite = deckFavoriteInfo.getFavoriteByNum(num)) != null) {
                                        if(favorite.getUser().equals(username) && favorite.getDeckId() == id) {
                                            favorited = true;
                                            break;
                                        }
                                        num++;
                                    }
                                    String top = deck.getTop();
                                    if(top == null) {
                                        top = "images/magic_card_back.jpg";
                                    }
                                    String bottom = deck.getBottom();
                                    if(bottom == null) {
                                        bottom = "images/magic_card_sleeves_default.jpg";
                                    }
                            %>
                            <div class="deck-image">
                                <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img">
                                <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img">
                            </div>
                            <%if(deck.getUser().equals(username)) {%>
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Deck" onclick="document.getElementById('editForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                </div>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                </div>
                            </div>
                            <form id="editForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <%
                                } else {
                                    if(username != null && !username.equals("")) {
                            %>
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <%
                                    if(favorited) {
                                %>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                                <%} else {%>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add Deck To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                                </div>
                                <%}%>
                            </div>
                            <form id="favoriteForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <%} else {%>
                            <br>
                            <%}}%>
                            <p align="center" style="position: relative;top: -5px;">
                                <a id="menu-item" onclick="document.getElementById('deckForm<%=id%>').submit();">
                                    <%=deck.getName()%> by <%=deck.getUser()%>
                                </a>
                            </p>
                            <form id="deckForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <div class="col-xs-12"><br></div>
                            <%}%>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <%
                            if(collection != null) {
                                int id = collection.getId();
                                CollectionFavoriteInfo favorite;
                                boolean favorited = false;
                                int num = 1;
                                while((favorite = collectionFavoriteInfo.getFavoriteByNum(num)) != null) {
                                    if(favorite.getUser().equals(username) && favorite.getCollectionId() == id) {
                                        favorited = true;
                                        break;
                                    }
                                    num++;
                                }
                                String top = collection.getTop();
                                if(top == null) {
                                    top = "images/magic_card_back.jpg";
                                }
                                String middle = collection.getMiddle();
                                if(middle == null) {
                                    middle = "images/magic_card_back.jpg";
                                }
                                String bottom = collection.getBottom();
                                if(bottom == null) {
                                    bottom = "images/magic_card_back.jpg";
                                }
                        %>
                        <div class="col-xs-12 col-sm-6">
                            <div class="collection-image">
                                <img class="buffer" width="100%" src="images/buffer.png" id="center-img">
                                <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>">
                                <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>">
                                <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>">
                                <br>
                                <%if(collection.getUser().equals(username)) {%>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Collection" onclick="document.getElementById('editForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                    </div>
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Collection" onclick="deleteCollectionPopup('<%=id%>', '<%=username%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                    </div>
                                </div>
                                <form id="editForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <%
                                    } else {
                                        if(username != null && !username.equals("")) {
                                %>
                                <div class="row" style="margin: auto;display: table">
                                    <%
                                        if(favorited) {
                                    %>
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Collection From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                    </div>
                                    <%} else {%>
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add Collection To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                                    </div>
                                    <%}%>
                                </div>
                                <form id="favoriteForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="favorite">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <%}}%>
                                <p align="center" style="position: relative;top: -5px;">
                                    <a id="menu-item" onclick="document.getElementById('collectionForm<%=id%>').submit();">
                                        <%=collection.getName()%> by <%=collection.getUser()%>
                                    </a>
                                </p>
                                <form id="collectionForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="collection">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            </div>
                        </div>
                        <%
                            }
                            if(tmp != null) {
                                collection = tmp.getCollection();
                            }
                            else {
                                collection = null;
                            }
                        %>
                        <div class="col-xs-12 col-sm-6">
                            <%
                                if(collection != null) {
                                    int id = collection.getId();
                                    CollectionFavoriteInfo favorite;
                                    boolean favorited = false;
                                    int num = 1;
                                    while((favorite = collectionFavoriteInfo.getFavoriteByNum(num)) != null) {
                                        if(favorite.getUser().equals(username) && favorite.getCollectionId() == id) {
                                            favorited = true;
                                            break;
                                        }
                                        num++;
                                    }
                                    String top = collection.getTop();
                                    if(top == null) {
                                        top = "images/magic_card_back.jpg";
                                    }
                                    String middle = collection.getMiddle();
                                    if(middle == null) {
                                        middle = "images/magic_card_back.jpg";
                                    }
                                    String bottom = collection.getBottom();
                                    if(bottom == null) {
                                        bottom = "images/magic_card_back.jpg";
                                    }
                            %>
                            <div class="collection-image">
                                <img class="buffer" width="100%" src="images/buffer.png" id="center-img">
                                <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>">
                                <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>">
                                <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>">
                                <br>
                                <%if(collection.getUser().equals(username)) {%>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Collection" onclick="document.getElementById('editForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                    </div>
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Collection" onclick="deleteCollectionPopup('<%=id%>', '<%=username%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                    </div>
                                </div>
                                <form id="editForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <%
                                    } else {
                                        if(username != null && !username.equals("")) {
                                %>
                                <div class="row" style="margin: auto;display: table">
                                    <%
                                        if(favorited) {
                                    %>
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Collection From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                    </div>
                                    <%} else {%>
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add Collection To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                                    </div>
                                    <%}%>
                                </div>
                                <form id="favoriteForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="favorite">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <%}}%>
                                <p align="center" style="position: relative;top: -5px;">
                                    <a id="menu-item" onclick="document.getElementById('collectionForm<%=id%>').submit();">
                                        <%=collection.getName()%> by <%=collection.getUser()%>
                                    </a>
                                </p>
                                <form id="collectionForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="collection">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <div class="col-xs-12"><br></div>
                            </div><br>
                            <%}%>
                        </div>
                    </div>
                </div>
                <%
                        if(deck == null && collection == null) {
                            break;
                        }
                        count += 2;
                    }
                %>
            </h4>
        </div>
    </div>
</div>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>