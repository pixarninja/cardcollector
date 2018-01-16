<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
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
<!-- Content -->
<div class="row">
    <div class="well col-xs-12">
        <div class="col-xs-12">
            <div class="col-xs-12">
                <h2>Create New Deck</h2><br>
                <h4>
                    <p>If you would like to create a new deck, fill out the fields below and click the "Create Deck" button. You must give a title to the deck and specify if the deck is dependent upon items of a collection (i.e. the deck can only be made with items of the a specific collection).</p>
                    <br><br><hr>
                </h4>
            </div>
            <div class="col-xs-12">
                <h4>
                    <form id="newDeckForm" action="DeckServlet" method="POST">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="username" value="<%=username%>">
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p id="title">Deck Title</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Please enter the title for this deck.<br><br>
                                <input id="input-field" name="name" type="text" required>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <p id="title">Deck Description</p>
                            </div>
                            <div class="col-xs-7 col-sm-8">
                                You may enter a description for this deck.<br><br>
                                <textarea id="input-field" name="description"></textarea>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4">
                                <p id="title">Deck Source</p>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8">
                                Choose a source for the deck. If the deck does not depend on a collection, select "Independent". If the deck must contain items from a specific collection, select "Child Of" and choose the name of the parent collection from the drop-down list.<br><br>
                                <div class="col-xs-12">
                                    <input name="source" type="radio" value="independent" checked> Independent
                                </div>
                                <div class="col-xs-12"><br></div>
                                <div class="col-xs-6">
                                    <input name="source" type="radio" value="parent" > Child Of
                                </div>
                                <div class="col-xs-6">
                                    <select name="parent" id="input-field">
                                        <%
                                        CollectionInfo collection;
                                        int num = 1;
                                        while((collection = collectionInfo.getCollectionByNum(num)) != null) {
                                        %>
                                        <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
                                        <%
                                                num++;
                                            }
                                        %>
                                    </select><br><br><br>
                                </div>
                                <input id="form-submit" type="submit" value="Create Deck"><br><br><br>
                            </div>
                        </div>
                    </form>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>