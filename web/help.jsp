<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Site Information</h2><br>
            <h4>
                <p>Welcome to DeckBox!</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <div class="row">
                    <div class="col-xs-3 col-md-1">
                        <p>Email</p>
                    </div>
                    <div class="col-xs-9 col-md-11">
                        fake@email.com<br><br>
                    </div>
                </div>
            </h4>
        </div>
        <div class="col-xs-12">
            
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>