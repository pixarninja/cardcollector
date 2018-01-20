<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
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
<script src="js/cookies.js"></script>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Search Results: Cards</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a card's information page by clicking the "View" link. You may add the card to your selection by clicking the "Add" link.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <%
                    int max = 12;
                    int count = 1;
                    if(request.getParameter("start") != null && !request.getParameter("start").equals("")) {
                        count = Integer.parseInt(request.getParameter("start"));
                    }
                    int total = 0;
                    if(request.getAttribute("total") != null){
                        total = (Integer)request.getAttribute("total");
                    }
                    int end = 0;
                    if((count + max - 1) < total) {
                        end = count + max - 1;
                    }
                    else {
                        end = total;
                    }
                    if(end < max) {
                        %><h3>Showing: 1 through <%=end%> out of <%=total%></h3><hr><%
                    }  
                    else {
                        %><h3>Showing: <%=end - max + 1%> through <%=end%> out of <%=total%></h3><hr><%
                    }
                    if(count != 1) {
                %>
                <div class="col-xs-6">
                    <div class="col-xs-12"><br></div>
                    <form id="requestLessForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="cards">
                        <input type="hidden" name="start" value="<%=count - max%>">
                        <input type="hidden" name="order" value="<%=request.getAttribute("order")%>">
                        <input type="hidden" name="order_by" value="<%=request.getAttribute("order_by")%>">
                        <input type="hidden" name="inclusion" value="<%=request.getAttribute("inclusion")%>">
                        <input type="hidden" name="common" value="<%=request.getAttribute("common")%>">
                        <input type="hidden" name="uncommon" value="<%=request.getAttribute("uncommon")%>">
                        <input type="hidden" name="rare" value="<%=request.getAttribute("rare")%>">
                        <input type="hidden" name="mythic" value="<%=request.getAttribute("mythic")%>">
                        <input type="hidden" name="inc_name" value="<%=request.getAttribute("inc_name")%>">
                        <input type="hidden" name="inc_type" value="<%=request.getAttribute("inc_type")%>">
                        <input type="hidden" name="inc_text" value="<%=request.getAttribute("inc_text")%>">
                        <input type="hidden" name="query" value="<%=request.getAttribute("query")%>">
                        <input type="hidden" name="min_cmc" value="<%=request.getAttribute("min_cmc")%>">
                        <input type="hidden" name="max_cmc" value="<%=request.getAttribute("max_cmc")%>">
                        <input type="hidden" name="type" value="<%=request.getAttribute("type")%>">
                        <input type="hidden" name="set_name" value="<%=request.getAttribute("set_name")%>">
                        <input type="hidden" name="min_power" value="<%=request.getAttribute("min_power")%>">
                        <input type="hidden" name="max_power" value="<%=request.getAttribute("max_power")%>">
                        <input type="hidden" name="min_toughness" value="<%=request.getAttribute("min_toughness")%>">
                        <input type="hidden" name="max_toughness" value="<%=request.getAttribute("max_toughness")%>">
                        <input type="hidden" name="artist" value="<%=request.getAttribute("artist")%>">
                        <input type="hidden" name="year" value="<%=request.getAttribute("year")%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Previous <%=max%> Cards" id="form-submit" type="submit"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
                    </form>
                    <div class="col-xs-12"><br></div>
                </div>
                <%}%>
                <%
                    if(end < total) {
                %>
                <div class="col-xs-6">
                    <div class="col-xs-12"><br></div>
                    <form id="requestMoreForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="cards">
                        <input type="hidden" name="start" value="<%=count + max%>">
                        <input type="hidden" name="order" value="<%=request.getParameter("order")%>">
                        <input type="hidden" name="order_by" value="<%=request.getParameter("order_by")%>">
                        <input type="hidden" name="inclusion" value="<%=request.getParameter("inclusion")%>">
                        <input type="hidden" name="common" value="<%=request.getParameter("common")%>">
                        <input type="hidden" name="uncommon" value="<%=request.getParameter("uncommon")%>">
                        <input type="hidden" name="rare" value="<%=request.getParameter("rare")%>">
                        <input type="hidden" name="mythic" value="<%=request.getParameter("mythic")%>">
                        <input type="hidden" name="inc_name" value="<%=request.getParameter("inc_name")%>">
                        <input type="hidden" name="inc_type" value="<%=request.getParameter("inc_type")%>">
                        <input type="hidden" name="inc_text" value="<%=request.getParameter("inc_text")%>">
                        <input type="hidden" name="query" value="<%=request.getParameter("query")%>">
                        <input type="hidden" name="min_cmc" value="<%=request.getParameter("min_cmc")%>">
                        <input type="hidden" name="max_cmc" value="<%=request.getParameter("max_cmc")%>">
                        <input type="hidden" name="type" value="<%=request.getParameter("type")%>">
                        <input type="hidden" name="set_name" value="<%=request.getParameter("set_name")%>">
                        <input type="hidden" name="min_power" value="<%=request.getParameter("min_power")%>">
                        <input type="hidden" name="max_power" value="<%=request.getParameter("max_power")%>">
                        <input type="hidden" name="min_toughness" value="<%=request.getParameter("min_toughness")%>">
                        <input type="hidden" name="max_toughness" value="<%=request.getParameter("max_toughness")%>">
                        <input type="hidden" name="artist" value="<%=request.getParameter("artist")%>">
                        <input type="hidden" name="year" value="<%=request.getParameter("year")%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Next <%=max%> Cards" id="form-submit" type="submit">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
                    </form>
                    <div class="col-xs-12"><br></div>
                </div>
                <%}%>
                <h4>
                    <div class="row">
                        <div class="col-xs-12"><br></div>
                        <%
                            CardInfo card;
                            int printed = 1;
                            int tracker = 1;
                            String id = (String) request.getAttribute(Integer.toString(count));
                            while((card = cardInfo.getCardById(id)) != null) {
                        %>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <img class="img-special" width="100%" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" id="center-img"><br>
                            <div class="row btn-group btn-block">
                                <div class="col-xs-6">
                                    <button class="btn" width="100%" type="button" title="Add To Collection" id="left-button" onclick="revealForm('add-popup', '<%=card.getId()%>', '<%=card.getFront()%>');"><span class="glyphicon glyphicon-plus"></span></button>
                                </div>
                                <div class="col-xs-6">
                                    <button class="btn" width="100%" type="button" title="Add To Favorite List" id="right-button" onclick="revealForm('add-popup', '<%=card.getId()%>', '<%=card.getFront()%>');"><span class="glyphicon glyphicon-star-empty"></span></button>
                                </div>
                            </div>
                            <p align="center">
                                <a href="#" onclick="document.getElementById('cardForm<%=id%>').submit();">
                                    <%=card.getName()%>
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
                                id = (String) request.getAttribute(Integer.toString(count));
                                try {
                                    Thread.sleep(250);
                                } catch(InterruptedException ex) {
                                    System.out.println("ERROR: sleep was interrupted!");
                                }
                            }
                        %>
                    </div>
                </h4>
                <form id="add-popup">
                    <a onclick="hideForm('add-popup')"><span id="close" class="glyphicon glyphicon-remove-circle"></span></a>
                    <h2 style="margin-left: 25px;margin-right: 25px;">Add To Deck<h2>
                    <h4>
                        <div class="hidden-xs hidden-sm col-md-6">
                            <div id="insert-image"></div>
                            <br><br>
                        </div>
                        <div class="hidden-xs hidden-sm col-md-6" style="position: relative;left: -22px;">
                            <%
                                if(username == null || username.equals("")) {
                            %>
                            <h4>
                                In order to add this card to a collection or deck, you must first login or sign up for an account.
                            </h4>
                            <%
                                } else {
                            %>
                            <form id="addCardForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="submit_edits">
                                <input type="hidden" name="username" value="<%=username%>">
                                <div id="insert-id"></div>
                                <h4>
                                    Select the collection and/or deck you would like to add the card to from the drop-down list(s) and then click the button below.
                                </h4><br><hr>
                                <h4 id="title">
                                    Add <input id="input-field" name="collection_total" type="number" style="width: 40px;" placeholder="0"> To Collection:<br><br>
                                    <select name="collection" id="input-field">
                                        <%
                                            CollectionInfo collection;
                                            int num = 1;
                                            while((collection = collectionInfo.getCollectionByNum(num)) != null) {
                                                if(collection.getUser().equals(username)) {
                                        %>
                                        <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
                                        <%
                                                }
                                                num++;
                                            }
                                        %>
                                    </select><br><br>
                                    Add <input id="input-field" name="deck_total" type="number" style="width: 40px;" placeholder="0"> To Deck:<br><br>
                                    <select name="deck" id="input-field">
                                        <%
                                            DeckInfo deck;
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
                                    </select>
                                    <br><br>
                                    <button title="Add Card To Collection/Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span></button>
                                </h4>
                            </form>
                            <%}%>
                        </div>
                        <div class="col-xs-12 hidden-md hidden-lg">
                            <%
                                if(username == null || username.equals("")) {
                            %>
                            <h4>
                                In order to add this card to a collection or deck, you must first login or sign up for an account.
                            </h4>
                            <%
                                } else {
                            %>
                            <form id="addCardForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="submit_edits">
                                <input type="hidden" name="username" value="<%=username%>">
                                <h4>
                                    Select the collection and/or deck you would like to add the card to from the drop-down list(s) and then click the button below.
                                </h4><br><hr>
                                <h4 id="title">
                                    Add <input id="input-field" name="collection_total" type="number" style="width: 40px;" placeholder="0"> To Collection:<br><br>
                                    <select name="collection" id="input-field">
                                        <%
                                            CollectionInfo collection;
                                            int num = 1;
                                            while((collection = collectionInfo.getCollectionByNum(num)) != null) {
                                                if(collection.getUser().equals(username)) {
                                        %>
                                        <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
                                        <%
                                                }
                                                num++;
                                            }
                                        %>
                                    </select><br><br>
                                    Add <input id="input-field" name="deck_total" type="number" style="width: 40px;" placeholder="0"> To Deck:<br><br>
                                    <select name="deck" id="input-field">
                                        <%
                                            DeckInfo deck;
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
                                    </select>
                                    <br><br>
                                    <button title="Add Card To Selected" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span></button>
                                    <br>
                                </h4>
                            </form>
                            <%}%>
                        </div>
                    </h4>
                    <div class="col-xs-12"><br></div>
                </form>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
