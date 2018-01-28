<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
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
%>
<%@include file="header.jsp"%>
<%
    boolean error = true;
    int count = 1;
    DeckInfo deck;
    while((deck = (DeckInfo) deckInfo.getDeckByNum(count)) != null) {
        if(deck.getUser().equals(username)) {
            error = false;
            break;
        }
        count++;
    }
    if(!error) {
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Your Decks</h2><br>
            <h4>
                <p>Below are your decks, organized by title. You may edit a deck by selecting the "Edit" button. You may delete a deck by selecting the "Delete" button. Be warned, deleting a deck is irreversible, so don't delete one you would want to keep later!<p>
                <br><p>If you would like to add a new deck, click the "New" button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="addForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;New</button>
                        </form>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
                int num = 1;
                String id;
                while((deck = (DeckInfo) deckInfo.getDeckByNum(num)) != null) {
                    if(!deck.getUser().equals(username)) {
                        num++;
                        continue;
                    }
                    id = deck.getId();
                    String name = deck.getName();
                    String top = deck.getTop();
                    if(top == null) {
                        top = "images/magic_card_back.jpg";
                    }
                    String bottom = deck.getBottom();
                    if(bottom == null) {
                        bottom = "images/magic_card_sleeves_default.jpg";
                    }
                    int entries = deck.getEntries();
                    int total = deck.getTotal();
                    String parent = deck.getParent();
                    if(parent == null || parent.equals("")) {
                    parent = "None";
                    }
                    else {
                        parent = (collectionInfo.getCollectionById(parent)).getName();
                    }
                    java.util.Date dateUpdated = deck.getDateUpdated();
                    String description = deck.getDescription();
            %>
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                        <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br></div>
                    <div class="row" style="margin: auto;display: table">
                        <div class="col-xs-4" style="margin: auto;display: table" id="button-back-left" title="View Deck Information" onclick="document.getElementById('viewForm<%=num%>').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-eye-open"></span>
                        </div>
                        <div class="col-xs-4" style="margin: auto;display: table" id="button-back-middle" title="Edit Deck" onclick="document.getElementById('editForm<%=num%>').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                        </div>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                            <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                        </div>
                    </div>
                    <form id="viewForm<%=num%>" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="deck">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <form id="editForm<%=num%>" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h2 id="capsule<%=num%>">Deck: <%=name%><hr></h2>
                <h4>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Card Total</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=total%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Unique Cards</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=entries%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Child Of</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=parent%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Date Updated</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=dateUpdated%></p>
                        </div>
                    </div>
                    <% if(description != null) {%>
                    <div class="row">
                    <div class="col-xs-12"><br></div>
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Description</p>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=description%></p>
                        </div>
                    </div>
                    <%}%>
                    <hr>
                </h4>
                <%
                    if(total != 0) {
                %>
                <div class="col-xs-12"><br></div>
                <h3>Contents</h3>
                <h4>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="well col-xs-12" id="black-well">
                                <%
                                    count = 1;
                                    int printed = 1;
                                    String spacer = "";
                                    DeckContentsInfo deckContents;
                                    while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
                                        if((deckContents.getDeckId()).equals(id)) {
                                            CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                            if((printed % 2) == 0 && printed != entries) {
                                                spacer = " col-sm-12";
                                            }
                                            else {
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                %>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container<%=deckContents.getCardId()%><%=num%>" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('image<%=deckContents.getCardId()%><%=num%>', 'container<%=deckContents.getCardId()%><%=num%>', 'capsule<%=num%>', 'your_decks')" onmouseout="conceal('image<%=deckContents.getCardId()%><%=num%>')">
                                        <a href="#" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%><%=num%>').submit();">
                                            <%=card.getName()%>
                                        </a>&nbsp;x&nbsp;<%=deckContents.getCardTotal()%>
                                    </span>
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
                        <div class="col-xs-12"><br></div>
                    </div>
                    <%
                        count = 1;
                        while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
                            if((deckContents.getDeckId()).equals(id)) {
                                CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                    %>
                    <form id="cardForm<%=deckContents.getCardId()%><%=num%>" action="CardServlet" method="POST">
                        <input type="hidden" name="action" value="card">
                        <input type="hidden" name="id" value="<%=deckContents.getCardId()%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <img class="img-special" id="image<%=deckContents.getCardId()%><%=num%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" href="#" style="display: none;"/>
                    <%
                                }
                                count++;
                            }
                        }
                    %>
                </h4>
            </div>
            <div class="col-xs-12"><br></div>
            <%
                    num++;
                }
            %>
            <form id="popupForm" action="PopupServlet" method="POST"></form>
        </div>
    </div>
</div>
<script src="js/scripts.js"></script>
<%
    } else {
%>
<!-- Error -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Your Decks</h2><br>
            <h4>
                <p>It looks like you haven't made any decks yet. If you would like to add a new deck, click the "New" button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="addForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;New</button>
                        </form>
                    </div>
                    <div class="col-xs-12"><br><br></div>
                </div>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>