<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
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
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Search Results: Cards</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a card's information page by clicking the "View" link. You may add the card to your selection by clicking the "Add" link.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <%
                    int max = 24;
                    int count = 1;
                    if(request.getParameter("start") != null && !request.getParameter("start").equals("")) {
                        count = Integer.parseInt(request.getParameter("start"));
                    }
                    int total = 0;
                    if(request.getAttribute("total") != null){
                        total = (Integer)request.getAttribute("total");
                    }
                    int end = 0;
                    if((count + max - 1) < total) {
                        end = count + max - 1;
                    }
                    else {
                        end = total;
                    }
                    if(end < max) {
                        %><h3>Showing: 1 through <%=end%> out of <%=total%></h3><hr><%
                    }
                    else {
                        %><h3>Showing: <%=end - max + 1%> through <%=end%> out of <%=total%></h3><hr><%
                    }
                    if(count != 1) {
                %>
                <div class="col-xs-6">
                    <div class="col-xs-12"><br></div>
                    <form id="requestLessForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="cards">
                        <input type="hidden" name="start" value="<%=count - max%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Previous <%=max%> Cards" id="form-submit" type="submit"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
                    </form>
                    <div class="col-xs-12"><br></div>
                </div>
                <%}%>
                <%
                    if(end < total) {
                %>
                <div class="col-xs-6">
                    <div class="col-xs-12"><br></div>
                    <form id="requestMoreForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="cards">
                        <input type="hidden" name="start" value="<%=count + max%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <button title="Next <%=max%> Cards" id="form-submit" type="submit">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
                    </form>
                    <div class="col-xs-12"><br></div>
                </div>
                <%}%>
                <div class="col-xs-12"><br></div>
                <h4>
                    <div class="row">
                        <%
                            CardInfo card;
                            int printed = 1;
                            int tracker = 1;
                            String id = (String) request.getAttribute(Integer.toString(count));
                            while((card = cardInfo.getCardById(id)) != null) {
                        %>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <img class="img-special" width="100%" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" id="center-img"></img><br>
                            <a href="#" onclick="document.getElementById('cardForm<%=id%>').submit();">
                                <%=card.getName()%>
                            </a>
                            <form id="cardForm<%=id%>" action="CardServlet" method="POST">
                                <input type="hidden" name="action" value="card">
                                <input type="hidden" name="id" value="<%=id%>">
                                <input type="hidden" name="username" value="<%=username%>">
                            </form>
                        </div>
                        <%
                            String spacer = "";
                            if((printed % 2) == 0) {
                                spacer += "col-xs-12";
                            }
                            else {
                                spacer += "hidden-xs";
                            }
                            if((printed % 4) == 0) {
                                spacer += " col-sm-12";
                            }
                            else {
                                spacer += " hidden-sm";
                            }
                            if((printed % 6) == 0) {
                                spacer += " col-md-12";
                            }
                            else {
                                spacer += " hidden-md hidden-lg";
                            }
                        %>
                        <div class="<%=spacer%>"><hr></div>
                        <%
                                if(tracker >= max) {
                                    break;
                                }
                                tracker++;
                                printed++;
                                count++;
                                id = (String) request.getAttribute(Integer.toString(count));
                                try {
                                    Thread.sleep(750);
                                } catch(InterruptedException ex) {
                                    System.out.println("ERROR: sleep was interrupted!");
                                }
                            }
                        %>
                    </div>
                </h4>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
