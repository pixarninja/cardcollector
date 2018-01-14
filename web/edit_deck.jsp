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
                    <br><br><hr>
                </h4>
            </div>
            <div class="col-xs-12">
                <h4>
                    <form id="editProfileForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="submit_edit">
                        <input type="hidden" name="username" value="<%=username%>">
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p>Deck Title</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Enter the title for this deck.<br><br>
                                <input id="input-field" name="name" type="text"><br><br>
                            </div>
                             <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p>Deck Description</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                You may enter a description for this deck.<br><br>
                                <textarea id="input-field" name="description"></textarea>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4">
                                <p>Deck Source</p>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8">
                                Choose a source for the deck. If the deck does not depend on a collection, select "Independent". If the deck must contain items from a specific collection, select "Child Of" and choose the name of the parent collection from the drop-down list.<br><br>
                                <div class="col-xs-12">
                                    <input name="source" type="radio" value="independent" checked> Independent
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
                                <%
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
                                        <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                                        <img class="cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                                    </div>
                                    <div class="col-xs-12"><br><br><br></div>
                                    <br>
                                </h4>
                            </div>
                            <div class="col-xs-12 col-sm-8">
                                <select name="cover" id="input-field">
                                    <%
                                        DeckContentsInfo deckContents;
                                        num = 1;
                                        while((deckContents = deckContentsInfo.getContentsByNum(num)) != null) {
                                            if((deckContents.getDeckId()).equals(id)) {
                                                CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                    %>
                                    <option value="<%=card.getId()%>"><%=card.getName()%></option>
                                    <%
                                            }
                                            num++;
                                        }
                                    %>
                                </select><br><br><br>
                                <input id="form-submit" type="submit" value="Submit Changes"><br><br><br>
                            </div>
                        </div>
                    </form>
                    <div class="col-xs-12"><br></div>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>