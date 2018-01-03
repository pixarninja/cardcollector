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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);;
    String picture;
    if(user == null) {
        picture = "images/blank_user.jpg";
    }
    else {
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-2 hidden-sm"></div>
            <div class="col-xs-8 col-sm-12">
                <h2>Your Decks</h2><br>
            </div>
            <div class="col-xs-2 hidden-sm"></div>
        </div>
        <div class="hidden-xs col-sm-12">
            <div class="row">
                <div class="col-xs-2 hidden-sm hidden-md hidden-lg"></div>
                <div class="col-xs-8 col-sm-4">
                    <h4>
                        <div class="deck-image">
                            <img class="sleeves" width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                            <img class="cover" width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                        </div>
                        <br><br><br>
                        <div class="col-xs-12 col-lg-6">
                            <form id="editForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="edit-profile">
                                <input type="hidden" name="username" value="<%=username%>">
                                <input id="form-submit" type="submit" value="Edit Deck">
                            </form>
                        </div>
                        <div class="col-xs-12 hidden-lg"><br></div>
                        <div class="col-xs-12 col-lg-6">
                            <form id="editForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="edit-profile">
                                <input type="hidden" name="username" value="<%=username%>">
                                <input id="form-submit" type="submit" value="Delete Deck">
                            </form>
                        </div>
                        <br>
                    </h4>
                </div>
                <div class="col-sm-1 hidden-lg"></div>
                <div class="col-sm-7 col-lg-8">
                    <h3>Deck Title<hr></h3>
                    <h4>
                        <div id="containerId" class="col-sm-6 col-lg-3">
                            <span onmouseover="reveal('imageId', 'containerId', event)" onmouseout="conceal('imageId')"><a href="#">Derp card x 2</a></span>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            Derp card x 2
                        </div>
                        <div class="col-sm-12 hidden-lg"><br></div>
                        <div class="col-sm-6 col-lg-3">
                            Derp card x 2
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            Derp card x 2
                        </div>
                        <img id="imageId" src="images/blank_user.jpg" href="#" style="display: none;"/>
                        <div class="col-sm-12 hidden-lg"><br></div>
                        <div class="col-sm-12 hidden-lg"><br></div>
                    </h4>
                </div>
                <div class="col-sm-1"></div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <h3>Comments<hr></h3>
                    <h4>
                        <div class="row">
                            <div class="col-xs-3 col-md-2">
                                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                            </div>
                            <div class="col-xs-9 col-md-10">
                                <div class="col-xs-1">
                                    <div class="row">
                                        <span class="pull-right">Name:&nbsp;&nbsp;</span>
                                    </div>
                                </div>
                                <div class="col-xs-11">
                                    <div class="row">
                                        <%%>
                                    </div>
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-1">
                                    <div class="row">
                                        <span class="pull-right">Cost:&nbsp;&nbsp;</span>
                                    </div>
                                </div>
                                <div class="col-xs-11">
                                    <div class="row">
                                        <%%>
                                    </div>
                                </div>
                                <div class="col-xs-12"><br></div>
                            </div>
                        </div>
                    </h4>
                </div>
            </div>
        </div>
        <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
            <div class="col-xs-2 hidden-sm hidden-md hidden-lg"></div>
            <div class="col-xs-8 col-sm-4">
                <h4>
                    <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                    <br><br>
                    <div class="col-xs-12">
                        <form id="editForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit-profile">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="form-submit" type="submit" value="Edit Deck">
                        </form>
                    </div>
                    <div class="col-xs-12">
                        <form id="editForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit-profile">
                            <input type="hidden" name="username" value="<%=username%>">
                            <input id="form-submit" type="submit" value="Delete Deck">
                        </form>
                    </div>
                    <br>
                </h4>
            </div>
            <div class="col-xs-2"></div>
            <div class="col-xs-12">
                <h3>Deck Title<hr></h3>
                <h4>
                    <div class="col-xs-6">
                        Derp card x 2
                    </div>
                    <div class="col-xs-6">
                        Derp card x 2
                    </div>
                    <div class="col-xs-12"><br></div>
                    <div class="col-xs-6">
                        Derp card x 2
                    </div>
                    <div class="col-xs-6">
                        Derp card x 2
                    </div>
                    <div class="col-xs-12"><br></div>
                    <div class="col-xs-12"><br></div>
                </h4>
                <h3>Comments<hr></h3>
                <h4>
                    <div class="row"  style="position: relative;right: 20px;">
                        <div class="col-xs-5">
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img" style="position: relative;right: 25px;"></img>
                        </div>
                        <div class="col-xs-7">
                            <div class="col-xs-1">
                                <div class="row">
                                    <span class="pull-right">Name:&nbsp;&nbsp;</span>
                                </div>
                            </div>
                            <div class="col-xs-11">
                                <div class="row">
                                    <%%>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-1">
                                <div class="row">
                                    <span class="pull-right">Cost:&nbsp;&nbsp;</span>
                                </div>
                            </div>
                            <div class="col-xs-11">
                                <div class="row">
                                    <%%>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                        </div>
                    </div>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>