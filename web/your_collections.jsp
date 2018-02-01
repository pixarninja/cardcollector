<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="collectionContentsInfo" class="beans.CollectionContentsInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
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
    boolean error = true;
    int count = 1;
    CollectionInfo collection;
    while((collection = (CollectionInfo) collectionInfo.getCollectionByNum(count)) != null) {
        if(collection.getUser().equals(username)) {
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
            <h2>Your Collections</h2><br>
            <h4>
                <p>Below are your collections, organized by title. You may view a collection's information (including comments) by clicking the eye button. You may edit a collection by selecting the edit button. You may delete a collection by selecting the trashcan button. Be warned, deleting a collection is irreversible, so don't delete one you would want to keep later!<p>
                <br><p>If you would like to add a new collection, click the button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="addForm" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Create New Collection" id="form-submit" type="submit">New</button>
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
                int id;
                while((collection = (CollectionInfo) collectionInfo.getCollectionByNum(num)) != null) {
                    if(!collection.getUser().equals(username)) {
                        num++;
                        continue;
                    }
                    id = collection.getId();
                    String name = collection.getName();
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
                    int entries = collection.getEntries();
                    int total = collection.getTotal();
                    java.util.Date dateUpdated = collection.getDateUpdated();
                    String description = collection.getDescription();
            %>
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="collection-image">
                        <img class="buffer" width="100%" src="images/buffer.png" id="center-img">
                        <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>">
                        <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>">
                        <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>">
                        <br><br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-4" style="margin: auto;display: table" id="button-back-left" title="View Collection Information" onclick="document.getElementById('viewForm<%=num%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-eye-open"></span>
                            </div>
                            <div class="col-xs-4" style="margin: auto;display: table" id="button-back-middle" title="Edit Collection" onclick="document.getElementById('editForm<%=num%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                            </div>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Collection" onclick="deleteCollectionPopup('<%=id%>', '<%=username%>');">
                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                            </div>
                        </div>
                        <form id="viewForm<%=num%>" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="collection">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <form id="editForm<%=num%>" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                    </div>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h2 id="capsule<%=num%>">Collection: <%=name%><hr></h2>
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
                                    CollectionContentsInfo collectionContents;
                                    while((collectionContents = collectionContentsInfo.getContentsByNum(count)) != null) {
                                        if(collectionContents.getCollectionId() == id) {
                                            CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                            if((printed % 2) == 0 && printed != entries) {
                                                spacer = " col-sm-12";
                                            }
                                            else {
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                %>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container<%=collectionContents.getCardId()%><%=num%>" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('image<%=collectionContents.getCardId()%><%=num%>', 'container<%=collectionContents.getCardId()%><%=num%>', 'capsule<%=num%>', 'your_collections')" onmouseout="conceal('image<%=collectionContents.getCardId()%><%=num%>')">
                                        <a href="#" onclick="document.getElementById('cardForm<%=collectionContents.getCardId()%><%=num%>').submit();">
                                            <%=card.getName()%>
                                        </a>&nbsp;x&nbsp;<%=collectionContents.getCardTotal()%>
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
                        while((collectionContents = collectionContentsInfo.getContentsByNum(count)) != null) {
                            if(collectionContents.getCollectionId() == id) {
                                CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                    %>
                    <form id="cardForm<%=collectionContents.getCardId()%><%=num%>" action="CardServlet" method="POST">
                        <input type="hidden" name="action" value="card">
                        <input type="hidden" name="id" value="<%=collectionContents.getCardId()%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <img class="img-special" id="image<%=collectionContents.getCardId()%><%=num%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" href="#" style="display: none;"/>
                    <%
                                }
                                count++;
                            }
                        } else {
                    %>
                    <div class="col-xs-12"><br></div>
                    <h4><p>There are no cards in this collection.</p></h4>
                    <%}%>
                </h4>
            </div>
            <div class="col-xs-12"><br></div>
            <%
                    num++;
                }
            %>
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
            <h2>Your Collections</h2><br>
            <h4>
                <p>It looks like you haven't made any collections yet. If you would like to add a new collection, click the button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="addForm" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Deck" id="form-submit" type="submit">New</button>
                        </form>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>