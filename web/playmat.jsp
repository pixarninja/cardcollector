<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
<!-- Add code here -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Playmat</h2><br>
            <h4>
                <p>Below is the playmat.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <div id="playmat">Playmat!</div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>