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
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);;
    String cardImage;
    String backImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back_hd.png";
        backImage = "images/magic_card_back_hd.png";
        picture = "images/icons/battered-axe.png";
    }
    else {
        cardImage = user.getPicture();
        backImage = user.getPicture();
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Card Information</h2><br>
            <h4>
                <p>Below is the selected card's information. You may add this card to your selected items by clicking the "Add" button. Cards in your selected items can be placed into collections. You may write a comment by clicking the "Comment" button.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=backImage%>" alt="<%=backImage%>" id="center-img"></img>
                        <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="addForm" action="SelectionServlet" method="POST">
                        <input type="hidden" name="action" value="add_card_to_selection">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Add To Selection" id="form-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                    </form>
                    <!--<form id="addToCollectionForm" action="SelectionServlet" method="POST">
                        <input type="hidden" name="action" value="remove_from_selection">
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
                <div class="hidden-xs col-sm-12">
                    <h3>Other Editions<hr></h3>
                </div>
            </div>
            <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
                <h3>Other Editions<hr></h3>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h3>Card Name: Edition<hr></h3>
                <h4>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Game</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Edition</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Rarity</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Colors</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Cost</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Type</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-lg-2">
                                <div class="row">
                                    <p>Abilities</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-6 col-sm-4 col-lg-2">
                                <div class="row">
                                    <p>Power</p>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-6 col-sm-4 col-lg-2">
                                <div class="row">
                                    <p>Toughness</p>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-lg-2">
                                <div class="row">
                                    <p>Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-10">
                                <div class="row">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet quam pretium lacus convallis ultricies eu sed metus. Vestibulum a molestie quam. Praesent in scelerisque tortor. Etiam vulputate orci et erat imperdiet feugiat. Praesent bibendum non purus vel consequat. Quisque a venenatis ex. Pellentesque consequat neque dui, eget commodo ipsum fermentum vel. Donec lacinia feugiat elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis quis diam augue. Vivamus accumsan consectetur nibh vel sodales. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed nec tellus eget est rutrum tempus et at dui.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Artist</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Year</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
                                <div class="row">
                                    <p>Derp</p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                        </div>
                    </div>
                </h4>
            </div>
            <div class="col-xs-12">
                <h3>Comments<hr></h3>
                <h4>
                    <div class="row">
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
<%@include file="footer.jsp"%>