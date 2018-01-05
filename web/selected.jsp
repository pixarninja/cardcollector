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
<div class="row">
    <div class="well col-xs-12 col-sm-8">
        <div class="col-xs-12">
            <h2>Selected Items</h2><br>
            <h4>
                <p>Below are your selected items. You may add items to a collection or remove them from your selected items.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="newCollectionForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="add_to_collection">
                    <input type="hidden" name="username" value="<%=username%>">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4">
                            <p>Destination</p>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-8">
                            Choose a destination for the items. If you would like to remove them from your selected items, select "Delete". If you would like to add them to a collection, select "Add To" and choose the collection from the drop-down list.<br><br>
                            <div class="col-xs-12">
                                <input name="source" type="radio" value="delete_selected" checked> Delete
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-6">
                                <input name="source" type="radio" value="add_selected" > Add To
                            </div>
                            <div class="col-xs-6">
                                <select id="input-field">
                                    <option value="wishlist">Wishlist</option>
                                </select><br><br><br>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="hidden-xs col-md-4"></div>
                        <div class="col-xs-12 col-md-8">
                            <input id="form-submit" type="submit" value="Update Selected Items">
                        </div>
                    </div>
                </form>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>