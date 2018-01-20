<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="collectionContentsInfo" class="beans.CollectionContentsInfo" scope="request"/>
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
    CollectionInfo collection = (CollectionInfo) collectionInfo.getCollectionById(username + "1");
    if(collection != null) {
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Your Collections</h2><br>
            <h4>
                <p>Below are your collections, organized by title. You may edit a collection by selecting the "Edit" button. You may delete a collection by selecting the "Delete" button. Be warned, deleting a collection is irreversible, so don't delete one you would want to keep later!<p>
                <br><p>If you would like to add a new collection, click the "New" button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="newForm" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Collection" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;New</button>
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
                while((collection = (CollectionInfo) collectionInfo.getCollectionById(id)) != null) {
                    String name = collection.getName();
                    String top = collection.getTop();
                    if(top == null) {
                        top = "images/magic_card_back.png";
                    }
                    String middle = collection.getMiddle();
                    if(middle == null) {
                        middle = "images/magic_card_back.png";
                    }
                    String bottom = collection.getBottom();
                    if(bottom == null) {
                        bottom = "images/magic_card_back.png";
                    }
                    int entries = collection.getEntries();
                    int total = collection.getTotal();
                    String parent = collection.getParent();
                    if(parent == null) {
                        parent = "None";
                    }
                    java.util.Date dateUpdated = collection.getDateUpdated();
                    String description = collection.getDescription();
            %>
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="collection-image">
                        <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                        <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>" id="center-img"></img>
                        <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="viewForm" action="CollectionServlet" method="POST">
                        <input type="hidden" name="action" value="collection">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="View Collection Information" id="form-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;Collection</button>
                    </form>
                    <form id="editForm" action="CollectionServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Edit Collection" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                    </form>
                    <form id="deleteForm" action="CollectionServlet" method="POST">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%=id%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Delete Collection" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
                    </form>
                    <br>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h2>Collection: <%=name%><hr></h2>
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
                        <div class="col-xs-6 col-md-9">
                            <p><%=parent%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-8 col-md-3">
                            <p id="title">Date Updated</p>
                        </div>
                        <div class="col-xs-6 col-md-9">
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
                <h4 id="capsule<%=num%>">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="well col-xs-12" id="black-well">
                                <%
                                    int count = 1;
                                    int printed = 1;
                                    String spacer = "";
                                    CollectionContentsInfo collectionContents;
                                    while((collectionContents = collectionContentsInfo.getContentsById(count)) != null) {
                                        if((collectionContents.getCollectionId()).equals(id)) {
                                            CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                            if((printed % 2) == 0 && printed != entries) {
                                                spacer = " col-sm-12";
                                            }
                                            else {
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                %>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container<%=collectionContents.getCardId()%>" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('image<%=collectionContents.getCardId()%>', 'container<%=collectionContents.getCardId()%>', 'capsule<%=num%>')" onmouseout="conceal('image<%=collectionContents.getCardId()%>')">
                                        <a href="#" onclick="document.getElementById('cardForm<%=collectionContents.getCardId()%>').submit();">
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
                        while((collectionContents = collectionContentsInfo.getContentsById(count)) != null) {
                            if((collectionContents.getCollectionId()).equals(id)) {
                                CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                    %>
                    <form id="cardForm<%=collectionContents.getCardId()%>" action="CardServlet" method="POST">
                        <input type="hidden" name="action" value="card">
                        <input type="hidden" name="id" value="<%=collectionContents.getCardId()%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <img class="img-special" id="image<%=collectionContents.getCardId()%>" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" href="#" style="display: none;"/>
                    <%
                                }
                                count++;
                            }
                        }
                    %>
                </h4>
            </div>
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
            <h2>Your Collections</h2><br>
            <h4>
                <p>It looks like you haven't made any collections yet. If you would like to add a new collection, click the "New" button below:</p>
                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-4 col-md-3">
                        <form id="newForm" action="CollectionServlet" method="POST">
                            <input type="hidden" name="action" value="new">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="New Collection" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;New</button>
                        </form>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <hr>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>