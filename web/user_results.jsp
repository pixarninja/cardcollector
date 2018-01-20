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
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);
    String cardImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back_hd.png";
        picture = "images/icons/battered-axe.png";
    }
    else {
        cardImage = user.getPicture();
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Search Results: Users</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a users's information page by clicking the "View" link.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <%
                    int count = 1;
                    if(request.getParameter("start") != null && request.getParameter("start") != "") {
                        count = Integer.parseInt(request.getParameter("start"));
                    }
                    int total = 8;
                    if(request.getParameter("total") != null && request.getParameter("total") != "") {
                        total = Integer.parseInt(request.getParameter("total"));
                    }
                    else if(request.getAttribute("total") != null && request.getAttribute("total") != ""){
                        total = (int)request.getAttribute("total");
                    }
                    int end = 0;
                    if((count + 99) < total) {
                        end = count + 99;
                    }
                    else {
                        end = total;
                    }
                %>
                <h3>Showing: <%=end%> out of <%=total%></h3><hr>
                <%
                    if(count != 1) {
                %>
                <div class="col-xs-6">
                    <form id="requestLessForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="users">
                        <input type="hidden" name="start" value="<%=count - 100%>">
                        <input type="hidden" name="total" value="<%=total%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
                        <input type="hidden" name="publisher" value="<%=request.getParameter("publisher")%>">
                        <input type="hidden" name="studio" value="<%=request.getParameter("studio")%>">
                        <input type="hidden" name="platform" value="<%=request.getParameter("platform")%>">
                        <input type="hidden" name="min-score" value="<%=request.getParameter("min-score")%>">
                        <input type="hidden" name="max-score" value="<%=request.getParameter("max-score")%>">
                        <input id="form-submit" type="submit" value="Previous 100 Users">
                      </form>
                </div>
                <%}%>
                <%
                    if(end < total) {
                %>
                <div class="col-xs-6">
                    <form id="requestMoreForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="users">
                        <input type="hidden" name="start" value="<%=count + 100%>">
                        <input type="hidden" name="total" value="<%=total%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
                        <input type="hidden" name="publisher" value="<%=request.getParameter("publisher")%>">
                        <input type="hidden" name="studio" value="<%=request.getParameter("studio")%>">
                        <input type="hidden" name="platform" value="<%=request.getParameter("platform")%>">
                        <input type="hidden" name="min-score" value="<%=request.getParameter("min-score")%>">
                        <input type="hidden" name="max-score" value="<%=request.getParameter("max-score")%>">
                        <input id="form-submit" type="submit" value="Next 100 Users">
                    </form>
                </div>
                <%}%>
                <h4>
                    <div class="row">
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Username</p>
                            <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                            <form id="userForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="user">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View User Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addFriendForm" action="UserServlet" method="POST">
                                <input type="hidden" name="action" value="add_friend">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Friend List" id="alt-submit" type="submit"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;Friend</button>
                            </form>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                </h4>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
