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
    <div class="well col-xs-12">
        <div class="col-xs-12">
            <h2>Selected Items</h2><br>
            <h4>
                <p>Below are your selected items. You may add items to a collection or remove them from your selected items.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4 id="capsule-1">
                <div class="row">
                    <form id="newCollectionForm" action="UserServlet" method="POST">
                        <input type="hidden" name="action" value="add_to_collection">
                        <input type="hidden" name="username" value="<%=username%>">
                        <div class="col-xs-12">
                            <div class="col-xs-2">
                                <p>Cards</p>
                            </div>
                            <div class="col-xs-10">
                                <div id="container-1" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-1', 'arrow-right', 'container-1', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-1" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                <div id="container-2" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-2', 'arrow-right', 'container-2', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-2" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12 hidden-lg"><br><br></div>
                                <div id="container-3" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-3', 'arrow-right', 'container-3', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-3" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br><br></div>
                                <div id="container-4" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-4', 'arrow-right', 'container-4', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-4" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12"><br><br></div>
                                <div id="container-5" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-5', 'arrow-right', 'container-5', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-5" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br><br></div>
                                <div id="container-6" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-6', 'arrow-right', 'container-6', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-6" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12 hidden-lg"><br><br></div>
                                <div id="container-7" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-7', 'arrow-right', 'container-7', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-7" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br><br></div>
                                <div id="container-8" class="col-xs-12 col-sm-6 col-lg-3">
                                    <input type="checkbox" name="selected" value="card_id">&nbsp;
                                    <span onmouseover="reveal('imageId', 'detailsId', 'text-8', 'arrow-right', 'container-8', 'capsule-1')" onmouseout="conceal('imageId', 'detailsId', 'arrow-right')">
                                        <a id="text-8" href="#" onclick="document.getElementById('cardForm').submit();">
                                            Derp card x 2
                                        </a>
                                    </span>
                                    <br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quantity:&nbsp;&nbsp;<input id="input-field" type="number" name="quantity_card_id" style="width: 40px;font-size: 16px;" placeholder="0">
                                </div>
                                <div class="col-xs-12"><br><br></div>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <hr>
                            <div class="col-xs-12 col-sm-2">
                                <p>Destination</p>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-10">
                                Choose a destination for the items. If you would like to remove them from your selected items, select "Delete". If you would like to add them to a collection, select "Add To" and choose the collection from the drop-down list.<br><br>
                                <div class="col-xs-6">
                                    <span style="float: right;">
                                        <input name="source" type="radio" value="delete_selected" checked> Delete
                                    </span>
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-6">
                                    <span style="float: right;">
                                        <input name="source" type="radio" value="add_selected" >Add To
                                    </span>
                                </div>
                                <div class="col-xs-6">
                                    <select id="input-field">
                                        <option value="wishlist">Wishlist</option>
                                    </select><br><br><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <div class="hidden-xs col-sm-7"></div>
                            <div class="col-xs-12 col-sm-5">
                                <input id="form-submit" type="submit" value="Update Selected Items">
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </form>
                </div>
                <form id="cardForm" action="CardServlet" method="POST">
                    <input type="hidden" name="action" value="card">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <img id="imageId" src="images/magic_card_back_hd.png" href="#" style="display: none;"/>
                <img id="arrow-right" class="img-noborder" src="" href="#" style="display: none;"/>
                <p align="center" id="detailsId" style="display: none;">
                    <br>Card Name<br><br>
                </p>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>