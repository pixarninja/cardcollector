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
                int max = 9;
                int count = 1;
            %>
            <h4>
                <div class="row">
                    <%
                        CardInfo card;
                        int printed = 1;
                        int tracker = 1;
                        String id;
                        if(request.getAttribute(Integer.toString(count)) != null) {
                            id = (String) request.getAttribute(Integer.toString(count));
                        }
                        else {
                            id = request.getParameter(Integer.toString(count));
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
                    %>
                        <img class="img-noborder" style="width: 230px; height: 322px; display: inline-block;position: relative;left: <%=-((tracker - 1) % 3) * 3%>px;top: <%=(-(buffer) * 3) + 40%>px;" src="<%=card.getFront()%>" alt="<%=card.getFront()%>">
                        <%
                            tracker++;
                            printed++;
                            count++;
                            if(request.getAttribute(Integer.toString(count)) != null) {
                                id = (String) request.getAttribute(Integer.toString(count));
                            }
                            else {
                                id = request.getParameter(Integer.toString(count));
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