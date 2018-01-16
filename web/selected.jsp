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
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
    boolean found = false;
    int selectionEntries = 0;
    int selectionId = 1;
    SelectionInfo selection;
    while((selection = (SelectionInfo) selectionInfo.getSelectionById(selectionId)) != null) {
        String user = selection.getUser();
        if(user.equals(username)) {
            found = true;
            selectionEntries++;
        }
        selectionId++;
    }
%>
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<%
    if(found) {
%>
<!-- Content -->
<div class="row">
    <div class="well col-xs-12">
        <div class="col-xs-12">
            <h2>Selected Items</h2><br>
            <h4>
                <p>Below are your selected cards. You may add cards to a collection/deck or remove them from your selected items using the options below.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4 id="capsule">
                <div class="row">
                    <form id="newCollectionForm" action="SelectionServlet" method="POST">
                        <input type="hidden" name="action" value="submit_edits">
                        <input type="hidden" name="username" value="<%=username%>">
                        <div class="col-xs-12">
                            <div class="well col-xs-12" id="black-well">
                                <%
                                    int count = 1;
                                    int printed = 1;
                                    String spacer = "";
                                    while((selection = selectionInfo.getSelectionById(count)) != null) {
                                        if((selection.getUser()).equals(username)) {
                                            CardInfo card = cardInfo.getCardById(selection.getCardId());
                                            if((printed % 3) == 0 && printed != selectionEntries) {
                                                spacer = " col-sm-12";
                                            }
                                            else if((printed % 3) == 1) {
                                                %><div class="col-xs-3 col-sm-1"></div><%
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                            else {
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                %>
                                <div class="col-xs-3 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container<%=selection.getCardId()%>" class="col-xs-9 col-sm-3">
                                    <input type="checkbox" name="<%=printed%>" value="<%=selection.getCardId()%>">&nbsp;
                                        <a href="#" onclick="document.getElementById('cardForm<%=selection.getCardId()%>').submit();">
                                            <span onmouseover="reveal('image<%=selection.getCardId()%>', 'container<%=selection.getCardId()%>', 'capsule')" onmouseout="conceal('image<%=selection.getCardId()%>')">
                                                <%=card.getName()%>
                                            </span>
                                        </a>
                                            , Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="total<%=selection.getCardId()%>" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12<%=spacer%>"><br></div>
                                <%
                                            printed++;
                                        }
                                        count++;
                                    }
                                %>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <h3>Destination<hr></h3>
                            <p>
                                Choose a destination for the items. If you would like to remove them from your selected items, select "Delete". If you would like to add them to a collection or deck, select "Add To Collection" or "Add To Deck" and choose the item(s) from the drop-down list.
                                <br><br>
                            </p>
                            <div class="col-xs-6">
                                <span style="float: right;">
                                    <input name="delete" type="checkbox" value="delete_selected"> Delete
                                </span>
                            </div>
                            <div class="col-xs-6"></div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-6">
                                <span style="float: right;">
                                    <input name="collection_check" type="checkbox" value="add_to_collection" > Add To Collection
                                </span>
                            </div>
                            <div class="col-xs-6">
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
                                </select>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-6">
                                <span style="float: right;">
                                    <input name="deck_check" type="checkbox" value="add_to_deck" > Add To Deck
                                </span>
                            </div>
                            <div class="col-xs-6">
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
                            </div>
                            <div class="col-xs-12"><br><br></div>
                        </div>
                        <div class="col-xs-12">
                            <div class="hidden-xs col-sm-6"></div>
                            <div class="col-xs-12 col-sm-6">
                                <button title="Submit Changes" id="form-submit" type="submit"><span class="glyphicon glyphicon-refresh"></span>&nbsp;&nbsp;Submit</button><br><br><br>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </form>
                </div>
                <%
                    count = 1;
                    while((selection = selectionInfo.getSelectionById(count)) != null) {
                        if((selection.getUser()).equals(username)) {
                            CardInfo card = cardInfo.getCardById(selection.getCardId());
                %>
                <form id="cardForm<%=selection.getCardId()%>" action="CardServlet" method="POST">
                    <input type="hidden" name="action" value="card">
                    <input type="hidden" name="id" value="<%=selection.getCardId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <img class="img-special" id="image<%=selection.getCardId()%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" href="#" style="display: none;"/>
                <%
                        }
                        count++;
                    }
                %>
            </h4>
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
            <h2>Selection Information</h2><br>
            <h4>
                <p>There is no selection information to display. Search for cards and add them to your selection in order to add them to collections or decks!</p>
                <br><br><hr>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>