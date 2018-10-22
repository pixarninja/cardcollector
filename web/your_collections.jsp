<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
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
                <p>Below are your collections, organized by title. You may view a collection's information (including comments) by clicking the eye button. You may edit a collection by selecting the pencil button. You may delete a collection by selecting the trashcan button. Be warned, deleting a collection is irreversible, so don't delete one you would want to keep later!<p>
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
                <h2 id="capsule<%=num%>"><%=name%><hr></h2>
                <h4>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Date Updated</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=dateUpdated%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
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
                            <button title="New Collection" id="form-submit" type="submit">New</button>
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