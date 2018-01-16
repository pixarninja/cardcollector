<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="selectionInfo" class="beans.SelectionInfo" scope="request"/>
<%
    String username;
    String buffer;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
    buffer = username;
    if(username == null || username.equals("null")) {
        username = "";
    }
    int selectionEntries = 0;
    int selectionId = 1;
    SelectionInfo selection;
    while((selection = (SelectionInfo) selectionInfo.getSelectionById(selectionId)) != null) {
        String user = selection.getUser();
        if(user.equals(username)) {
            selectionEntries++;
        }
        selectionId++;
    }
%>
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<%
    String id = request.getParameter("id");
    DeckInfo deck = deckInfo.getDeckById(id);
%>
<!-- Content -->
<div class="row">
    <div class="well col-xs-12">
        <div class="col-xs-12">
            <div class="col-xs-12">
                <h2>Edit Deck Information</h2><br>
                <h4>
                    <p>Fill out any of the fields below to replace the fields of the selected deck's information. Click "Submit Changes" once you are done editing the information.</p>
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
                            <div class="col-xs-7 col-xs-8">
                                Enter the title for this deck.<br><br>
                                <input id="input-field" name="name" type="text"><br><br>
                            </div>
                             <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p id="title">Deck Description</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                You may enter a description for this deck.<br><br>
                                <textarea id="input-field" name="description"></textarea>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4">
                                <p id="title">Deck Source</p>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8">
                                Choose a source for the deck. If the deck does not depend on a collection, select "Independent". If the deck must contain items from a specific collection, select "Child Of" and choose the name of the parent collection from the drop-down list.<br><br>
                                <div class="col-xs-12">
                                    <input name="source" type="radio" value="independent"> Independent
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-6">
                                    <input name="source" type="radio" value="parent" > Child Of
                                </div>
                                <div class="col-xs-6">
                                    <select name="parent" id="input-field">
                                        <%
                                            CollectionInfo collection;
                                            int num = 1;
                                            while((collection = collectionInfo.getCollectionByNum(num)) != null) {
                                        %>
                                        <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
                                        <%
                                                num++;
                                            }
                                        %>
                                    </select><br><br><br>
                                </div>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4">
                                <p id="title">Deck Contents and Appearance</p><br>
                                <%
                                    DeckContentsInfo deckContents;
                                    String top = deck.getTop();
                                    if(top == null) {
                                        top = "images/magic_card_back.png";
                                    }
                                    String bottom = deck.getBottom();
                                    if(bottom == null) {
                                        bottom = "images/magic_card_sleeves_default.png";
                                    }
                                    int entries = deck.getEntries();
                                    int total = deck.getTotal();
                                %>
                                <h4>
                                    <div class="deck-image">
                                        <img class="img-special sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                                        <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                                    </div>
                                </h4>
                            </div>
                            <div class="col-xs-12 col-sm-8">
                                <p>You may copy cards to a different deck, update the number of cards in this deck, or remove them from this deck by using the options below.</p><br>
                                <div class="col-xs-12 hidden-md hidden-lg"><br></div>
                                <h4 id="capsule">
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <div class="well col-xs-12" id="black-well">
                                                <div class="col-xs-1">
                                                    <span title="Delete" class="glyphicon glyphicon-trash" style="position: relative;left: -3px;"></span>
                                                </div>
                                                <div class="col-xs-7">
                                                    Card Name
                                                </div>
                                                <div class="col-xs-4">
                                                    Card Number
                                                </div>
                                                <div class="col-xs-12"><hr></div>
                                                <%
                                                    num = 1;
                                                    int printed = 1;
                                                    String spacer;
                                                    while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                                        if((deckContents.getDeckId()).equals(id)) {
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
                                                <div id="container<%=deckContents.getCardId()%>" class="col-xs-7">
                                                    <a href="#" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
                                                        <span onmouseover="reveal('image<%=deckContents.getCardId()%>', 'container<%=deckContents.getCardId()%>', 'capsule')" onmouseout="conceal('image<%=deckContents.getCardId()%>')">
                                                            <%=card.getName()%>
                                                        </span>
                                                    </a>
                                                </div>
                                                <div class="col-xs-4">
                                                    <input id="input-field" type="number" name="total<%=deckContents.getCardId()%>" style="width: 40px;font-size: 16px;" placeholder="<%=deckContents.getCardTotal()%>">
                                                </div>
                                                <div class="<%=spacer%>"><br></div>
                                                <%
                                                            printed++;
                                                        }
                                                        num++;
                                                    }
                                                %>
                                            </div>
                                        </div>
                                        <div class="col-xs-12"><br></div>
                                    </div>
                                    <%
                                        num = 1;
                                        while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                            if((deckContents.getDeckId()).equals(id)) {
                                                CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                    %>
                                    <form id="cardForm<%=deckContents.getCardId()%>" action="CardServlet" method="POST">
                                        <input type="hidden" name="action" value="card">
                                        <input type="hidden" name="id" value="<%=deckContents.getCardId()%>">
                                        <input type="hidden" name="username" value="<%=username%>">
                                    </form>
                                    <img class="img-noborder" id="image<%=deckContents.getCardId()%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" href="#" style="display: none;"/>
                                    <%
                                            }
                                            num++;
                                        }
                                    %>
                                </h4>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <hr>
                            <div class="col-xs-6">
                                <span style="float: right;">
                                    <input type="checkbox" name="update_cover" value="update_cover" > Change Cover
                                </span>
                            </div>
                            <div class="col-xs-6">
                                <select name="cover" id="input-field">
                                    <%
                                        num = 1;
                                        while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                            if((deckContents.getDeckId()).equals(id)) {
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
                            <div class="col-xs-6">
                                <span style="float: right;">
                                    <input type="checkbox" name="update_sleeves" value="update_sleeves" > Change Sleeves
                                </span>
                            </div>
                            <div class="col-xs-6">
                                <select name="sleeves" id="input-field">
                                    <option value="images/magic_card_sleeves_default.png">Blue (default)</option>
                                    <option value="images/magic_card_sleeves_purple.png">Purple</option>
                                    <option value="images/magic_card_sleeves_black.png">Black</option>
                                    <option value="images/magic_card_sleeves_white.png">White</option>
                                    <option value="images/magic_card_sleeves_red.png">Red</option>
                                    <option value="images/magic_card_sleeves_orange.png">Orange</option>
                                    <option value="images/magic_card_sleeves_yellow.png">Yellow</option>
                                    <option value="images/magic_card_sleeves_green.png">Green</option>
                                </select><br><br><br>
                                <button title="Submit Updates" id="form-submit" type="submit"><span class="glyphicon glyphicon-refresh"></span>&nbsp;&nbsp;Submit Updates</button><br><br><br>
                            </div>
                        </div>
                    </form>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>