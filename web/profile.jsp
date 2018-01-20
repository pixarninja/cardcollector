<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
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
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);
    String cardImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back_hd.png";
        picture = "images/blank_user.jpg";
    }
    else {
        cardImage = "images/magic_card_back_hd.png";
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Profile</h2><br>
            <h4>
                <p>Below is your profile information. You may edit your information by selecting the "Edit" button. You may edit any decks or collections you have recorded by selecting the item's title, which will take you to the item's information page. Below you will also find your favorited items, friends, and a log of your site history.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-4">
            <h4>
                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                <br><br>
                <form id="editForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="edit_profile">
                    <input type="hidden" name="username" value="<%=username%>">
                    <button title="Edit Profile Information" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                </form>
                <br>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-8">
            <h3>Personal Information<hr></h3>
            <h4>
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Username</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getUsername()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Name</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getName()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Email</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getEmail()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                </div>
            </h4>
            <h3>Site Information<hr></h3>
            <h4>
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Collections</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p>Derp</p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Decks</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
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
            <h3>Favorites<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-7 col-sm-3 col-md-2">
                        <img width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img><br>
                        <form id="newForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit_favorite">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Edit Favorite" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                        </form>
                        <form id="newForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="delete_favorite">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Delete Favorite" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
                        </form>
                    </div>
                    <div class="col-xs-5 col-sm-9 col-md-10">
                        <div class="row">
                            <p>Name</p>
                            <p>Date</p>
                            <div class="black_well hidden-xs">
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
            <h3>Friends<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-7 col-sm-3 col-md-2">
                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                        <form id="newForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit_friend">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Edit Friend" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                        </form>
                        <form id="newForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="delete_friend">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Delete Friend" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
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
            <h3>History<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-7 col-sm-3 col-md-2">
                        <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                        <form id="newForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit_history">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Edit History" id="form-submit" type="submit"><span class="glyphicon glyphicon-pencil"></span>&nbsp;&nbsp;Edit</button>
                        </form>
                        <form id="newForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="delete_history">
                            <input type="hidden" name="username" value="<%=username%>">
                            <button title="Delete History" id="form-submit" type="submit"><span class="glyphicon glyphicon-trash"></span>&nbsp;&nbsp;Delete</button>
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
<%@include file="footer.jsp"%>