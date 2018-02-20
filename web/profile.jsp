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
<jsp:useBean id="collectionFavoriteInfo" class="beans.CollectionFavoriteInfo" scope="request"/>
<jsp:useBean id="userFavoriteInfo" class="beans.UserFavoriteInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
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
                if(collectionNum > 1) {
                    collectionIdList += "`";
                    collectionNameList += "`";
                }
                collectionIdList += collection.getId();
                collectionNameList += collection.getName();
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
                if(deckNum > 1) {
                    deckIdList += "`";
                    deckNameList += "`";
                }
                deckIdList += deck.getId();
                deckNameList += deck.getName();
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
            <h2>Your Decks<hr></h2>
            <%
                found = false;
                count = 1;
                DeckInfo myDeck;
                while((myDeck = deckInfo.getDeckByNum(count)) != null) {
                    if(myDeck.getUser().equals(username)) {
                        found = true;
                        break;
                    }
                    count++;
                }
                if(found) {
            %>
            <h4>
                <p>
                    Below are your decks. You may view the deck's information by clicking on the link. You can edit or delete the deck by clicking on the buttons.
                </p>
                <br><br>
                <%
                    count = 1;
                    int printed = 1;
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
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Deck" onclick="document.getElementById('editDeckForm<%=id%>').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                        </div>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                            <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                        </div>
                    </div>
                    <form id="editDeckForm<%=id%>" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <p align="center" style="position: relative;top: -5px;">
                        <a id="menu-item" onclick="document.getElementById('deckForm<%=id%>').submit();">
                            <%=myDeck.getName()%> by <%=myDeck.getUser()%>
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
            <%} else {%>
            <h4>
                <p>It looks like you haven't made any decks yet. If you would like to add a new deck, click the button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="addDeckForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Deck" id="form-submit" type="submit">New</button>
                        </form>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
            </h4><br>
            <%}%>
        </div>
        <div class="col-xs-12">
            <h2>Your Collections<hr></h2>
            <%
                found = false;
                count = 1;
                CollectionInfo myCollection;
                while((myCollection = collectionInfo.getCollectionByNum(count)) != null) {
                    if(myCollection.getUser().equals(username)) {
                        found = true;
                        break;
                    }
                    count++;
                }
                if(found) {
            %>
            <h4>
                <p>
                    Below are your collections. You may view the collection's information by clicking on the link. You can edit or delete the collection by clicking on the buttons.
                </p>
                <br><br>
                <%
                    count = 1;
                    int printed = 1;
                    while((myCollection = collectionInfo.getCollectionByNum(count)) != null) {
                        if(!myCollection.getUser().equals(username)) {
                            count++;
                            continue;
                        }
                        int id = myCollection.getId();
                        String top = myCollection.getTop();
                        if(top == null) {
                            top = "images/magic_card_back.jpg";
                        }
                        String middle = myCollection.getMiddle();
                        if(middle == null) {
                            middle = "images/magic_card_back.jpg";
                        }
                        String bottom = myCollection.getBottom();
                        if(bottom == null) {
                            bottom = "images/magic_card_back.jpg";
                        }
                %>
                <div class="col-xs-6 col-sm-4 col-md-3">
                    <div class="collection-image">
                        <img class="buffer" width="100%" src="images/buffer.png" id="center-img">
                        <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>">
                        <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>">
                        <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>">
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Collection" onclick="document.getElementById('editCollectionForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                            </div>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Collection" onclick="deleteCollectionPopup('<%=id%>', '<%=username%>');">
                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                            </div>
                        </div>
                        <form id="editCollectionForm<%=id%>" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <p align="center" style="position: relative;top: -5px;">
                            <a id="menu-item" onclick="document.getElementById('collectionForm<%=id%>').submit();">
                                <%=myCollection.getName()%> by <%=myCollection.getUser()%>
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
            <%} else {%>
            <h4>
                <p>It looks like you haven't made any collections yet. If you would like to add a new collection, click the button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="addCollectionForm" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Collection" id="form-submit" type="submit">New</button>
                        </form>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
            </h4><br>
            <%}%>
        </div>
        <div class="col-xs-12">
            <h2>Your Favorites<hr></h2>
            <h4>
                <p>
                    Below are your favorited cards, decks, collections, and users. If you choose to unfavorite any of your favorited items, they will be removed from this list. This action cannot be undone.
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
                            int printed = 1;
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
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Remove Card From Favorites List" onclick="document.getElementById('favoriteCardForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                            </div>
                            <form id="favoriteCardForm<%=id%>" action="CardServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <p align="center" style="position: relative;top: -5px;">
                                <a id="menu-item" onclick="document.getElementById('cardForm<%=id%>').submit();">
                                    <%=card.getName()%> (<%=card.getSetName()%>)
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
                            int printed = 1;
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
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteDeckForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                            </div>
                            <form id="favoriteDeckForm<%=id%>" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                            <p align="center" style="position: relative;top: -5px;">
                                <a id="menu-item" onclick="document.getElementById('deckForm<%=id%>').submit();">
                                    <%=deck.getName()%> (<%=deck.getUser()%>)
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
                CollectionFavoriteInfo collectionFavorite;
                num = 1;
                boolean foundCollection = false;
                while((collectionFavorite = collectionFavoriteInfo.getFavoriteByNum(num)) != null) {
                    if(collectionFavorite.getUser().equals(username)) {
                        foundCollection = true;
                        break;
                    }
                    num++;
                }
                if(foundCollection) {
            %>
            <div class="row">
                <div class="col-xs-12">
                    <h3>Favorite Collections<hr></h3>
                    <h4>
                        <%
                            num = 1;
                            int printed = 1;
                            while((collectionFavorite = collectionFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(collectionFavorite.getUser().equals(username)) {
                                    collection = collectionInfo.getCollectionById(collectionFavorite.getCollectionId());
                                    int id = collection.getId();
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
                        <div class="col-xs-6 col-sm-4 col-md-3">
                            <div class="collection-image">
                                <img class="buffer" width="100%" src="images/buffer.png" id="center-img">
                                <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>">
                                <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>">
                                <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>">
                                <br>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Collection From Favorites List" onclick="document.getElementById('favoriteCollectionForm<%=id%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                    </div>
                                </div>
                                <form id="favoriteCollectionForm<%=id%>" action="CollectionServlet" method="POST">
                                    <input type="hidden" name="action" value="favorite">
                                    <input type="hidden" name="id" value="<%=id%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <p align="center" style="position: relative;top: -5px;">
                                    <a id="menu-item" onclick="document.getElementById('collectionForm<%=id%>').submit();">
                                        <%=collection.getName()%> (<%=collection.getUser()%>)
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
                            int printed = 1;
                            while((userFavorite = userFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(userFavorite.getUser().equals(username)) {
                                    user = userInfo.getUser(userFavorite.getUserId());
                                    String id = user.getUsername();
                                    picture = user.getPicture();
                        %>
                        <div class="col-xs-4 col-sm-3 col-md-2">
                            <img class="img-special" width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img">
                            <br>
                            <div class="row" style="margin: auto;display: table">
                                <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove User From Favorites List" onclick="document.getElementById('favoriteUserForm<%=id%>').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                                </div>
                            </div>
                            <form id="favoriteUserForm<%=id%>" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="favorite">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
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