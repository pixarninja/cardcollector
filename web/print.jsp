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
                            if(printBack && card.getBack() != null && !card.getBack().equals("")) {
                                tick++;
                        %>
                        <img class="img-noborder" style="width: 237px; height: 331px; display: inline-block;position: relative;left: <%=-((tracker - 1) % 3) * 3%>px;top: <%=(-(buffer) * 3) + 40%>px;" src="<%=card.getBack()%>" alt="<%=card.getBack()%>">
                        <%
                                printBack = false;
                            } else {
                                tick++;
                        %>
                        <img class="img-noborder" style="width: 237px; height: 331px; display: inline-block;position: relative;left: <%=-((tracker - 1) % 3) * 3%>px;top: <%=(-(buffer) * 3) + 40%>px;" src="<%=card.getFront()%>" alt="<%=card.getFront()%>">
                        <%
                                printBack = false;
                                if(card.getBack() != null && !card.getBack().equals("")) {
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