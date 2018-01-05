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
            <h2>Card Information</h2><br>
            <h4>
                <p>Below is card information. You may add this card to your selected items by clicking the "Add To Selection" button. You may remove the card from your selected items by clicking the "Remove From Selection". Cards in your selected items can be placed into collections.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <div class="col-xs-1 hidden-sm hidden-md hidden-lg"></div>
            <div class="col-xs-10 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                        <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                    </div>
                    <div class="col-xs-12"><br><br><br></div>
                    <form id="addToCollectionForm" action="UserServlet" method="POST">
                        <input type="hidden" name="action" value="add_to_selection">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button id="form-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add To Selection</button>
                    </form>
                    <div class="col-xs-12"><br></div>
                    <form id="addToCollectionForm" action="UserServlet" method="POST">
                        <input type="hidden" name="action" value="remove_from_selection">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button id="form-submit" type="submit"><span class="glyphicon glyphicon-remove"></span>&nbsp;&nbsp;Remove From Selection</button>
                    </form>
                    <div class="col-xs-12"><br></div>
                    <br>
                </h4>
                <div class="hidden-xs col-sm-12">
                    <h3>Other Editions<hr></h3>
                </div>
            </div>
            <div class="col-xs-1 hidden-sm hidden-md hidden-lg"></div>
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
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Abilities</p>
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
                            <div class="col-xs-4 col-lg-2">
                                <div class="row">
                                    <p>Text</p>
                                </div>
                            </div>
                            <div class="col-xs-8 col-lg-10">
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
                <h3>Reviews<hr></h3>
                <h4>
                    <div class="row">
                        <div class="col-xs-6 col-sm-4 col-md-2">
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                        </div>
                        <div class="col-xs-6 col-sm-8 col-md-10">
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