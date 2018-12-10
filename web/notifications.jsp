<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="notificationInfo" class="beans.NotificationInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="cardCommentInfo" class="beans.CardCommentInfo" scope="request"/>
<jsp:useBean id="cardCommentReactionInfo" class="beans.CardCommentReactionInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckCommentInfo" class="beans.DeckCommentInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="deckCommentReactionInfo" class="beans.DeckCommentReactionInfo" scope="request"/>
<jsp:useBean id="collectionCommentInfo" class="beans.CollectionCommentInfo" scope="request"/>
<jsp:useBean id="collectionCommentReactionInfo" class="beans.CollectionCommentReactionInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckMatchInfo" class="beans.DeckMatchInfo" scope="request"/>
<jsp:useBean id="deckWinLossInfo" class="beans.DeckWinLossInfo" scope="request"/>
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
<!-- Add code here -->
<%
    if(notifications != 0) {
%>
<!-- Content -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Notifications</h2><br>
            <h4>
                <p>Below are your recent notifications. You may delete any number of notifications by selecting the checkbox and clicking the "Delete Selected" button at the bottom of the page. These notifications will remain on this page until you delete them. You may select the "Delete All Notifications" option at the bottom of the page in order to delete all of your notifications.</p>
                <br><br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="editNotificationsForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="edit_notifications">
                    <input type="hidden" name="username" value="<%=username%>">
                    <div class="col-xs-12 well" id="black-well">
                        <div class="row">
                            <div class="col-xs-12">
                                <br>
                                <div class="col-xs-1">
                                    <span class="glyphicon glyphicon-trash" style="position: relative;left: -3px;"></span>
                                </div>
                                <div class="col-xs-11">
                                    Notification Details
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <%
                            int count = 1;
                            int num = 0;
                            NotificationInfo notification;
                            while((notification = notificationInfo.getNotificationByNum(count)) != null) {
                                if(notification.getOwner().equals(username)) {
                                    num++;
                                    java.util.Date dateAdded;
                                    String content;
                                    int likes;
                                    int dislikes;
                                    int total;
                                    UserInfo owner;
                                    String picture;
                                    int commentId;
                                    if(notification.getType() == 0) { // card comment reaction
                                        CardCommentInfo cardComment = cardCommentInfo.getCommentById(notification.getTypeId());
                                        if(cardComment == null) {count++; continue;}
                                        CardInfo card = cardInfo.getCardById(cardComment.getCardId());
                                        if(card == null) {count++; continue;}
                                        dateAdded = cardComment.getDateAdded();
                                        content = cardComment.getText();
                                        likes = cardComment.getLikes();
                                        dislikes = cardComment.getDislikes();
                                        total = likes + dislikes;
                                        owner = (UserInfo) userInfo.getUser(cardComment.getOwner());
                                        if(owner == null) {count++; continue;}
                                        picture = owner.getPicture();
                                        commentId = cardComment.getId();
                                        String reaction;
                                        if(notification.getStatus() == 0) {
                                            reaction = "liked";
                                        } else {
                                            reaction = "disliked";
                                        }
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> <%=reaction%> your comment on <a style="cursor: pointer;" onclick="document.getElementById('cardCommentForm<%=count%>').submit();"><%=card.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%
                                            } else if(owner.getUsername().equals(username)) {
                                        %>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                            <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%
                                                } else if(owner.getUsername().equals(username)) {
                                            %>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=content%>
                                                </p><hr>
                                                <%=likes%> out of <%=total%> people found this comment helpful
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=likes%> out of <%=total%> people found this comment helpful
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                            }
                            if(notification.getType() == 1) { // deck comment
                                DeckCommentInfo deckComment = deckCommentInfo.getCommentById(notification.getTypeId());
                                if(deckComment == null) {count++; continue;}
                                DeckInfo deck = deckInfo.getDeckById(deckComment.getDeckId());
                                if(deck == null) {count++; continue;}
                                dateAdded = deckComment.getDateAdded();
                                content = deckComment.getText();
                                likes = deckComment.getLikes();
                                dislikes = deckComment.getDislikes();
                                total = likes + dislikes;
                                owner = (UserInfo) userInfo.getUser(deckComment.getOwner());
                                if(owner == null) {count++; continue;}
                                picture = owner.getPicture();
                                commentId = deckComment.getId();
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> commented on your deck, <a style="cursor: pointer;" onclick="document.getElementById('deckCommentForm<%=count%>').submit();"><%=deck.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%
                                            } else if(owner.getUsername().equals(username)) {
                                        %>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=deckComment.getDeckId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=deckComment.getDeckId()%>', '<%=commentId%>', '<%=username%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                            </div>
                                        </div>
                                        <%} else {%>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteDeckForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteDeckForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                            <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%
                                                } else if(owner.getUsername().equals(username)) {
                                            %>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=deck.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=deck.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                                </div>
                                            </div>
                                            <%} else {%>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteDeckForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteDeckForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=content%>
                                                </p><hr>
                                                <%=likes%> out of <%=total%> people found this comment helpful
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=likes%> out of <%=total%> people found this comment helpful
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                            }
                            if(notification.getType() == 2) { // deck comment reaction
                                DeckCommentInfo deckComment = deckCommentInfo.getCommentById(notification.getTypeId());
                                if(deckComment == null) {count++; continue;}
                                DeckInfo deck = deckInfo.getDeckById(deckComment.getDeckId());
                                if(deck == null) {count++; continue;}
                                dateAdded = deckComment.getDateAdded();
                                content = deckComment.getText();
                                likes = deckComment.getLikes();
                                dislikes = deckComment.getDislikes();
                                total = likes + dislikes;
                                owner = (UserInfo) userInfo.getUser(deckComment.getOwner());
                                if(owner == null) {count++; continue;}
                                picture = owner.getPicture();
                                commentId = deckComment.getId();
                                String reaction;
                                if(notification.getStatus() == 0) {
                                    reaction = "liked";
                                } else {
                                    reaction = "disliked";
                                }
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> <%=reaction%> your comment on <a style="cursor: pointer;" onclick="document.getElementById('deckCommentReactionForm<%=count%>').submit();"><%=deck.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%
                                            } else if(owner.getUsername().equals(username)) {
                                        %>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=deck.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=deck.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                            <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%
                                                } else if(owner.getUsername().equals(username)) {
                                            %>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=deck.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=deck.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=content%>
                                                </p><hr>
                                                <%=likes%> out of <%=total%> people found this comment helpful
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=likes%> out of <%=total%> people found this comment helpful
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                            }
                            if(notification.getType() == 3) { // collection comment
                                CollectionCommentInfo collectionComment = collectionCommentInfo.getCommentById(notification.getTypeId());
                                if(collectionComment == null) {count++; continue;}
                                CollectionInfo collection = collectionInfo.getCollectionById(collectionComment.getCollectionId());
                                if(collection == null) {count++; continue;}
                                dateAdded = collectionComment.getDateAdded();
                                content = collectionComment.getText();
                                likes = collectionComment.getLikes();
                                dislikes = collectionComment.getDislikes();
                                total = likes + dislikes;
                                owner = (UserInfo) userInfo.getUser(collectionComment.getOwner());
                                if(owner == null) {count++; continue;}
                                picture = owner.getPicture();
                                commentId = collectionComment.getId();
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> commented on your collection, <a style="cursor: pointer;" onclick="document.getElementById('collectionCommentForm<%=count%>').submit();"><%=collection.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%
                                            } else if(owner.getUsername().equals(username)) {
                                        %>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCollectionCommentPopup('<%=collectionComment.getCollectionId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCollectionCommentPopup('<%=collectionComment.getCollectionId()%>', '<%=commentId%>', '<%=username%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                            </div>
                                        </div>
                                        <%} else {%>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteCollectionForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteCollectionForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                            <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%
                                                } else if(owner.getUsername().equals(username)) {
                                            %>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCollectionCommentPopup('<%=collection.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCollectionCommentPopup('<%=collection.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                                </div>
                                            </div>
                                            <%} else {%>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteCollectionForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteCollectionForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=content%>
                                                </p><hr>
                                                <%=likes%> out of <%=total%> people found this comment helpful
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=likes%> out of <%=total%> people found this comment helpful
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                            }
                            if(notification.getType() == 4) { // collection comment reaction
                                CollectionCommentInfo collectionComment = collectionCommentInfo.getCommentById(notification.getTypeId());
                                if(collectionComment == null) {count++; continue;}
                                CollectionInfo collection = collectionInfo.getCollectionById(collectionComment.getCollectionId());
                                if(collection == null) {count++; continue;}
                                dateAdded = collectionComment.getDateAdded();
                                content = collectionComment.getText();
                                likes = collectionComment.getLikes();
                                dislikes = collectionComment.getDislikes();
                                total = likes + dislikes;
                                owner = (UserInfo) userInfo.getUser(collectionComment.getOwner());
                                if(owner == null) {count++; continue;}
                                picture = owner.getPicture();
                                commentId = collectionComment.getId();
                                String reaction;
                                if(notification.getStatus() == 0) {
                                    reaction = "liked";
                                } else {
                                    reaction = "disliked";
                                }
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> <%=reaction%> your comment on <a style="cursor: pointer;" onclick="document.getElementById('collectionCommentReactionForm<%=count%>').submit();"><%=collection.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%
                                            } else if(owner.getUsername().equals(username)) {
                                        %>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCollectionCommentPopup('<%=collection.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCollectionCommentPopup('<%=collection.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                            <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%
                                                } else if(owner.getUsername().equals(username)) {
                                            %>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCollectionCommentPopup('<%=collection.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCollectionCommentPopup('<%=collection.getId()%>', '<%=commentId%>', '<%=username%>');">
                                                    <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=content%>
                                                </p><hr>
                                                <%=likes%> out of <%=total%> people found this comment helpful
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=likes%> out of <%=total%> people found this comment helpful
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                            }
                            if(notification.getType() == 5) { // match update
                                DeckMatchInfo deckMatch = DeckMatchInfo.getMatchById(notification.getTypeId());
                                if(deckMatch == null) {count++; continue;}
                                DeckInfo challengerDeck = deckInfo.getDeckById(deckMatch.getChallengerId());
                                if(challengerDeck == null) {count++; continue;}
                                DeckInfo ownerDeck = deckInfo.getDeckById(deckMatch.getOwnerId());
                                if(ownerDeck == null) {count++; continue;}
                                dateAdded = deckMatch.getDateAdded();
                                content = deckMatch.getText();
                                UserInfo challenger = (UserInfo) userInfo.getUser(challengerDeck.getUser());
                                if(challenger == null) {count++; continue;}
                                owner = (UserInfo) userInfo.getUser(ownerDeck.getUser());
                                if(owner == null) {count++; continue;}
                                picture = challenger.getPicture();
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> challenged your deck, <a style="cursor: pointer;" onclick="document.getElementById('ownerDeckForm<%=count%>').submit();"><%=ownerDeck.getName()%></a>, with their deck, <a style="cursor: pointer;" onclick="document.getElementById('challengerDeckForm<%=count%>').submit();"><%=challengerDeck.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%} else {%>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Accept Match" onclick="document.getElementById('acceptMatchForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-ok"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Reject Match" onclick="document.getElementById('rejectMatchForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-remove"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Challenger: </span><%=challenger.getUsername()%></p>
                                            <p><span id="title">Date Played: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%} else {%>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Accept Match" onclick="document.getElementById('acceptMatchForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-ok"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Reject Match" onclick="document.getElementById('rejectMatchForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-remove"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=content%>
                                                </p><hr>
                                                <%=challenger.getUsername()%> won <%=deckMatch.getWon()%> times out of <%=deckMatch.getMatches()%> matches
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=challenger.getUsername()%> won <%=deckMatch.getWon()%> times out of <%=deckMatch.getMatches()%> matches
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                            }
                            if(notification.getType() == 6) { // winloss update
                                DeckWinLossInfo deckWinLoss = deckWinLossInfo.getWinLossById(notification.getTypeId());
                                UserInfo verifier = userInfo.getUser(deckWinLoss.getVerifierId());
                                if(verifier == null) {count++; continue;}
                                DeckInfo ownerDeck = deckInfo.getDeckById(deckWinLoss.getOwnerId());
                                if(ownerDeck == null) {count++; continue;}
                                dateAdded = deckWinLoss.getDateAdded();
                                owner = (UserInfo) userInfo.getUser(ownerDeck.getUser());
                                if(owner == null) {count++; continue;}
                                picture = owner.getPicture();
                        %>
                        <div class="col-xs-1">
                            <input type="checkbox" name="<%=num%>" value="<%=notification.getId()%>">
                        </div>
                        <div class="col-xs-11">
                            <div class="row">
                                <div class="col-xs-12">
                                    <p><span id="title">Date Added:</span> <%=notification.getDateAdded()%></p>
                                    <p><span id="title">Notification: </span> <%=notification.getUser()%> would like you to verify their win/loss update for their deck, <a style="cursor: pointer;" onclick="document.getElementById('ownerDeckForm<%=count%>').submit();"><%=ownerDeck.getName()%></a></p>
                                    <br>
                                    <div class="col-xs-7 col-sm-3">
                                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"><br>
                                        <%
                                            if(username == null || username.equals("")) {
                                        %>
                                        <%} else {%>
                                        <div class="row" style="margin: auto;display: table">
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Verify Update" onclick="document.getElementById('verifyWinLossForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-ok"></span>
                                            </div>
                                            <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Reject Update" onclick="document.getElementById('rejectWinLossForm<%=count%>').submit();">
                                                <span id="button-symbol" class="glyphicon glyphicon-remove"></span>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                    <div class="col-xs-5 col-sm-9">
                                        <div class="row">
                                            <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                            <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                            <%
                                                if(username == null || username.equals("")) {
                                            %>
                                            <%} else {%>
                                            <div class="row" style="margin: auto;display: table">
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Verify Update" onclick="document.getElementById('verifyWinLossForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-ok"></span>
                                                </div>
                                                <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Reject Update" onclick="document.getElementById('rejectWinLossForm<%=count%>').submit();">
                                                    <span id="button-symbol" class="glyphicon glyphicon-remove"></span>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="well hidden-xs col-sm-12" id="black-well">
                                                <p>
                                                    <%=owner.getUsername()%> has won <%=deckWinLoss.getWon()%> times out of <%=deckWinLoss.getMatches()%> matches
                                                </p><hr>
                                                Please verify that this is correct.
                                                <br>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                    <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                        <p>
                                            <%=owner.getUsername()%> has won <%=deckWinLoss.getWon()%> times out of <%=deckWinLoss.getMatches()%> matches
                                        </p><hr>
                                        Please verify that this is correct.
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br><br></div>
                        <%
                                    }
                                }
                                count++;
                            }
                        %>
                        <input type="hidden" name="<%=num + 1%>" value="ENDTOKEN">
                        <div class="row">
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="col-xs-1">
                                    <input type="checkbox" name="0" value="delete_all">
                                </div>
                                <div class="col-xs-11">
                                    Delete All Notifications
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="col-xs-12 col-sm-4">
                            <br>
                            <button title="Delete Selected Notifications" id="form-submit" type="submit">Delete Selected</button><br><br><br>
                        </div>
                    </div>
                </form>
                <%
                    count = 1;
                    while((notification = notificationInfo.getNotificationByNum(count)) != null) {
                        if(notification.getOwner().equals(username)) {
                            int commentId = notification.getTypeId();
                            if(notification.getType() == 0) {
                                CardCommentInfo cardComment = cardCommentInfo.getCommentById(notification.getTypeId());
                                if(cardComment == null) {count++; continue;}
                %>
                <form id="cardCommentForm<%=count%>" action="CardServlet" method="POST">
                    <input type="hidden" name="action" value="card">
                    <input type="hidden" name="id" value="<%=cardComment.getCardId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    }
                    if(notification.getType() == 1) {
                        DeckCommentInfo deckComment = deckCommentInfo.getCommentById(notification.getTypeId());
                        if(deckComment == null) {count++; continue;}
                %>
                <form id="deckCommentForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="deck">
                    <input type="hidden" name="id" value="<%=deckComment.getDeckId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="upvoteDeckForm<%=count%>" action="DeckServlet" method="post">
                    <input type="hidden" name="action" value="upvote">
                    <input type="hidden" name="id" value="<%=deckComment.getDeckId()%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=deckComment.getLikes()%>">
                    <input type="hidden" name="dislikes" value="<%=deckComment.getDislikes()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="downvoteDeckForm<%=count%>" action="DeckServlet" method="post">
                    <input type="hidden" name="action" value="downvote">
                    <input type="hidden" name="id" value="<%=deckComment.getDeckId()%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=deckComment.getLikes()%>">
                    <input type="hidden" name="dislikes" value="<%=deckComment.getDislikes()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    }
                    if(notification.getType() == 2) {
                        DeckCommentReactionInfo deckCommentReaction = deckCommentReactionInfo.getReactionById(notification.getTypeId());
                        if(deckCommentReaction == null) {count++; continue;}
                        DeckCommentInfo deckComment = deckCommentInfo.getCommentById(deckCommentReaction.getCommentId());
                        if(deckComment == null) {count++; continue;}
                %>
                <form id="deckCommentReactionForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="deck">
                    <input type="hidden" name="id" value="<%=deckComment.getDeckId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    }
                    if(notification.getType() == 3) {
                        CollectionCommentInfo collectionComment = collectionCommentInfo.getCommentById(notification.getTypeId());
                        if(collectionComment == null) {count++; continue;}
                %>
                <form id="collectionCommentForm<%=count%>" action="CollectionServlet" method="POST">
                    <input type="hidden" name="action" value="collection">
                    <input type="hidden" name="id" value="<%=collectionComment.getCollectionId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="upvoteCollectionForm<%=count%>" action="CollectionServlet" method="post">
                    <input type="hidden" name="action" value="upvote">
                    <input type="hidden" name="id" value="<%=collectionComment.getCollectionId()%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=collectionComment.getLikes()%>">
                    <input type="hidden" name="dislikes" value="<%=collectionComment.getDislikes()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="downvoteCollectionForm<%=count%>" action="CollectionServlet" method="post">
                    <input type="hidden" name="action" value="downvote">
                    <input type="hidden" name="id" value="<%=collectionComment.getCollectionId()%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=collectionComment.getLikes()%>">
                    <input type="hidden" name="dislikes" value="<%=collectionComment.getDislikes()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    }
                    if(notification.getType() == 4) {
                        CollectionCommentInfo collectionComment = collectionCommentInfo.getCommentById(notification.getTypeId());
                        if(collectionComment == null) {count++; continue;}
                %>
                <form id="collectionCommentReactionForm<%=count%>" action="CollectionServlet" method="POST">
                    <input type="hidden" name="action" value="collection">
                    <input type="hidden" name="id" value="<%=collectionComment.getCollectionId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    }
                    if(notification.getType() == 5) {
                        DeckMatchInfo deckMatch = deckMatchInfo.getMatchById(notification.getTypeId());
                        if(deckMatch == null) {count++; continue;}
                %>
                <form id="ownerDeckForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="deck">
                    <input type="hidden" name="id" value="<%=deckMatch.getOwnerId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="challengerDeckForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="deck">
                    <input type="hidden" name="id" value="<%=deckMatch.getChallengerId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="acceptMatchForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="accept_match">
                    <input type="hidden" name="match_id" value="<%=deckMatch.getId()%>">
                    <input type="hidden" name="notification_id" value="<%=notification.getId()%>">
                    <input type="hidden" name="challenger_id" value="<%=deckMatch.getChallengerId()%>">
                    <input type="hidden" name="id" value="<%=deckMatch.getOwnerId()%>">
                    <input type="hidden" name="won" value="<%=deckMatch.getWon()%>">
                    <input type="hidden" name="matches" value="<%=deckMatch.getMatches()%>">
                    <input type="hidden" name="prev_won" value="<%=deckMatch.getPrevWon()%>">
                    <input type="hidden" name="prev_matches" value="<%=deckMatch.getPrevMatches()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="rejectMatchForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="reject_match">
                    <input type="hidden" name="match_id" value="<%=deckMatch.getId()%>">
                    <input type="hidden" name="notification_id" value="<%=notification.getId()%>">
                    <input type="hidden" name="id" value="<%=deckMatch.getOwnerId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    }
                    if(notification.getType() == 6) {
                        DeckWinLossInfo deckWinLoss = deckWinLossInfo.getWinLossById(notification.getTypeId());
                        if(deckWinLoss == null) {count++; continue;}
                %>
                <form id="ownerDeckForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="deck">
                    <input type="hidden" name="id" value="<%=deckWinLoss.getOwnerId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="verifyWinLossForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="verify_winloss">
                    <input type="hidden" name="winloss_id" value="<%=deckWinLoss.getId()%>">
                    <input type="hidden" name="notification_id" value="<%=notification.getId()%>">
                    <input type="hidden" name="id" value="<%=deckWinLoss.getOwnerId()%>">
                    <input type="hidden" name="won" value="<%=deckWinLoss.getWon()%>">
                    <input type="hidden" name="matches" value="<%=deckWinLoss.getMatches()%>">
                    <input type="hidden" name="prev_won" value="<%=deckWinLoss.getPrevWon()%>">
                    <input type="hidden" name="prev_matches" value="<%=deckWinLoss.getPrevMatches()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="rejectWinLossForm<%=count%>" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="reject_winloss">
                    <input type="hidden" name="winloss_id" value="<%=deckWinLoss.getId()%>">
                    <input type="hidden" name="notification_id" value="<%=notification.getId()%>">
                    <input type="hidden" name="id" value="<%=deckWinLoss.getOwnerId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                            }
                        }
                        count++;
                    }
                %>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
    </div>
</div>
<%} else {%>
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Notifications</h2><br>
            <h4>
                <p>You have no notifications. Check back later after another user has commented on one of your decks or collections, or reacted to one of your comments.</p>
                <br><br>
            </h4>
        </div>
    </div>
</div>
<%}%>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>