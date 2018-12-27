<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = null;
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    boolean found = false;

    if( cookies != null ) {
       for (int i = 0; i < cookies.length; i++) {
          cookie = cookies[i];
          if(cookie.getName().equals("username")) {
              username = cookie.getValue();
              found = true;
              break;
          }
       }
    }
    if(!found) {
        if((String)request.getAttribute("username") == null) {
            username = request.getParameter("username");
        }
        else {
            username = (String)request.getAttribute("username");
        }
    }
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Card<span class="glyphicon glyphicon-globe" id="large-icon"></span>Collector Terms of Service Agreement</h2>
            <br><br>
            <h3>Terms of Service ("Terms")</h3>
            <hr>
            <h4>
                <p>
                    Last Updated: 02/22/2018
                <p>
                <br>
                <p>
                    Please read these Terms of Service ("Terms", "Terms of Service") carefully before using http://mtg.cardcollector.org (the "Service") operated by Card Collector ("us", "we", or "our").
                </p>
                <p>
                    Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.
                </p>
                <br>
                <p>
                    <em>By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service.</em>
                </p>
            </h4>
            <br>
            <h3>Termination</h3>
            <hr>
            <h4>
                <p>
                    We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.
                </p>
                <p>
                    All provisions of the Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.
                </p>
            </h4>
            <br>
            <h3>Content</h3>
            <hr>
            <h4>
                <p>
                    Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material ("Content"). You are responsible for the Content you put or use on our Service, and similarly we reserve the right to remove Content which is deemed inappropriate or degrading to other individuals in any way. The Content provided by our Service is not owned by us, nor do we take responsibility for any Content put on our Service by you or other users. 
                </p>
                <p>
                    You also agree to not misuse any Content on our Service, including but not limited to the illegal printing of Magic The Gathering cards or proxies.
                </p>
            </h4>
            <br>
            <h3>Links To Other Websites</h3>
            <hr>
            <h4>
                <p>
                    Our Service may contain links to third-party web sites or services that are not owned or controlled by Card Collector.
                </p>
                <p>
                    Card Collector has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party websites or services. You further acknowledge and agree that we shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such content, goods or services available on or through any such websites or services.
                </p>
            </h4>
            <br>
            <h3>Changes</h3>
            <hr>
            <h4>
                <p>
                    We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will try to provide at least 30 days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.
                </p>
            </h4>
            <br>
            <h3>Contact Us</h3>
            <hr>
            <h4>
                <p>
                    If you have any questions about these Terms, please contact us. You can find contact information on the Help Page of http://mtg.cardcollector.org.
                </p>
            </h4>
            <br><br>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>