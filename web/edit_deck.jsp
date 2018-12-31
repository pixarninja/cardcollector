<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
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
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    DeckInfo deck = deckInfo.getDeckById(id);
    if(deck != null) {
%>
<!-- Content -->
<div <%=welled%>>
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Edit Deck Information</h2><br>
            <h4>
                <p>Fill out any of the fields below to replace the fields of the selected deck's information. Click the "Submit" button once you are done editing the information.</p>
                <br><br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="editDeckForm" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="submit_edit">
                    <input type="hidden" name="id" value="<%=deck.getId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                    <hr>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Deck Title</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Enter the title for this deck.<br><br>
                            <input id="input-field" name="name" type="text" value="<%=deck.getName()%>"><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Deck Description</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            You may enter a description for this deck.<br><br>
                            <%
                                if(deck.getDescription() == null || deck.getDescription().equals("")) {
                            %>
                            <textarea id="input-field" name="description"></textarea>
                            <%} else {%>
                            <textarea id="input-field" name="description"><%=deck.getDescription()%></textarea>
                            <%}%>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <!--
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Deck Statistics</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            You may update the wins and/or losses for this deck. In order to do so, you must select a verifier out of the users of this website. The verifier will be able to accept or reject the update from their Notifications Page (the <span class="glyphicon glyphicon-gift"></span>&nbsp;icon).<br><br>
                            <div class="col-xs-12 col-sm-4 col-md-3">
                                <p id="title">Verifier</p>
                            </div>
                            <div class="col-xs-12 col-sm-8 col-md-9">
                                <select name="verifier" id="input-field">
                                    <option value=""></option>
                                    <%
                                        int num = 1;
                                        UserInfo user;
                                        while((user = userInfo.getUserByNumAlpha(num)) != null) {
                                    %>
                                    <option value="<%=user.getUsername()%>"><%=user.getUsername()%> (<%=user.getName()%>)</option>
                                    <%
                                            num++;
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-md-3">
                                <p id="title">Matches Won</p>
                            </div>
                            <div class="col-xs-12 col-sm-8 col-md-9">
                                <input id="input-field" class="input-number" name="times_won" type="number" value="<%=deck.getWins()%>">
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-md-3">
                                <p id="title">Matches Played</p>
                            </div>
                            <div class="col-xs-12 col-sm-8 col-md-9">
                                <input id="input-field" class="input-number" name="times_played" type="number" value="<%=deck.getWins() + deck.getLosses()%>">
                            </div>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    -->
                    <div class="row">
                        <div class="col-xs-12 col-lg-4">
                            <p id="title">Deck Contents and Appearance</p><br>
                            <%
                                DeckContentsInfo deckContents;
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
                                int entries = deck.getEntries();
                            %>
                            <h4>
                                <div class="deck-image">
                                    <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                                    <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                                </div>
                            </h4>
                        </div>
                        <div class="col-xs-12 hidden-lg"><br></div>
                        <div class="col-xs-12 col-lg-8" id="capsule">
                            <div class="col-xs-4">
                                <span style="float: right;">
                                    Change Cover
                                </span>
                            </div>
                            <div class="col-xs-8">
                                <select name="cover" id="input-field">
                                    <option value=""></option>
                                    <%
                                        num = 1;
                                        while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                            if(deckContents.getDeckId() == id) {
                                                CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                    %>
                                    <option value="<%=card.getId()%>"><%=card.getName()%></option>
                                    <%
                                            }
                                            num++;
                                        }
                                    %>
                                </select><br><br><br>
                            </div>
                            <div class="col-xs-4">
                                <span style="float: right;">
                                    Change Sleeves
                                </span>
                            </div>
                            <div class="col-xs-8">
                                <select name="sleeves" id="input-field">
                                    <option value=""></option>
                                    <option value="images/magic_card_sleeves_default.jpg" style="background-color: #0751cc !important; color: white !important;">Blue (default)</option>
                                    <option value="images/magic_card_sleeves_purple.jpg" style="background-color: #8e07c5 !important; color: white !important;">Purple</option>
                                    <option value="images/magic_card_sleeves_black.jpg" style="background-color: #2a2e3a !important; color: white !important;">Black</option>
                                    <option value="images/magic_card_sleeves_platinum.jpg" style="background-color: #6c87a2 !important; color: black !important;">Platinum</option>
                                    <option value="images/magic_card_sleeves_silver.jpg" style="background-color: #a7a7a7 !important; color: black !important;">Silver</option>
                                    <option value="images/magic_card_sleeves_white.jpg" style="background-color: #ffffe1 !important; color: black !important;">White</option>
                                    <option value="images/magic_card_sleeves_pink.jpg" style="background-color: #fa6d97 !important; color: black !important;">Pink</option>
                                    <option value="images/magic_card_sleeves_magenta.jpg" style="background-color: #d50984 !important; color: white !important;">Magenta</option>
                                    <option value="images/magic_card_sleeves_red.jpg" style="background-color: #d92109 !important; color: white !important;">Red</option>
                                    <option value="images/magic_card_sleeves_brown.jpg" style="background-color: #995610 !important; color: white !important;">Brown</option>
                                    <option value="images/magic_card_sleeves_orange.jpg" style="background-color: #d95a09 !important; color: white !important;">Orange</option>
                                    <option value="images/magic_card_sleeves_bronze.jpg" style="background-color: #d47428 !important; color: white !important;">Bronze</option>
                                    <option value="images/magic_card_sleeves_gold.jpg" style="background-color: #ddac29 !important; color: black !important;">Gold</option>
                                    <option value="images/magic_card_sleeves_yellow.jpg" style="background-color: #f7d70a !important; color: black !important;">Yellow</option>
                                    <option value="images/magic_card_sleeves_green.jpg" style="background-color: #68dc09 !important; color: black !important;">Green</option>
                                    <option value="images/magic_card_sleeves_emerald.jpg" style="background-color: #0b850e !important; color: white !important;">Emerald</option>
                                    <option value="images/magic_card_sleeves_cyan.jpg" style="background-color: #07ccba !important; color: white !important;">Cyan</option>
                                </select><br><br><br>
                            </div>
                            <p>You may copy cards to a different deck, update the number of cards in this deck, or remove them from this deck by using the options below.</p><br>
                            <div class="col-xs-12 hidden-lg"><br></div>
                            <h4>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="well col-xs-12" id="black-well">
                                            <div class="col-xs-1"></div>
                                            <div class="col-xs-5">
                                                Card Name
                                            </div>
                                            <div class="col-xs-5">
                                                Number in Deck
                                            </div>
                                            <div class="col-xs-12"><hr></div>
                                            <div>
                                                <%
                                                    num = 1;
                                                    int printed = 1;
                                                    String spacer;
                                                    while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                                        if(deckContents.getDeckId() == id) {
                                                            CardInfo card = cardInfo.getCardById(deckContents.getCardId());
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
                                                            if(printed == entries) {
                                                                spacer = "hidden-xs hidden-sm hidden-md hidden-lg";
                                                            }
                                                            else {
                                                                spacer = "col-xs-12";
                                                            }
                                                %>
                                                <div class="col-xs-1">
                                                    <input type="checkbox" name="<%=printed%>" value="<%=deckContents.getCardId()%>">
                                                </div>
                                                <div class="col-xs-5 hidden-sm hidden-md hidden-lg">
                                                    <a id="menu-item" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
                                                        <%=card.getName()%> (<%=legalityText%>)
                                                    </a>
                                                </div>
                                                <div class="hidden-xs col-sm-5">
                                                    <div id="container<%=deckContents.getCardId()%>">
                                                        <span onmouseover="reveal('image<%=deckContents.getCardId()%>', 'container<%=deckContents.getCardId()%>', 'capsule', 'edit_deck')" onmouseout="conceal('image<%=deckContents.getCardId()%>')">
                                                            <a id="menu-item" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
                                                                <%=card.getName()%> (<%=legalityText%>)
                                                            </a>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-xs-5">
                                                    <input id="input-field" class="input-number" type="number" name="total<%=deckContents.getCardId()%>" value="<%=deckContents.getCardTotal()%>">
                                                </div>
                                                <div class="<%=spacer%>"><br></div>
                                                <%
                                                            printed++;
                                                        }
                                                        num++;
                                                    }
                                                %>
                                                <input type="hidden" name="<%=printed%>" value="ENDTOKEN">
                                            </div>
                                            <div class="col-xs-12"><hr></div>
                                            <div class="col-xs-1">
                                                <input type="checkbox" name="0" value="select_all">
                                            </div>
                                            <div class="col-xs-10">
                                                Select All
                                            </div>
                                            <div class="col-xs-12"><hr></div>
                                            <div class="col-xs-6">
                                                <span style="float: right;">
                                                    Copy Selected To Deck:
                                                </span>
                                            </div>
                                            <div class="col-xs-6">
                                                <select name="copy_deck" id="input-field">
                                                    <option value="">Choose deck...</option>
                                                    <%
                                                        num = 1;
                                                        while((deck = deckInfo.getDeckByNumAlpha(num)) != null) {
                                                            if(deck.getId() != id && deck.getUser().equals(username)) {
                                                    %>
                                                    <option value="<%=deck.getId()%>"><%=deck.getName()%></option>
                                                    <%
                                                            }
                                                            num++;
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="col-xs-12"><br></div>
                                            <div class="col-xs-6">
                                                <span style="float: right;">
                                                    Copy Selected To Collection:
                                                </span>
                                            </div>
                                            <div class="col-xs-6">
                                                <select name="copy_collection" id="input-field">
                                                    <option value="">Choose collection...</option>
                                                    <%
                                                        num = 1;
                                                        CollectionInfo collection;
                                                        while((collection = collectionInfo.getCollectionByNumAlpha(num)) != null) {
                                                            if(collection.getUser().equals(username)) {
                                                    %>
                                                    <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
                                                    <%
                                                            }
                                                            num++;
                                                        }
                                                    %>
                                                </select><br><br>
                                            </div>
                                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                            <div class="col-xs-6">
                                                <span style="float: right;">
                                                    Delete Selected
                                                </span>
                                            </div>
                                            <div class="col-xs-6">
                                                <input type="checkbox" name="delete" value="delete_selected"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    num = 1;
                                    while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                        if(deckContents.getDeckId() == id) {
                                            CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                            String[] imageURLs = card.getImageURLs();
                                            String front = imageURLs[0];
                                            if(front == null) {
                                                front = "images/magic_card_back.jpg";
                                            }
                                %>
                                <form id="cardForm<%=deckContents.getCardId()%>" action="CardServlet" method="POST">
                                    <input type="hidden" name="action" value="card">
                                    <input type="hidden" name="id" value="<%=deckContents.getCardId()%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <img class="img-special" id="image<%=deckContents.getCardId()%>" src="<%=front%>" alt="<%=front%>" style="display: none;"/>
                                <%
                                        }
                                        num++;
                                    }
                                %>
                            </h4>
                            <div class="row">
                                <div class="hidden-xs col-sm-6"></div>
                                <div class="col-xs-12 col-sm-6">
                                    <button title="Submit Deck Edit" id="form-submit" type="submit">Submit</button><br><br><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </h4>
        </div>
    </div>
</div>
<%
    } else {
%>
<!-- Error -->
<div <%=welled%>>
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Edit Deck Information</h2><br>
            <h4>
                <p>The deck you selected has no information to edit.</p>
                <br>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>