                        <p id="footer"><a href="#" class="footer-link" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="mini-icon"></span>Collector</a>
                            &nbsp;&nbsp;|&nbsp;
                            <a title="Your Collections" href="#" class="footer-link" onclick="document.getElementById('yourCollectionsForm').submit();">
                                <span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Collections
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <a title="Your Decks" href="#" class="footer-link" onclick="document.getElementById('yourDecksForm').submit();">
                                <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Decks
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <a title="Your Profile" href="#" class="footer-link" onclick="document.getElementById('profileForm').submit();">
                                <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Profile
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <!--
                            <a title="Playmat" href="#" class="footer-link" onclick="document.getElementById('playmatForm').submit();">
                                <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            -->
                            <a title="Help" href="#" class="footer-link" onclick="document.getElementById('helpForm').submit();">
                                <span class="glyphicon glyphicon-info-sign"></span>&nbsp;&nbsp;Help
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <a title="Advanced Search" href="#" class="footer-link" onclick="document.getElementById('searchForm').submit();">
                                <span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Search
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <%if(username == null || username.equals("")) {%>
                            <a title="Selected Items" href="#" class="footer-link" onclick="document.getElementById('selectedForm').submit();">
                                <span class="glyphicon glyphicon-piggy-bank"></span>&nbsp;&nbsp;(0)
                            </a>
                            <%} else {%>
                            <a title="Selected Items" href="#" class="footer-link" onclick="document.getElementById('selectedForm').submit();">
                                <span class="glyphicon glyphicon-piggy-bank"></span>&nbsp;&nbsp;(8)
                            </a>
                            <%}%>
                            &nbsp;&nbsp;|&nbsp;
                            <%if(username == null || username.equals("")) {%>
                            <a title="Login" href="#" class="footer-link" onclick="document.getElementById('loginForm').submit();">
                                <span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login
                            </a>
                            <%} else {%>
                            <a title="Logout" href="#" class="footer-link" onclick="document.getElementById('logoutForm').submit();">
                                <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;Logout
                            </a>
                            <%}%>
                            <span style="float: right;">Copyright 2018</span><p>
                    </div>
                    <!-- Ad Bar -->
                    <div class="col-xs-1" style="background-image:url(images/planeswalkers.jpg);height: 100%;overflow: hidden;margin-bottom: -9999px;padding-bottom: 9999px;background-repeat: repeat-y;background-position: center center;background-size: 100%;background-attachment: fixed;"></div>
                </div>
            </div>
        </div>
    </body>
</html>