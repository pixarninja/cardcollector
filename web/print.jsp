<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <%
                int count = 1;
                int multiple = 1;
                int tick = 0;
                boolean printBack = false;
            %>
            <h4>
                <div class="row">
                    <%
                        CardInfo card;
                        int printed = 1;
                        int tracker = 1;
                        String id = "";
                        if(request.getAttribute(Integer.toString(count)) != null) {
                            id = (String) request.getAttribute(Integer.toString(count));
                            multiple = (Integer) request.getAttribute(Integer.toString(count) + "total");
                        }
                        while((card = cardInfo.getCardById(id)) != null) {
                            String[] imageURLs = card.getImageURLs();
                            String front = imageURLs[0];
                            String back = imageURLs[1];
                            if(front == null) {
                                front = "images/magic_card_back.jpg";
                            }
                            if(printed == 1) {
                    %>
                    <div>&nbsp;
                        <%
                            }
                            int buffer = 0;
                            if(tracker > 6) {
                                buffer = 2;
                            } else if(tracker > 3) {
                                buffer = 1;
                            }
                            if(printBack && back != null && !back.equals("") && !back.equals("images/magic_card_back.jpg")) {
                                tick++;
                        %>
                        <img class="img-noborder" style="width: 237px; height: 331px; display: inline-block;position: relative;left: <%=-((tracker - 1) % 3) * 3%>px;top: <%=(-(buffer) * 3) + 40%>px;" src="<%=back%>" alt="<%=back%>">
                        <%
                                printBack = false;
                            } else {
                                tick++;
                        %>
                        <img class="img-noborder" style="width: 237px; height: 331px; display: inline-block;position: relative;left: <%=-((tracker - 1) % 3) * 3%>px;top: <%=(-(buffer) * 3) + 40%>px;" src="<%=front%>" alt="<%=front%>">
                        <%
                                printBack = false;
                                if(back != null && !back.equals("") && !back.equals("images/magic_card_back.jpg")) {
                                    printBack = true;
                                    tick--;
                                }
                            }
                            if(!printBack && (tick >= multiple)) {
                                count++;
                                tick = 0;
                            }
                            tracker++;
                            printed++;
                            if(request.getAttribute(Integer.toString(count)) != null) {
                                id = (String) request.getAttribute(Integer.toString(count));
                                multiple = (Integer) request.getAttribute(Integer.toString(count) + "total");
                            }
                            else {
                                id = "";
                            }
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                            if(tracker > 9) {
                                printed = 1;
                                tracker = 1;
                            %>
                            </div>
                        </div>
                        <div class="row">
                            <%
                            }
                            else if(printed > 3) {
                        %>
                            </div>
                    <%
                                printed = 1;
                            }
                        }
                    %>
                </div>
            </h4>
        </div>
    </div>
</div>