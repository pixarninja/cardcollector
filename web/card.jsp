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
    String picture;
    if(user == null) {
        picture = "images/blank-user.jpg";
    }
    else {
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="row">
    <div class="col-xs-2 hidden-sm"></div>
    <div class="col-xs-8 col-sm-12">
        <h2>Card Name: Edition</h2><br>
    </div>
    <div class="col-xs-2 hidden-sm"></div>
</div>
<div class="hidden-xs col-sm-12">
    <div class="row">
        <div class="col-xs-2 hidden-sm hidden-md hidden-lg"></div>
        <div class="col-xs-8 col-sm-4">
            <h4>
                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                <br><br>
                <form id="editForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="edit-profile">
                    <input type="hidden" name="username" value="<%=username%>">
                    <input id="form-submit" type="submit" value="Edit Information">
                </form>
                <br>
            </h4>
        </div>
        <div class="col-sm-1 hidden-lg"></div>
        <div class="col-sm-7 col-lg-8">
            <h3>Card Information<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Game</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Cost:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Type:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Edition:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Rarity:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Power/Toughness:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Abilities:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Text:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Artist/Year:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
            </h4>
        </div>
        <div class="col-sm-1"></div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <h3>Reviews<hr></h3>
            <h4>
                <div class="row">
                    <div class="col-xs-3">
                        <div class="row">
                            <span class="pull-right"><strong>Name:</strong></span>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="row">
                            <%%>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
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
            <form id="editForm" action="UserServlet" method="POST">
                <input type="hidden" name="action" value="edit-profile">
                <input type="hidden" name="username" value="<%=username%>">
                <input id="form-submit" type="submit" value="Edit Information">
            </form>
            <br>
        </h4>
    </div>
    <div class="col-xs-2"></div>
    <div class="col-xs-2"></div>
    <div class="col-xs-12"></div>
    <div class="col-xs-2"></div>
    <div class="col-xs-8">
        <h3>Card Information<hr></h3>
        <h4>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Game</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Cost:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Type:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Edition:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Rarity:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Power/Toughness:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Abilities:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Text:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Artist/Year:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
        </h4>
        <h3>Reviews<hr></h3>
        <h4>
            <div class="row">
                <div class="col-xs-3">
                    <div class="row">
                        <span class="pull-right"><strong>Name:</strong></span>
                    </div>
                </div>
                <div class="col-xs-9">
                    <div class="row">
                        <%%>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
        </h4>
    </div>
    <div class="hidden-xs"></div>
</div>
<%@include file="footer.jsp"%>