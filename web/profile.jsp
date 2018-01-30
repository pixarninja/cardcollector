<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="collectionContentsInfo" class="beans.CollectionContentsInfo" scope="request"/>
<jsp:useBean id="cardFavoriteInfo" class="beans.CardFavoriteInfo" scope="request"/>
<jsp:useBean id="deckFavoriteInfo" class="beans.DeckFavoriteInfo" scope="request"/>
<jsp:useBean id="userFavoriteInfo" class="beans.UserFavoriteInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%
    String username;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);
    if(user != null) {
        String picture = user.getPicture();
        String collectionIdList = "";
        String collectionNameList = "";
        int count = 1;
        int collectionNum = 0;
        CollectionInfo collection;
        while((collection = collectionInfo.getCollectionByNum(count)) != null) {
            if(collection.getUser().equals(username)) {
                collectionNum++;
                collectionIdList += collection.getId();
                collectionNameList += collection.getName();
                CollectionInfo tmp = collectionInfo.getCollectionByNum(count + 1);
                if(tmp != null && tmp.getUser().equals(username)) {
                    collectionIdList += "`";
                    collectionNameList += "`";
                }
            }
            count++;
        }
        String deckIdList = "";
        String deckNameList = "";
        int deckNum = 0;
        DeckInfo deck;
        count = 1;
        while((deck = deckInfo.getDeckByNum(count)) != null) {
            if(deck.getUser().equals(username)) {
                deckNum++;
                deckIdList += deck.getId();
                deckNameList += deck.getName();
                DeckInfo tmp = deckInfo.getDeckByNum(count + 1);
                if(tmp != null && tmp.getUser().equals(username)) {
                    deckIdList += "`";
                    deckNameList += "`";
                }
            }
            count++;
        }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Profile</h2><br>
            <h4>
                <p>Below is your profile information. You may edit your information by selecting the "Edit" button. You may edit any decks or collections you have recorded by selecting the item's title, which will take you to the item's information page. Below you will also find your favorited items, friends, and a log of your site history.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-4">
            <h4>
                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                <div class="col-xs-12"><br><br></div>
                <div class="row" style="margin: auto;display: table">
                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Profile Picture" onclick="document.getElementById('pictureForm').submit();">
                        <span id="button-symbol" class="glyphicon glyphicon-picture"></span>
                    </div>
                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-middle" title="Edit Profile Information" onclick="document.getElementById('editForm').submit();">
                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                    </div>
                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete User" onclick="deleteUserPopup('<%=username%>');">
                        <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                    </div>
                </div>
                <form id="pictureForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="edit_picture">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="editForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="edit_profile">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <br>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-8">
            <h2>Personal Information<hr></h2>
            <h4>
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Username</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getUsername()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Name</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getName()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Email</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getEmail()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <%
                        if(user.getBio() != null && !user.getBio().equals("")) {
                    %>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Bio</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getBio()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <%} else {%>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Bio</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p>No biography. Write one to let users know about you!</p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <%}%>
                </div>
            </h4>
        </div>
        <div class="col-xs-12">
            <h2>Decks<hr></h2>
            <h4>
                <p>
                    Below are your decks. You may view the deck's information by clicking on the link.
                </p>
                <br><br>
                <%
                    count = 1;
                    int printed = 1;
                    DeckInfo myDeck;
                    while((myDeck = deckInfo.getDeckByNum(count)) != null) {
                        if(!myDeck.getUser().equals(username)) {
                            count++;
                            continue;
                        }
                        int id = myDeck.getId();
                        String top = myDeck.getTop();
                        if(top == null) {
                            top = "images/magic_card_back.jpg";
                        }
                        String bottom = myDeck.getBottom();
                        if(bottom == null) {
                            bottom = "images/magic_card_sleeves_default.jpg";
                        }
                %>
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                        <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                    </div>
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
                    <p align="center" style="position: relative;top: -5px;">
                        <a href="#" onclick="document.getElementById('deckForm<%=id%>').submit();">
                            <%=myDeck.getName()%> (<%=myDeck.getUser()%>)
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
                        printed++;
                        count++;
                        try {
                            Thread.sleep(250);
                        } catch(InterruptedException ex) {
                            System.out.println("ERROR: sleep was interrupted!");
                        }
                    }
                %>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
        <div class="col-xs-12">
            <h2>Favorites<hr></h2>
            <h4>
                <p>
                    Below are your favorite cards, decks, collections, and users. If you choose to unfavorite any of your favorited items, they will be removed from this list. This action cannot be undone.
                </p>
            </h4><br><br>
            <%
                CardFavoriteInfo cardFavorite;
                int num = 1;
                boolean foundCard = false;
                while((cardFavorite = cardFavoriteInfo.getFavoriteByNum(num)) != null) {
                    if(cardFavorite.getUser().equals(username)) {
                        foundCard = true;
                        break;
                    }
                    num++;
                }
                if(foundCard) {
            %>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Favorite Cards<hr></h3>
                    <h4>
                        <%
                            num = 1;
                            printed = 1;
                            while((cardFavorite = cardFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(cardFavorite.getUser().equals(username)) {
                                    CardInfo card = cardInfo.getCardById(cardFavorite.getCardId());
                                    String id = card.getId();
                        %>
                        <div class="col-xs-6 col-sm-4 col-md-3">
                            <img class="img-special" width="100%" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" id="center-img">
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Add Card To Collection/Deck" onclick="addCardPopup('<%=card.getId()%>', '<%=card.getFront()%>', '<%=username%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">
                                    <span id="button-symbol" class="glyphicon glyphicon-plus"></span>
                                </div>
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Remove Card From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                            </div>
                            <br>
                            <p align="center" style="position: relative;top: -5px;">
                                <a href="#" onclick="document.getElementById('cardForm<%=id%>').submit();">
                                    <%=card.getName()%> (<%=card.getSetName()%>)
                                </a>
                            </p>
                            <form id="cardForm<%=id%>" action="CardServlet" method="POST">
                                <input type="hidden" name="action" value="card">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <form id="favoriteForm<%=id%>" action="CardServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
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
                                    printed++;
                                }
                                num++;
                            }
                        %>
                    </h4>
                </div>
            </div>
            <div class="col-xs-12"><br></div>
            <%}%>
            <%
                DeckFavoriteInfo deckFavorite;
                num = 1;
                boolean foundDeck = false;
                while((deckFavorite = deckFavoriteInfo.getFavoriteByNum(num)) != null) {
                    if(deckFavorite.getUser().equals(username)) {
                        foundDeck = true;
                        break;
                    }
                    num++;
                }
                if(foundDeck) {
            %>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Favorite Decks<hr></h3>
                    <h4>
                        <%
                            num = 1;
                            printed = 1;
                            while((deckFavorite = deckFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(deckFavorite.getUser().equals(username)) {
                                    deck = deckInfo.getDeckById(deckFavorite.getDeckId());
                                    int id = deck.getId();
                                    String top = deck.getTop();
                                    if(top == null) {
                                        top = "images/magic_card_back.jpg";
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
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                            </div>
                            <br>
                            <p align="center" style="position: relative;top: -5px;">
                                <a href="#" onclick="document.getElementById('deckForm<%=id%>').submit();">
                                    <%=deck.getName()%> (<%=deck.getUser()%>)
                                </a>
                            </p>
                            <form id="deckForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <form id="favoriteForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
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
                                    printed++;
                                }
                                num++;
                            }
                        %>
                    </h4>
                </div>
            </div>
            <div class="col-xs-12"><br></div>
            <%}%>
            <%
                UserFavoriteInfo userFavorite;
                num = 1;
                boolean foundUser = false;
                while((userFavorite = userFavoriteInfo.getFavoriteByNum(num)) != null) {
                    if(userFavorite.getUser().equals(username)) {
                        foundUser = true;
                        break;
                    }
                    num++;
                }
                if(foundUser) {
            %>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Favorite Users<hr></h3>
                    <h4>
                        <%
                            num = 1;
                            printed = 1;
                            while((userFavorite = userFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(userFavorite.getUser().equals(username)) {
                                    user = userInfo.getUser(userFavorite.getUserId());
                                    String id = user.getUsername();
                                    picture = user.getPicture();
                        %>
                        <div class="col-xs-6 col-sm-4 col-md-3">
                            <img class="img-special" width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img">
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove User From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                            </div>
                            <form id="favoriteForm<%=id%>" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <p align="center" style="position: relative;top: -5px;">
                                <a href="#" onclick="document.getElementById('userForm<%=id%>').submit();">
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
                                spacer += " hidden-sm hidden-md hidden-lg";
                            }
                        %>
                        <div class="<%=spacer%>"><br></div>
                        <%
                                    printed++;
                                }
                                num++;
                            }
                        %>
                    </h4>
                </div>
            </div>
            <div class="col-xs-12"><br></div>
            <%}%>
        </div>
    </div>
</div>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<%
    } else {
%>
<!-- Error -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Profile</h2><br>
            <h4>
                <p>The profile you selected has no information to display.</p>
                <br>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>