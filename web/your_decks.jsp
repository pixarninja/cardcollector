<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%
    String username;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
%>
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);;
    String cardImage;
    String sleevesImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back_hd.png";
        sleevesImage = "images/magic_card_sleeves_default.png";
        picture = "images/icons/battered-axe.png";
    }
    else {
        cardImage = user.getPicture();
        sleevesImage = user.getPicture();
        picture = user.getPicture();
    }
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
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                        <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="viewForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="deck">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="View Deck Information" id="form-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                    </form>
                    <form id="editForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Edit Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                    </form>
                    <form id="deleteForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Delete Deck" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
                    </form>
                    <br>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h3>Deck Title<hr></h3>
                <h4 id="capsule-1">
                    <div class="row">
                        <div class="col-xs-6 col-md-3">
                            Card Total
                        </div>
                        <div class="col-xs-6 col-md-9">
                            8
                        </div>
                        <div class="col-xs-12"><br></div>
                        <div class="col-xs-6 col-md-3">
                            Child Of
                        </div>
                        <div class="col-xs-6 col-md-9">
                            Wishlist
                        </div>
                        <div class="col-xs-12"><br></div>
                        <div class="col-xs-6 col-md-3">
                            Date Updated
                        </div>
                        <div class="col-xs-6 col-md-9">
                            1/5/2018
                        </div>
                        <div class="col-xs-12"><br></div>
                        <div class="col-xs-12 col-md-3">
                            Description
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-md-9">
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet quam pretium lacus convallis ultricies eu sed metus. Vestibulum a molestie quam. Praesent in scelerisque tortor. Etiam vulputate orci et erat imperdiet feugiat.</p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-xs-12 col-md-3">
                            Contents
                        </div>
                        <div class="col-xs-12 hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-md-9">
                            <div class="well col-xs-12">
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-1" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-1', 'arrow-right', 'container-1', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-1" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-2" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-2', 'arrow-right', 'container-2', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-2" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-3" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-3', 'arrow-right', 'container-3', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-3" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-4" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-4', 'arrow-right', 'container-4', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-4" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-5" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-5', 'arrow-right', 'container-5', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-5" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-6" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-6', 'arrow-right', 'container-6', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-6" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-7" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-7', 'arrow-right', 'container-7', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-7" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                <div class="col-xs-4 hidden-sm hidden-md hidden-lg"></div>
                                <div id="container-8" class="col-xs-8 col-sm-6">
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-8', 'arrow-right', 'container-8', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-8" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card
                                        </a>&nbsp;x&nbsp;2
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                </h4>
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
                    <form id="cardForm" action="CardServlet" method="POST">
                        <input type="hidden" name="action" value="card">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <img id="imageId" src="images/magic_card_back_hd.png" href="#" style="display: none;"/>
                    <img id="arrow-right" class="img-noborder" src="images/right_arrow.png" href="#" style="display: none;"/>
                    <p align="center" id="detailsId" style="display: none;">
                        <br>Card Name<br><br>
                    </p>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>