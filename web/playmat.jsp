<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Card Collector</title>
        <link rel="shortcut icon" href="images/webicon.ico" type="image/x-icon">
        <link rel="icon" href="http://cardcollector-webapp.us-east-1.elasticbeanstalk.com/images/webicon.ico" type="image/x-icon">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Quicksand|Poiret+One" rel="stylesheet">
    </head>
    <body onload="refresh();">
        <div class="container-fluid">
            <div class="col-xs-12">
                <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
                    <!-- icons and text and lines XS -->
                    <form style="position:relative;top: 9px;left: -20px;">
                        <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -15px;left: -24px;" type="submit"><span class="glyphicon glyphicon-globe" style="font-size: 38px;"></span></a>
                    </form>
                </div>
                <!-- icons and text LG -->
                <div class="hidden-xs hidden-sm hidden-md col-lg-12">
                    <form style="position:relative;top: 9px;left: -20px;">
                        <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -15px;left: -24px;" type="submit">Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector</a>
                    </form>
                </div>
                <!-- only icons SM -->
                <div class="hidden-xs col-sm-12 hidden-md hidden-lg">
                    <form style="position:relative;top: 9px;left: -20px;">
                        <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -15px;left: -24px;" type="submit">Card<span class="glyphicon glyphicon-globe" id="medium-icon"></span>Collector</a>
                    </form>
                </div>
                <!-- only icons MD -->
                <div class="hidden-xs hidden-sm col-md-12 hidden-lg">
                    <form style="position:relative;top: 9px;left: -20px;">
                        <a href="#" title="Card Collector Home" class="navbar-brand" style="position: relative; top: -15px;left: -24px;" type="submit">Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector</a>
                    </form>
                </div>
            </div>
        </div>
        <div class="row" align="left">
            <!-- Ad Bar -->
            <div class="hidden-xs col-sm-1" style="background:url(images/wallart.jpg);height: 100%;position: fixed;left: 0px;background-position: center-x;"></div>
            <div class="hidden-xs col-sm-1" style="background:url(images/wallart.jpg);height: 100%;position: fixed;right: 0px;background-position: center-x;"></div>
            <div class="hidden-xs col-sm-1"></div>
            <div id="content" class="col-xs-12 col-sm-10" style="background-color: black;background-repeat: repeat;min-height: 100%;">
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
                <p id="footer">
                    <a id="menu-item" class="footer-link" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="mini-icon"></span>Collector</a>
                </p>
            </div>
        </div>
    </body>
</html>