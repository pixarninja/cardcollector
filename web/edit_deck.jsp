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
<div class="row">
    <div class="well col-xs-12">
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
                    <form id="editProfileForm" action="DeckServlet" method="POST">
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
                        <div class="row">
                            <div class="col-xs-12 col-lg-4">
                                <p id="title">Deck Contents and Appearance</p><br>
                                <%
                                    DeckContentsInfo deckContents;
                                    String top = deck.getTop();
                                    if(top == null) {
                                        top = "images/magic_card_back.jpg";
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
                                            int num = 1;
                                            while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                                if(deckContents.getDeckId() == id) {
                                                    CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                        %>
                                        <option value="<%=card.getFront()%>"><%=card.getName()%></option>
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
                                        <option value="images/magic_card_sleeves_default.jpg">Blue (default)</option>
                                        <option value="images/magic_card_sleeves_purple.jpg">Purple</option>
                                        <option value="images/magic_card_sleeves_black.jpg">Black</option>
                                        <option value="images/magic_card_sleeves_white.jpg">White</option>
                                        <option value="images/magic_card_sleeves_pink.jpg">Pink</option>
                                        <option value="images/magic_card_sleeves_red.jpg">Red</option>
                                        <option value="images/magic_card_sleeves_brown.jpg">Brown</option>
                                        <option value="images/magic_card_sleeves_orange.jpg">Orange</option>
                                        <option value="images/magic_card_sleeves_yellow.jpg">Yellow</option>
                                        <option value="images/magic_card_sleeves_green.jpg">Green</option>
                                        <option value="images/magic_card_sleeves_cyan.jpg">Cyan</option>
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
                                                <div class="col-xs-6">
                                                    Card Number
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
                                                    <div id="container<%=deckContents.getCardId()%>" class="col-xs-5">
                                                        <a id="menu-item" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
                                                            <span onmouseover="reveal('image<%=deckContents.getCardId()%>', 'container<%=deckContents.getCardId()%>', 'capsule', 'edit_deck')" onmouseout="conceal('image<%=deckContents.getCardId()%>')">
                                                                <%=card.getName()%>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <div class="col-xs-6">
                                                        <input id="input-field" class="input-number" type="number" name="total<%=deckContents.getCardId()%>" placeholder="<%=deckContents.getCardTotal()%>">
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
                                                <div class="col-xs-12"><hr></div>
                                                <div class="col-xs-6">
                                                    <span style="float: right;">
                                                        Copy Selected To Collection:
                                                    </span>
                                                </div>
                                                <div class="col-xs-6">
                                                    <select name="copy_collection" id="input-field">
                                                        <option value=""></option>
                                                        <%
                                                            num = 1;
                                                            CollectionInfo collection;
                                                            while((collection = collectionInfo.getCollectionByNum(num)) != null) {
                                                                if(collection.getId() != id && collection.getUser().equals(username)) {
                                                        %>
                                                        <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
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
                                                        Copy Selected To Deck:
                                                    </span>
                                                </div>
                                                <div class="col-xs-6">
                                                    <select name="copy_deck" id="input-field">
                                                        <option value=""></option>
                                                        <%
                                                            num = 1;
                                                            while((deck = deckInfo.getDeckByNum(num)) != null) {
                                                                if(deck.getUser().equals(username)) {
                                                        %>
                                                        <option value="<%=deck.getId()%>"><%=deck.getName()%></option>
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
                                        <div class="col-xs-12"><br></div>
                                    </div>
                                    <%
                                        num = 1;
                                        while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                            if(deckContents.getDeckId() == id) {
                                                CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                    %>
                                    <form id="cardForm<%=deckContents.getCardId()%>" action="CardServlet" method="POST">
                                        <input type="hidden" name="action" value="card">
                                        <input type="hidden" name="id" value="<%=deckContents.getCardId()%>">
                                        <input type="hidden" name="username" value="<%=username%>">
                                    </form>
                                    <img class="img-special" id="image<%=deckContents.getCardId()%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" style="display: none;"/>
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
</div>
<%
    } else {
%>
<!-- Error -->
<div class="well row">
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