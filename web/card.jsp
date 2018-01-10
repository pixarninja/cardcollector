<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="cardCommentInfo" class="beans.CardCommentInfo" scope="request"/>
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
    String id = request.getParameter("id");
    ArrayList<String> icons = new ArrayList();
    CardInfo card = (CardInfo) cardInfo.getCardById(id);
    if(card != null) {
        String game = card.getGame();
        String name = card.getName();
        String edition = card.getSetName();
        String rarity = card.getRarity();
        char lowercase = rarity.charAt(0);
        String captital = ("" + lowercase).toUpperCase();
        rarity = captital + rarity.substring(1);
        String front = card.getFront();
        String back = card.getBack();
        String[] parsedCost = card.getManaCost().split("}");
        int i;
        for(i = 0; i < parsedCost.length; i++) {
            String symbol = parsedCost[i] + "}";
            symbol = symbol.replaceAll(Pattern.quote("/"),"-");
            icons.add("images/" + symbol + ".png");
        }
        String type = card.getType();
        String colors;
        if(card.getColors() != null && card.getColors() != "") {
            colors = "";
            for(i = 0; i < parsedCost.length; i++) {
                String symbol = parsedCost[i].substring(1);
                if(symbol.contains("W")) {
                    if(colors.equals("")) {
                        colors = "White";
                    }
                    else {
                        colors = colors + ", White";
                    }
                } else if (symbol.contains("U")) {
                    if(colors.equals("")) {
                        colors = "Blue";
                    }
                    else {
                        colors = colors + ", Blue";
                    }
                } else if (symbol.contains("B")) {
                    if(colors.equals("")) {
                        colors = "Black";
                    }
                    else {
                        colors = colors + ", Black";
                    }
                } else if (symbol.contains("R")) {
                    if(colors.equals("")) {
                        colors = "Red";
                    }
                    else {
                        colors = colors + ", Red";
                    }
                } else if (symbol.contains("G")) {
                    if(colors.equals("")) {
                        colors = "Green";
                    }
                    else {
                        colors = colors + ", Green";
                    }
                }
            }
            if(colors.equals("") || (card.getText() != null && card.getText().contains("Devoid"))) {
                colors = "Devoid";
            }
        }
        else {
            colors = "Devoid";
        }
        /* Optional Parameters */
        String text = null;
        String flavor = null;
        String power = null;
        String toughness = null;
        String loyalty = null;
        String artist = card.getArtist();
        String year;
        if(card.getYear().equals("future")) {
            year = "Future";
        }
        else {
            year = card.getYear();
        }
        if(card.getText() != null && card.getText() != "") {
            text = card.getText();
        }
        if(card.getFlavor() != null && card.getFlavor() != "") {
            flavor = card.getFlavor();
        }
        if(card.getPower() != null && card.getPower() != "") {
            power = card.getPower();
        }
        if(card.getToughness() != null && card.getToughness() != "") {
            toughness = card.getToughness();
        }
        if(card.getLoyalty() != null && card.getLoyalty() != "") {
            loyalty = card.getLoyalty();
        }
%>
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Card Information</h2><br>
            <h4>
                <p>Below is the selected card's information. You may add this card to your selected items by clicking the "Add" button. Cards in your selected items can be placed into collections. You may write a comment by clicking the "Comment" button.</p>
                <br><br>
            </h4>
        </div>
        <div class="well col-xs-12" id="black-well">
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=back%>" alt="<%=back%>" id="center-img"></img>
                        <img class="cover" width="100%" src="<%=front%>" alt="<%=front%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="addToSelectionForm" action="SelectionServlet" method="POST">
                        <input type="hidden" name="action" value="add_card_to_selection">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Add To Selection" id="form-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                    </form>
                    <!--<form id="removeFromSelectionForm" action="SelectionServlet" method="POST">
                        <input type="hidden" name="action" value="remove_card_from_selection">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Remove From Selection" id="form-submit" type="submit"><span class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;Remove</button>
                    </form>-->
                    <form id="addFavoriteForm" action="UserServlet" method="POST">
                        <input type="hidden" name="action" value="add_favorite">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Add To Favorite List" id="form-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Favorite</button>
                    </form>
                    <form id="commentForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="comment">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Write A Comment" id="form-submit" type="submit"><span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Comment</button>
                    </form>
                    <br>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h3><%=name%>: <%=edition%><hr></h3>
                <h4>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Game</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=game%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Edition</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=edition%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Rarity</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=rarity%></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Colors</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=colors%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Mana Cost</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p>
                                        <%for(String s : icons) {%>
                                        <img class="img-noborder" src="<%=s%>" alt="<%=s%>">
                                        <%}%>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%if(power != null || toughness != null || loyalty != null) {%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <%if(power != null) {%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Power</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=power%></p>
                                </div>
                            </div>
                        </div>
                        <%} if(toughness != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Toughness</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=toughness%></p>
                                </div>
                            </div>
                        </div>
                        <%} if(loyalty != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Loyalty</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=loyalty%></p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <%}%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Type</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=type%></p>
                                </div>
                            </div>
                        </div>
                        <% if(text != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-3">
                                <div class="row">
                                    <p id="title">Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-9">
                                <div class="row">
                                    <p><%=text%></p>
                                </div>
                            </div>
                        </div>
                        <%} if(flavor != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-3">
                                <div class="row">
                                    <p id="title">Flavor Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-9">
                                <div class="row">
                                    <p><%=flavor%></p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Artist</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=artist%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Year</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=year%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                        </div>
                    </div>
                </h4>
            </div>
            <div class="col-xs-12">
                <h3>Comments<hr></h3>
                <%
                    int commentId = 1;
                    int commentCount = 0;
                    String picture;
                    CardCommentInfo comment;
                    while((comment = (CardCommentInfo) cardCommentInfo.getCommentById(commentId)) != null) {
                        if(!comment.getCardId().equals(card.getId())) {
                            commentId++;
                            continue;
                        }
                        java.util.Date dateAdded = comment.getDateAdded();
                        String content = comment.getText();
                        int likes = comment.getLikes();
                        int dislikes = comment.getDislikes();
                        int total = likes + dislikes;
                        UserInfo owner = (UserInfo) userInfo.getUser(comment.getOwner());
                        if(owner == null) {
                            commentId++;
                            continue;
                        }
                        picture = owner.getPicture();
                %>
                <div class="row">
                    <div class="col-xs-12">
                        <h4>
                            <div class="col-xs-7 col-sm-3 col-md-2">
                                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                                <form id="newForm" action="CardServlet" method="POST">
                                    <input type="hidden" name="action" value="edit_comment">
                                    <input type="hidden" name="username" value="<%=username%>">
                                    <button title="Edit Comment" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                                </form>
                                <form id="newForm" action="CardServlet" method="POST">
                                    <input type="hidden" name="action" value="delete_comment">
                                    <input type="hidden" name="username" value="<%=username%>">
                                    <button title="Delete Comment" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
                                </form>
                            </div>
                            <div class="col-xs-5 col-sm-9 col-md-10">
                                <div class="row">
                                    <p><%=owner.getUsername()%></p>
                                    <p><%=dateAdded%></p>
                                    <div class="well hidden-xs" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p>
                                        <hr id="in-line-hr">
                                        <div>
                                            <a class="footer-link" href="#" onclick="document.getElementById('upvoteForm').submit();"><span class="glyphicon glyphicon-thumbs-up"></span>&nbsp;&nbsp;Like</a>&nbsp;&nbsp;<a class="footer-link" href="#" onclick="document.getElementById('downvoteForm').submit();"><span class="glyphicon glyphicon-thumbs-down"></span>&nbsp;&nbsp;Dislike</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                <p>
                                    <%=content%>
                                </p>
                                <hr id="in-line-hr">
                                <div>
                                    <a class="footer-link" href="#" onclick="document.getElementById('upvoteForm').submit();"><span class="glyphicon glyphicon-thumbs-up"></span>&nbsp;&nbsp;Like</a>&nbsp;&nbsp;<a class="footer-link" href="#" onclick="document.getElementById('downvoteForm').submit();"><span class="glyphicon glyphicon-thumbs-down"></span>&nbsp;&nbsp;Dislike</a>
                                </div>
                            </div>
                            <div align="right">
                                <%=likes%> out of <%=total%> people found this review helpful<br>
                                <br><br>
                            </div>
                        </h4>
                    </div>
                </div>
                <form id="upvoteForm" action="CardServlet" method="post">
                    <input type="hidden" name="action" value="upvote">
                    <input type="hidden" name="title" value="<%=card.getId()%>">
                    <input type="hidden" name="id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=likes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="downvoteForm" action="GameServlet" method="post">
                    <input type="hidden" name="action" value="downvote">
                    <input type="hidden" name="title" value="<%=card.getId()%>">
                    <input type="hidden" name="reviewid" value="<%=commentId%>">
                    <input type="hidden" name="dislikes" value="<%=dislikes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                        commentCount++;
                        commentId++;
                    }
                    if(commentCount == 0) {
                        %><h4>There are no comments for this card. Be the first to write one!</h4><%
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
                <%} else {%>
                <h4>Use the following space to write your comment. Please use constructive rhetoric and avoid the use of profanity. We reserve the right to take down comments we find to be inappropriate.<br><br>
                <hr>
                <form id="writeCommentForm" action="CardServlet" method="POST">
                    <input type="hidden" name="action" value="comment">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="username" value="<%=username%>">
                    <textarea id="input-field" name="comment" form="writeCommentForm" style="min-width: 100%;max-width: 100%;min-height: 100px;" required></textarea><br><br>
                    <input id="form-submit" style="width: 50%;" type="submit" value="Submit Comment">
                </form>
                <%}%>
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
            <h2>Card Information</h2><br>
            <h4>
                <p>The card you selected has no information to display.</p>
                <br><br><hr>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>