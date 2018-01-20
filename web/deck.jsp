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
    UserInfo user = userInfo.getUser(username);
    String picture;
    if(user == null) {
        picture = "images/icons/battered-axe.png";
    }
    else {
        picture = user.getPicture();
    }
    String id = request.getParameter("id");
    DeckInfo deck = (DeckInfo) deckInfo.getDeckById(id);
    if(deck != null) {
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Deck Information</h2><br>
            <h4>
                <p>Below is the selected deck's information. You may add the cards from this deck to your selected items by clicking the "Add" button. Cards in your selected items can be placed into collections. You may view the user's information page by clicking the "User" link. You may write a comment by clicking the "Comment" button.<p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
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
                    <div class="well deck-image" id="black-well">
                        <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                        <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="viewForm" action="UserServlet" method="POST">
                        <input type="hidden" name="action" value="user">
                        <input type="hidden" name="user" value="<%=deck.getUser()%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="View User Information" id="form-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;User</button>
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
                <h2>Deck: <%=name%><hr></h2>
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
                        <div class="col-xs-12"><br></div>
                    </div>
                    <% if(description != null) {%>
                    <div class="row">
                    <div class="col-xs-12"><br></div>
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Description</p>
                        </div>
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
                <h4 id="capsule">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="col-xs-12">
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
                                <div class="col-xs-3 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container<%=deckContents.getCardId()%>" class="col-xs-9 col-sm-6">
                                    <span onmouseover="reveal('image<%=deckContents.getCardId()%>', 'container<%=deckContents.getCardId()%>', 'capsule')" onmouseout="conceal('image<%=deckContents.getCardId()%>')">
                                        <a href="#" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
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
                    <form id="cardForm<%=deckContents.getCardId()%>" action="CardServlet" method="POST">
                        <input type="hidden" name="action" value="card">
                        <input type="hidden" name="id" value="<%=deckContents.getCardId()%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <img class="img-special" id="image<%=deckContents.getCardId()%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" href="#" style="display: none;"/>
                    <%
                            }
                            count++;
                        }
                    %>
                </h4>
                <%
                    }
                %>
            </div>
            <div class="col-xs-12">
                <h3>Comments<hr></h3>
                <h4>
                    <div class="row">
                        <div class="col-xs-7 col-sm-4 col-md-3">
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="newForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="edit_comment">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Edit Comment" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                            </form>
                            <form id="newForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="delete_comment">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Delete Comment" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
                            </form>
                        </div>
                        <div class="col-xs-5 col-sm-8 col-md-9">
                            <div class="row">
                                <p>Name</p>
                                <p>Date</p>
                                <div class="hidden-xs">
                                    <hr id="in-line-hr">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet quam pretium lacus convallis ultricies eu sed metus. Vestibulum a molestie quam. Praesent in scelerisque tortor. Etiam vulputate orci et erat imperdiet feugiat. Praesent bibendum non purus vel consequat. Quisque a venenatis ex. Pellentesque consequat neque dui, eget commodo ipsum fermentum vel. Donec lacinia feugiat elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis quis diam augue. Vivamus accumsan consectetur nibh vel sodales. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed nec tellus eget est rutrum tempus et at dui.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet quam pretium lacus convallis ultricies eu sed metus. Vestibulum a molestie quam. Praesent in scelerisque tortor. Etiam vulputate orci et erat imperdiet feugiat. Praesent bibendum non purus vel consequat. Quisque a venenatis ex. Pellentesque consequat neque dui, eget commodo ipsum fermentum vel. Donec lacinia feugiat elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis quis diam augue. Vivamus accumsan consectetur nibh vel sodales. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed nec tellus eget est rutrum tempus et at dui.</p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
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
            <h2>Deck Information</h2><br>
            <h4>
                <p>The deck you selected has no information to display.</p>
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