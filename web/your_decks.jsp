<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
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
    DeckInfo deck = (DeckInfo) deckInfo.getDeckById(username + "1");
    if(deck != null) {
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
                String id = username + num;
                while((deck = (DeckInfo) deckInfo.getDeckById(id)) != null) {
                    String name = deck.getName();
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
                    String parent = deck.getParent();
                    if(parent == null) {
                        parent = "None";
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
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="viewForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="deck">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="View Deck Information" id="form-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;Deck</button>
                    </form>
                    <form id="editForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Edit Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                    </form>
                    <form id="deleteForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Delete Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
                    </form>
                    <br>
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
                                    int count = 1;
                                    int printed = 1;
                                    String spacer = "";
                                    DeckContentsInfo deckContents;
                                    while((deckContents = deckContentsInfo.getContentsById(count)) != null) {
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
                                    <span onmouseover="reveal('image<%=deckContents.getCardId()%><%=num%>', 'container<%=deckContents.getCardId()%><%=num%>', 'capsule<%=num%>')" onmouseout="conceal('image<%=deckContents.getCardId()%><%=num%>')">
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
                        while((deckContents = deckContentsInfo.getContentsById(count)) != null) {
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
                    id = username + num;
                }
            %>
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
                    <div class="col-xs-12"><br><br><br></div>
                </div>
                <hr>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>