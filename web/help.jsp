<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
<!-- Add code here -->
<div class="well row">
    <div class="col-xs-12">
        <h2>Site Information</h2><br>
        <h4>
            Welcome to DeckBox!
        </h4><br>
        </h4>
            <div class="row">
                <div class="col-xs-3 col-md-1">
                    <span class="pull-right">Email:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-9 col-md-11">
                    fake@email.com<br><br>
                </div>
            </div>
        </h4>
    </div>
</div>
<%@include file="footer.jsp"%>