<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="recentInfo" class="beans.RecentInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckFavoriteInfo" class="beans.DeckFavoriteInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="collectionFavoriteInfo" class="beans.CollectionFavoriteInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="cardFavoriteInfo" class="beans.CardFavoriteInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="userFavoriteInfo" class="beans.UserFavoriteInfo" scope="request"/>
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
    int count = 1;
    String collectionIdList = "";
    String collectionNameList = "";
    int collectionNum = 0;
    CollectionInfo collection;
    while((collection = collectionInfo.getCollectionByNumAlpha(count)) != null) {
        if(collection.getUser().equals(username)) {
            collectionNum++;
            if(collectionNum > 1) {
                collectionIdList += "`";
                collectionNameList += "`";
            }
            collectionIdList += collection.getId();
            String name = "";
            for(int i = 0; i < collection.getName().length(); i++) {
                name += (int) collection.getName().charAt(i) + ".";
            }
            collectionNameList += name;
        }
        count++;
    }
    String deckIdList = "";
    String deckNameList = "";
    int deckNum = 0;
    DeckInfo deck;
    count = 1;
    while((deck = deckInfo.getDeckByNumAlpha(count)) != null) {
        if(deck.getUser().equals(username)) {
            deckNum++;
            if(deckNum > 1) {
                deckIdList += "`";
                deckNameList += "`";
            }
            deckIdList += deck.getId();
            String name = "";
            for(int i = 0; i < deck.getName().length(); i++) {
                name += (int) deck.getName().charAt(i) + ".";
            }
            deckNameList += name;
        }
        count++;
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
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <!--<h4>
                <div class="well" id="black-well">
                    <p align="center" style="position: relative;top: 5px;">
                        <span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;Notice: We have updated our Terms of Service. You can view them <a href="/terms.jsp" target="_blank">here</a>&nbsp;&nbsp;<span class="glyphicon glyphicon-alert"></span>
                    </p>
                </div>
            </h4>-->
            <h2>Welcome To Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector!</h2><br>
            <h4>
                <p>
                    We invite you to use this website to log your collections and decks of Magic The Gathering Cards. By creating content on this website, you are leaving it publicly available for other users to look at, favorite, and comment on.
                <p><br>
                <p>
                    Below are lists of recently updated decks and collections, recently viewed cards, and recently joined users. If you would like to interact with any of them, use the links and/or options below each deck or collection to do so.
                </p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h3>Recently Updated Decks<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-12"><br></div>
                    <%
                        int printed = 1;
                        int tracker = 1;
                        int max = 8;
                        count = 1;
                        while((deck = deckInfo.getDeckByNum(count)) != null) {
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
                            else {
                                CardInfo card = cardInfo.getCardById(top);
                                if(card != null) {
                                    String[] imageURLs = card.getImageURLs();
                                    top = imageURLs[0];
                                    if(top == null) {
                                        top = "images/magic_card_back.jpg";
                                    }
                                }
                                else {
                                    top = "images/magic_card_back.jpg";
                                }
                            }
                            String bottom = deck.getBottom();
                            if(bottom == null) {
                                bottom = "images/magic_card_sleeves_default.jpg";
                            }
                    %>
                    <div class="col-xs-6 col-sm-4 col-md-3">
                        <div class="deck-image">
                            <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                            <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
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
                                <!--
                                <%=deck.getName()%> by <%=deck.getUser()%> (<%=deck.getTotal()%>, <%=deck.getWins()%>/<%=deck.getLosses()%>)
                                -->
                                <%=deck.getName()%> by <%=deck.getUser()%> (<%=deck.getTotal()%>)
                            </a>
                        </p>
                        <form id="deckForm<%=id%>" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="deck">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                    </div>
                    <%
                        String spacer = "";
                        if((printed % 2) == 0) {
                            spacer += "col-xs-12";
                        }
                        else {
                            spacer += "hidden-xs";
                        }
                        if((printed % 3) == 0) {
                            spacer += " col-sm-12";
                        }
                        else {
                            spacer += " hidden-sm";
                        }
                        if((printed % 4) == 0) {
                            spacer += " col-md-12";
                        }
                        else {
                            spacer += " hidden-md hidden-lg";
                        }
                    %>
                    <div class="<%=spacer%>"><br></div>
                    <%
                            if(tracker >= max) {
                                break;
                            }
                            tracker++;
                            printed++;
                            count++;
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex1) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                        }
                    %>
                    <div class="col-xs-12"></div>
                    <div class="col-xs-12 col-sm-4">
                        <form id="addForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Create New Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;New Deck</button>
                        </form>
                    </div>
                    <div class="hidden-xs col-xs-4"></div>
                    <div class="col-xs-12 col-sm-4">
                        <form id="allDecksForm" action="SearchServlet" method="POST">
                            <input type="hidden" name="action" value="decks">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="View All Decks" id="form-submit" type="submit"><span class="glyphicon glyphicon-th"></span>&nbsp;&nbsp;View All Decks</button>
                        </form>
                    </div>
                </div>
            </h4>
        </div>
        <div class="col-xs-12">
            <h3>Recently Updated Collections<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-12"><br></div>
                    <%
                        printed = 1;
                        tracker = 1;
                        max = 8;
                        count = 1;
                        while((collection = collectionInfo.getCollectionByNum(count)) != null) {
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
                            else {
                                CardInfo card = cardInfo.getCardById(top);
                                if(card != null) {
                                    String[] imageURLs = card.getImageURLs();
                                    top = imageURLs[0];
                                    if(top == null) {
                                        top = "images/magic_card_back.jpg";
                                    }
                                }
                                else {
                                    top = "images/magic_card_back.jpg";
                                }
                            }
                            String middle = collection.getMiddle();
                            if(middle == null) {
                                middle = "images/magic_card_back.jpg";
                            }
                            else {
                                CardInfo card = cardInfo.getCardById(middle);
                                if(card != null) {
                                    String[] imageURLs = card.getImageURLs();
                                    middle = imageURLs[0];
                                    if(middle == null) {
                                        middle = "images/magic_card_back.jpg";
                                    }
                                } else {
                                    middle = "images/magic_card_back.jpg";
                                }
                            }
                            String bottom = collection.getBottom();
                            if(bottom == null) {
                                bottom = "images/magic_card_back.jpg";
                            }
                            else {
                                CardInfo card = cardInfo.getCardById(bottom);
                                if(card != null) {
                                    String[] imageURLs = card.getImageURLs();
                                    bottom = imageURLs[0];
                                    if(bottom == null) {
                                        bottom = "images/magic_card_back.jpg";
                                    }
                                }
                                else {
                                    bottom = "images/magic_card_back.jpg";
                                }
                            }
                    %>
                    <div class="col-xs-6 col-sm-4 col-md-3">
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
                                    <%=collection.getName()%> by <%=collection.getUser()%> (<%=collection.getTotal()%>)
                                </a>
                            </p>
                            <form id="collectionForm<%=id%>" action="CollectionServlet" method="POST">
                                <input type="hidden" name="action" value="collection">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                        </div>
                    </div>
                    <%
                        String spacer = "";
                        if((printed % 2) == 0) {
                            spacer += "col-xs-12";
                        }
                        else {
                            spacer += "hidden-xs";
                        }
                        if((printed % 3) == 0) {
                            spacer += " col-sm-12";
                        }
                        else {
                            spacer += " hidden-sm";
                        }
                        if((printed % 4) == 0) {
                            spacer += " col-md-12";
                        }
                        else {
                            spacer += " hidden-md hidden-lg";
                        }
                    %>
                    <div class="<%=spacer%>"><br></div>
                    <%
                            if(tracker >= max) {
                                break;
                            }
                            tracker++;
                            printed++;
                            count++;
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex1) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                        }
                    %>
                    <div class="col-xs-12"></div>
                    <div class="col-xs-12 col-sm-4">
                        <form id="addForm" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Create New Collection" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;New Collection</button>
                        </form>
                    </div>
                    <div class="hidden-xs col-xs-4"></div>
                    <div class="col-xs-12 col-sm-4">
                        <form id="allCollectionsForm" action="SearchServlet" method="POST">
                            <input type="hidden" name="action" value="collections">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="View All Collections" id="form-submit" type="submit"><span class="glyphicon glyphicon-th"></span>&nbsp;&nbsp;View All Collections</button>
                        </form>
                    </div>
                </div>
            </h4>
        </div>
        <div class="col-xs-12">
            <h3>Recently Viewed Cards<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-12"><br></div>
                    <%
                        printed = 1;
                        tracker = 1;
                        max = 12;
                        count = 1;
                        CardInfo card;
                        while((card = cardInfo.getCardByNum(count)) != null) {
                            String id = card.getId();
                            String legalities = card.getLegalities();
                            String legalityText = "";
                            if(legalities.charAt(0) == '1') {
                                legalityText += "S";
                            }
                            if(legalities.charAt(1) == '1') {
                                legalityText += "F";
                            }
                            if(legalities.charAt(2) == '1') {
                                legalityText += "R";
                            }
                            if(legalities.charAt(3) == '1') {
                                legalityText += "M";
                            }
                            if(legalities.charAt(4) == '1') {
                                legalityText += "L";
                            }
                            if(legalities.charAt(5) == '1') {
                                legalityText += "A";
                            }
                            if(legalities.charAt(6) == '1') {
                                legalityText += "V";
                            }
                            if(legalities.charAt(7) == '1') {
                                legalityText += "P";
                            }
                            if(legalities.charAt(8) == '1') {
                                legalityText += "C";
                            }
                            if(legalities.charAt(9) == '1') {
                                legalityText += "1";
                            }
                            if(legalities.charAt(10) == '1') {
                                legalityText += "D";
                            }
                            if(legalities.charAt(11) == '1') {
                                legalityText += "B";
                            }
                            if(legalityText == "") {
                                legalityText = "-";
                            }
                            CardFavoriteInfo favorite;
                            boolean favorited = false;
                            int num = 1;
                            while((favorite = cardFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(favorite.getUser().equals(username) && favorite.getCardId().equals(id)) {
                                    favorited = true;
                                    break;
                                }
                                num++;
                            }
                    %>
                    <div class="col-xs-6 col-sm-4 col-md-3">
                        <%
                            String[] imageURLs = card.getImageURLs();
                            String front = imageURLs[0];
                            if(front == null) {
                                front = "images/magic_card_back.jpg";
                            }
                        %>
                        <img class="img-special" width="100%" src="<%=front%>" alt="<%=front%>" id="center-img">
                        <%
                            if(username != null && !username.equals("")) {
                        %>
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Add Card To Collection/Deck" onclick="addCardPopup('<%=card.getId()%>', '<%=front%>', '<%=username%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">
                                <span id="button-symbol" class="glyphicon glyphicon-plus"></span>
                            </div>
                            <%
                                if(favorited) {
                            %>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Remove Card From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                            </div>
                            <%} else {%>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Add Card To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                            </div>
                            <%}%>
                        </div>
                        <form id="favoriteForm<%=id%>" action="CardServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%} else {%>
                        <br>
                        <%}%>
                        <p align="center" style="position: relative;top: -5px;">
                            <a id="menu-item" onclick="document.getElementById('cardForm<%=id%>').submit();">
                                <%=card.getName()%> | <%=card.getSetName()%> (<%=legalityText%>)
                            </a>
                        </p>
                        <form id="cardForm<%=id%>" action="CardServlet" method="POST">
                            <input type="hidden" name="action" value="card">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                    </div>
                    <%
                        String spacer = "";
                        if((printed % 2) == 0) {
                            spacer += "col-xs-12";
                        }
                        else {
                            spacer += "hidden-xs";
                        }
                        if((printed % 3) == 0) {
                            spacer += " col-sm-12";
                        }
                        else {
                            spacer += " hidden-sm";
                        }
                        if((printed % 4) == 0) {
                            spacer += " col-md-12";
                        }
                        else {
                            spacer += " hidden-md hidden-lg";
                        }
                    %>
                    <div class="<%=spacer%>"><br></div>
                    <%
                            if(tracker >= max) {
                                break;
                            }
                            tracker++;
                            printed++;
                            count++;
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex1) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                        }
                    %>
                    <div class="col-xs-12"></div>
                    <div class="hidden-xs col-xs-8"></div>
                    <div class="col-xs-12 col-sm-4">
                        <form id="allCardsForm" action="SearchServlet" method="POST">
                            <input type="hidden" name="action" value="cards">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="View All Cards" id="form-submit" type="submit"><span class="glyphicon glyphicon-th"></span>&nbsp;&nbsp;View All Cards</button>
                        </form>
                    </div>
                </div>
            </h4>
        </div>
        <div class="col-xs-12">
            <h3>Recently Joined Users<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-12"><br></div>
                    <%
                        printed = 1;
                        tracker = 1;
                        max = 12;
                        count = 1;
                        UserInfo user;
                        while((user = userInfo.getUserByNum(count)) != null) {
                            UserFavoriteInfo favorite;
                            boolean favorited = false;
                            int num = 1;
                            String id = user.getUsername();
                            while((favorite = userFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(favorite.getUser().equals(username) && favorite.getUserId().equals(id)) {
                                    favorited = true;
                                    break;
                                }
                                num++;
                            }
                            String picture = user.getPicture();
                    %>
                    <div class="col-xs-4 col-sm-3 col-md-2">
                        <img class="img-special" width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img">
                        <%if(user.getUsername().equals(username)) {%>
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Edit Profile Information" onclick="document.getElementById('editForm').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                            </div>
                        </div>
                        <form id="editForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit_profile">
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
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove User From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                            </div>
                            <%} else {%>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add User To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                            </div>
                            <%}%>
                        </div>
                        <form id="favoriteForm<%=id%>" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%} else {%>
                        <br>
                        <%}}%>
                        <p align="center" style="position: relative;top: -5px;">
                            <a id="menu-item" onclick="document.getElementById('userForm<%=id%>').submit();">
                                <%=user.getUsername()%> (<%=user.getName()%>)
                            </a>
                        </p>
                        <form id="userForm<%=id%>" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="user">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                    </div>
                    <%
                        String spacer = "";
                        if((printed % 3) == 0) {
                            spacer += "col-xs-12";
                        }
                        else {
                            spacer += "hidden-xs";
                        }
                        if((printed % 4) == 0) {
                            spacer += " col-sm-12";
                        }
                        else {
                            spacer += " hidden-sm";
                        }
                        if((printed % 6) == 0) {
                            spacer += " col-md-12";
                        }
                        else {
                            spacer += " hidden-md hidden-lg";
                        }
                    %>
                    <div class="<%=spacer%>"><br></div>
                    <%
                            if(tracker >= max) {
                                break;
                            }
                            tracker++;
                            printed++;
                            count++;
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex1) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                        }
                    %>
                    <div class="col-xs-12"></div>
                    <div class="hidden-xs col-xs-8"></div>
                    <div class="col-xs-12 col-sm-4">
                        <form id="allUsersForm" action="SearchServlet" method="POST">
                            <input type="hidden" name="action" value="users">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="View All Users" id="form-submit" type="submit"><span class="glyphicon glyphicon-th"></span>&nbsp;&nbsp;View All Users</button>
                        </form>
                    </div>
                </div>
            </h4>
        </div>
    </div>
</div>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>