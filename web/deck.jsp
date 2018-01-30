<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="deckCommentInfo" class="beans.DeckCommentInfo" scope="request"/>
<jsp:useBean id="deckFavoriteInfo" class="beans.DeckFavoriteInfo" scope="request"/>
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
    int id = Integer.parseInt(request.getParameter("id"));
    DeckInfo deck = (DeckInfo) deckInfo.getDeckById(id);
    if(deck != null) {
        DeckFavoriteInfo favorite;
        boolean favorited = false;
        int num = 1;
        while((favorite = deckFavoriteInfo.getFavoriteByNum(num)) != null) {
            if(favorite.getUser().equals(username) && favorite.getDeckId() == id) {
                favorited = true;
                break;
            }
            num++;
        }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Deck Information</h2><br>
            <h4>
                <p>Below is the selected deck's information. If you are the creator of this deck, you will be able to edit or delete it by using the buttons beneath the deck image. If you are not the creator, you may add or remove the deck from your favorites list. You may write a comment by submitting one at the bottom of the page.<p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
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
                String user = deck.getUser();
                java.util.Date dateUpdated = deck.getDateUpdated();
                String description = deck.getDescription();
            %>
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img">
                        <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img">
                    </div>
                    <br><br>
                    <div class="row" style="margin: auto;display: table">
                        <%if(deck.getUser().equals(username)) {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Deck" onclick="document.getElementById('editForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                        </div>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                            <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                        </div>
                        <form id="editForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%
                            } else {
                                if(username != null && !username.equals("")) {
                                    if(favorited) {
                        %>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                        </div>
                        <%} else {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add Deck To Favorites List" onclick="document.getElementById('favoriteForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                        </div>
                        <%}%>
                        <form id="favoriteForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%}}%>
                    </div>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h2 id="capsule">Deck: <%=name%><hr></h2>
                <h4>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Created By</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=user%></p>
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
                                    while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
                                        if(deckContents.getDeckId() == id) {
                                            CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                            if((printed % 2) == 0 && printed != entries) {
                                                spacer = " col-sm-12";
                                            }
                                            else {
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                %>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container<%=deckContents.getCardId()%>" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('image<%=deckContents.getCardId()%>', 'container<%=deckContents.getCardId()%>', 'capsule', 'your_decks')" onmouseout="conceal('image<%=deckContents.getCardId()%>')">
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
                        while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
                            if(deckContents.getDeckId() == id) {
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
                        } else {
                    %>
                    <div class="col-xs-12"><br></div>
                    <h4><p>There are no cards in this deck.</p></h4>
                    <%}%>
                </h4>
            </div>
            <div class="col-xs-12">
                <h3>Comments<hr></h3>
                <%
                    num = 1;
                    int commentCount = 0;
                    String picture;
                    DeckCommentInfo comment;
                    while((comment = (DeckCommentInfo) deckCommentInfo.getCommentByNum(num)) != null) {
                        if(comment.getDeckId() != id) {
                            num++;
                            continue;
                        }
                        java.util.Date dateAdded = comment.getDateAdded();
                        String content = comment.getText();
                        int likes = comment.getLikes();
                        int dislikes = comment.getDislikes();
                        total = likes + dislikes;
                        UserInfo owner = (UserInfo) userInfo.getUser(comment.getOwner());
                        if(owner == null) {
                            num++;
                            continue;
                        }
                        picture = owner.getPicture();
                        int commentId = comment.getId();
                %>
                <div class="row">
                    <div class="col-xs-12">
                        <h4>
                            <div class="col-xs-7 col-sm-3 col-md-2">
                                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                                <%
                                    if(username == null || username.equals("")) {
                                %>
                                <%
                                    } else if(owner.getUsername().equals(username)) {
                                %>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                    </div>
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                    </div>
                                </div>
                                <%} else {%>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteForm<%=num%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                    </div>
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteForm<%=num%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <div class="col-xs-5 col-sm-9 col-md-10">
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
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                        </div>
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>');">
                                            <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                        </div>
                                    </div>
                                    <%} else {%>
                                    <div class="row" style="margin: auto;display: table">
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteForm<%=num%>').submit();">
                                            <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                        </div>
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteForm<%=num%>').submit();">
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
                        </h4>
                    </div>
                </div>
                <form id="upvoteForm<%=num%>" action="DeckServlet" method="post">
                    <input type="hidden" name="action" value="upvote">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=likes%>">
                    <input type="hidden" name="dislikes" value="<%=dislikes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="downvoteForm<%=num%>" action="DeckServlet" method="post">
                    <input type="hidden" name="action" value="downvote">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=likes%>">
                    <input type="hidden" name="dislikes" value="<%=dislikes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                        commentCount++;
                        num++;
                    }
                    if(commentCount == 0) {
                        %><h4>There are no comments for this deck. Be the first to write one!</h4><br><br><%
                    }
                %>
            </div>
            <div class="col-xs-12">
                <br>
                <h2>Write A Comment</h2><br>
                <%
                    if(username == null || username.equals("")) {
                %>
                <h4>If you want to write a comment, first login or sign up for an account.</h4>
                <div class="col-xs-12"><br></div>
                <%} else {%>
                <h4>Use the following space to write your comment. Please use constructive rhetoric and avoid the use of profanity. We reserve the right to take down comments we find to be inappropriate.<br><br>
                <hr>
                <form id="writeCommentForm" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="comment">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="username" value="<%=username%>">
                    <textarea id="input-field" name="comment" form="writeCommentForm" required></textarea><br><br><br>
                    <div class="row">
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="col-xs-12 col-sm-4">
                            <button id="form-submit" title="Submit Comment" style="width: 100%;" type="submit">Submit</button><br><br><br>
                        </div>
                    </div>
                </form>
                <%}%>
            </div>
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
            <h2>Deck Information</h2><br>
            <h4>
                <p>The deck you selected has no information to display.</p>
                <br>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>