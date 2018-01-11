<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="selectionInfo" class="beans.SelectionInfo" scope="request"/>
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
    int selectionEntries = 0;
    int selectionId = 1;
    SelectionInfo selection;
    while((selection = (SelectionInfo) selectionInfo.getSelectionById(selectionId)) != null) {
        String user = selection.getUser();
        if(user.equals(username)) {
            selectionEntries++;
        }
        selectionId++;
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
            <div class="col-xs-12">
                <h2>Create New Collection</h2><br>
                <h4>
                    <p>If you would like to create a new collection, fill out the fields below and click the "Create Collection" button. You must give a title to the collection and specify if the collection is a child of another (a child collection can only hold items that are also in its parent).</p>
                    <br><br><hr>
                </h4>
            </div>
            <div class="col-xs-12">
                <h4>
                    <form id="newCollectionForm" action="CollectionServlet" method="POST">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="username" value="<%=username%>">
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p>Collection Title</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Please enter the title of the collection.<br><br>
                                <input id="input-field" name="name" type="text" required>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p>Collection Description</p>
                            </div>
                            <div class="col-xs-7 col-sm-8">
                                You may enter a description for this collection.<br><br>
                                <textarea id="input-field" name="description" style="width: 100%;min-height: 60px;"></textarea>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4">
                                <p>Collection Source</p>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8">
                                Choose a source for the collection. If the collection does not depend on another collection, select "Independent". If the collection must contain items from another collection, select "Child Of" and choose the name of the parent collection from the drop-down list.<br><br>
                                <div class="col-xs-12">
                                    <input name="source" type="radio" value="independent" checked> Independent
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-6">
                                    <input name="source" type="radio" value="parent" > Child Of
                                </div>
                                <div class="col-xs-6">
                                    <select name="parent" id="input-field">
                                        <option value="wishlist">Wishlist</option>
                                    </select><br><br><br>
                                </div>
                                <input id="form-submit" type="submit" value="Create Collection"><br><br><br>
                            </div>
                        </div>
                    </form>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>