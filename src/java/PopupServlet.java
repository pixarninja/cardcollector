/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import secure.EmailUtility;

/**
 *
 * @author Wesley
 */
@WebServlet(urlPatterns = {"/PopupServlet"})
public class PopupServlet extends HttpServlet {
    private String host;
    private String port;
    private String user;
    private String pass;
 
    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
        catch(Exception ex) {
            ;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String username;
        if((String)request.getAttribute("username") == null) {
            username = request.getParameter("username");
        }
        else {
            username = (String)request.getAttribute("username");
        }
        if(username == null || username.equals("null")) {
            username = "";
        }
        String url = "/";
        if(action.equals("winloss")) {
            int won = 0;
            if(request.getParameter("times_won1") != null) {
                won = Integer.parseInt((String) request.getParameter("times_won1"));
            }
            else if(request.getParameter("times_won2") != null) {
                won = Integer.parseInt((String) request.getParameter("times_won2"));
            }
            int matches = 0;
            if(request.getParameter("times_played1") != null) {
                matches = Integer.parseInt((String) request.getParameter("times_played1"));
            }
            else if(request.getParameter("times_played2") != null) {
                matches = Integer.parseInt((String) request.getParameter("times_played2"));
            }
            int prev_won = 0;
            if(request.getParameter("times_prev_won1") != null) {
                prev_won = Integer.parseInt((String) request.getParameter("times_prev_won1"));
            }
            else if(request.getParameter("times_prev_won2") != null) {
                prev_won = Integer.parseInt((String) request.getParameter("times_prev_won2"));
            }
            int prev_matches = 0;
            if(request.getParameter("time_prev_played1") != null) {
                prev_matches = Integer.parseInt((String) request.getParameter("time_prev_played1"));
            }
            else if(request.getParameter("time_prev_played2") != null) {
                prev_matches = Integer.parseInt((String) request.getParameter("time_prev_played2"));
            }
            String verifier = "";
            if(request.getParameter("verifier1") != null && !request.getParameter("verifier1").equals("")) {
                verifier = (String) request.getParameter("verifier1");
            }
            else if(request.getParameter("verifier2") != null && !request.getParameter("verifier2").equals("")) {
                verifier = (String) request.getParameter("verifier2");
            }
            int id = Integer.parseInt((String) request.getParameter("id"));
            String owner = (String) request.getParameter("owner");
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();
                ResultSet rs;
                String query;
                PreparedStatement ps;
                
                /* add winloss */
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table19 + "`");
                /* find the next possible id */
                int winlossId = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > winlossId) {
                        break;
                    }
                    winlossId++;
                }
                rs.close();

                java.util.Date date = new Date();
                Object dateAdded = new java.sql.Timestamp(date.getTime());

                query = "INSERT INTO `" + secure.DBStructure.table19 + "` (`id`, `verifier_id`, `owner_id`, `date_added`, `won`, `matches`, `prev_won`, `prev_matches`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                ps = connection.prepareStatement(query);
                ps.setInt(1, winlossId);
                ps.setString(2, verifier);
                ps.setInt(3, id);
                ps.setObject(4, dateAdded);
                ps.setInt(5, won);
                ps.setInt(6, matches);
                ps.setInt(7, prev_won);
                ps.setInt(8, prev_matches);
                ps.execute();
                ps.close();
                
                /* add notification */
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "`");
                /* find the next possible id */
                int count = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > count) {
                        break;
                    }
                    count++;
                }
                rs.close();

                date = new Date();
                dateAdded = new java.sql.Timestamp(date.getTime());

                query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                ps = connection.prepareStatement(query);
                ps.setInt(1, count);
                ps.setInt(2, 6); // 6 for win/loss update
                ps.setInt(3, winlossId);
                ps.setString(4, owner);
                ps.setString(5, username);
                ps.setObject(6, dateAdded);
                ps.setInt(7, 0);
                ps.execute();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("challenge_deck")) {
            int won = 0;
            if(request.getParameter("times_won1") != null) {
                won = Integer.parseInt((String) request.getParameter("times_won1"));
            }
            else if(request.getParameter("times_won2") != null) {
                won = Integer.parseInt((String) request.getParameter("times_won2"));
            }
            int matches = 0;
            if(request.getParameter("times_played1") != null) {
                matches = Integer.parseInt((String) request.getParameter("times_played1"));
            }
            else if(request.getParameter("times_played2") != null) {
                matches = Integer.parseInt((String) request.getParameter("times_played2"));
            }
            int prev_won = 0;
            if(request.getParameter("times_prev_won") != null) {
                prev_won = Integer.parseInt((String) request.getParameter("times_prev_won"));
            }
            int prev_matches = 0;
            if(request.getParameter("time_prev_played") != null) {
                prev_matches = Integer.parseInt((String) request.getParameter("time_prev_played"));
            }
            int deckId = 0;
            if(request.getParameter("deck1") != null && !request.getParameter("deck1").equals("")) {
                deckId = Integer.parseInt((String) request.getParameter("deck1"));
            }
            else if(request.getParameter("deck2") != null && !request.getParameter("deck2").equals("")) {
                deckId = Integer.parseInt((String) request.getParameter("deck2"));
            }
            int id = Integer.parseInt((String) request.getParameter("id"));
            String owner = (String) request.getParameter("owner");
            String text = (String) request.getParameter("text");
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();
                ResultSet rs;
                String query;
                PreparedStatement ps;
                
                /* add match */
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table18 + "`");
                /* find the next possible id */
                int matchId = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > matchId) {
                        break;
                    }
                    matchId++;
                }
                rs.close();

                java.util.Date date = new Date();
                Object dateAdded = new java.sql.Timestamp(date.getTime());

                query = "INSERT INTO `" + secure.DBStructure.table18 + "` (`id`, `challenger_id`, `owner_id`, `text`, `date_added`, `won`, `matches`, `prev_won`, `prev_matches`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";
                ps = connection.prepareStatement(query);
                ps.setInt(1, matchId);
                ps.setInt(2, deckId);
                ps.setInt(3, id);
                ps.setString(4, text);
                ps.setObject(5, dateAdded);
                ps.setInt(6, won);
                ps.setInt(7, matches);
                ps.setInt(8, prev_won);
                ps.setInt(9, prev_matches);
                ps.execute();
                ps.close();
                
                /* add notification */
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "`");
                /* find the next possible id */
                int count = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > count) {
                        break;
                    }
                    count++;
                }
                rs.close();

                date = new Date();
                dateAdded = new java.sql.Timestamp(date.getTime());

                query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                ps = connection.prepareStatement(query);
                ps.setInt(1, count);
                ps.setInt(2, 5); // 5 for challenge request
                ps.setInt(3, matchId);
                ps.setString(4, owner);
                ps.setString(5, username);
                ps.setObject(6, dateAdded);
                ps.setInt(7, 0);
                ps.execute();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("add_card")) {
            String collectionTotal = null;
            if(request.getParameter("collection_total1") != null && !request.getParameter("collection_total1").equals("0")) {
                collectionTotal = request.getParameter("collection_total1");
            }
            else if(request.getParameter("collection_total2") != null && !request.getParameter("collection_total2").equals("0")) {
                collectionTotal = request.getParameter("collection_total2");
            }
            String deckTotal = null;
            if(request.getParameter("deck_total1") != null && !request.getParameter("deck_total1").equals("0")) {
                deckTotal = request.getParameter("deck_total1");
            }
            else if(request.getParameter("deck_total2") != null && !request.getParameter("deck_total2").equals("0")) {
                deckTotal = request.getParameter("deck_total2");
            }
            int collectionId = 0;
            if(request.getParameter("collection1") != null && !request.getParameter("collection1").equals("") && collectionTotal != null && !collectionTotal.equals("")) {
                collectionId = Integer.parseInt((String) request.getParameter("collection1"));
            }
            else if(request.getParameter("collection2") != null && !request.getParameter("collection2").equals("") && collectionTotal != null && !collectionTotal.equals("")) {
                collectionId = Integer.parseInt((String) request.getParameter("collection2"));
            }
            int deckId = 0;
            if(request.getParameter("deck1") != null && !request.getParameter("deck1").equals("") && deckTotal != null && !deckTotal.equals("")) {
                deckId = Integer.parseInt((String) request.getParameter("deck1"));
            }
            else if(request.getParameter("deck2") != null && !request.getParameter("deck2").equals("") && deckTotal != null && !deckTotal.equals("")) {
                deckId = Integer.parseInt((String) request.getParameter("deck2"));
            }
            String id = request.getParameter("id");
            int count;
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                Statement statement = connection.createStatement();
                ResultSet rs;
                String query;
                
                if(id != null && !id.equals("")) {
                    if(collectionId != 0 && Integer.parseInt(collectionTotal) > 0) {

                        query = "SELECT * FROM `" + secure.DBStructure.table5 + "` WHERE id = ?";
                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setInt(1, collectionId);
                        rs = ps.executeQuery();
                        if(rs.next()) {
                            int entries = rs.getInt("entries");
                            int prevTotal = rs.getInt("total");
                            rs.close();
                            ps.close();

                            rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table8 + "` ORDER BY id ASC");

                            count = 1;
                            while(rs.next()) {
                                if(rs.getInt("id") > count) {
                                    break;
                                }
                                count++;
                            }
                            rs.close();

                            query = "SELECT * FROM `" + secure.DBStructure.table8 + "` WHERE collection_id = ? AND card_id = ?";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, collectionId);
                            ps.setString(2, id);
                            rs = ps.executeQuery();
                            if(!rs.next()) {
                                rs.close();
                                ps.close();

                                java.util.Date date = new Date();
                                Object dateUpdated = new java.sql.Timestamp(date.getTime());
                                
                                query = "UPDATE `" + secure.DBStructure.table5 + "` SET entries = ?, total = ?, date_updated = ? WHERE id = ?";
                                ps = connection.prepareStatement(query);
                                ps.setInt(1, entries + 1);
                                ps.setInt(2, Integer.parseInt(collectionTotal) + prevTotal);
                                ps.setObject(3, dateUpdated);
                                ps.setInt(4, collectionId);

                                ps.executeUpdate();
                                ps.close();

                                query = "INSERT INTO `" + secure.DBStructure.table8 + "` (`id`, `collection_id`, `card_id`, `card_total`) VALUES (?, ?, ?, ?)";

                                ps = connection.prepareStatement(query);

                                ps.setInt(1, count);
                                ps.setInt(2, collectionId);
                                ps.setString(3, id);
                                ps.setInt(4, Integer.parseInt(collectionTotal));

                                ps.execute();
                                ps.close();
                                
                                request.setAttribute("collection_id", Integer.toString(collectionId));
                                request.setAttribute("collection_total", collectionTotal);
                            }
                            else {
                                int oldTotal = rs.getInt("card_total");
                                rs.close();
                                ps.close();
                                
                                java.util.Date date = new Date();
                                Object dateUpdated = new java.sql.Timestamp(date.getTime());
                                
                                query = "UPDATE `" + secure.DBStructure.table5 + "` SET total = ?, date_updated = ? WHERE id = ?";
                                ps = connection.prepareStatement(query);
                                ps.setInt(1, Integer.parseInt(collectionTotal) + prevTotal);
                                ps.setObject(2, dateUpdated);
                                ps.setInt(3, collectionId);

                                ps.executeUpdate();
                                ps.close();

                                query = "UPDATE `" + secure.DBStructure.table8 + "` SET card_total = ? WHERE collection_id = ? AND card_id = ?";

                                ps = connection.prepareStatement(query);

                                ps.setInt(1, oldTotal + Integer.parseInt(collectionTotal));
                                ps.setInt(2, collectionId);
                                ps.setString(3, id);

                                ps.execute();
                                ps.close();
                                
                                request.setAttribute("collection_id", Integer.toString(collectionId));
                                request.setAttribute("collection_total", collectionTotal);
                            }
                            
                        }
                        else {
                            rs.close();
                            ps.close();
                        }

                    }
                    if(deckId != 0 && Integer.parseInt(deckTotal) > 0) {

                        query = "SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = ?";
                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setInt(1, deckId);
                        rs = ps.executeQuery();
                        if(rs.next()) {
                            int entries = rs.getInt("entries");
                            int prevTotal = rs.getInt("total");
                            rs.close();
                            ps.close();

                            rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` ORDER BY id ASC");
                            count = 1;
                            while(rs.next()) {
                                if(rs.getInt("id") > count) {
                                    break;
                                }
                                count++;
                            }
                            rs.close();

                            query = "SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ? AND card_id = ?";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, deckId);
                            ps.setString(2, id);
                            rs = ps.executeQuery();
                            if(!rs.next()) {
                                rs.close();
                                ps.close();

                                java.util.Date date = new Date();
                                Object dateUpdated = new java.sql.Timestamp(date.getTime());

                                query = "UPDATE `" + secure.DBStructure.table10 + "` SET entries = ?, total = ?, date_updated = ? WHERE id = ?";
                                ps = connection.prepareStatement(query);
                                ps.setInt(1, entries + 1);
                                ps.setInt(2, Integer.parseInt(deckTotal) + prevTotal);
                                ps.setObject(3, dateUpdated);
                                ps.setInt(4, deckId);

                                ps.executeUpdate();
                                ps.close();

                                query = "INSERT INTO `" + secure.DBStructure.table13 + "` (`id`, `deck_id`, `card_id`, `card_total`) VALUES (?, ?, ?, ?);";
                                ps = connection.prepareStatement(query);

                                ps.setInt(1, count);
                                ps.setInt(2, deckId);
                                ps.setString(3, id);
                                ps.setInt(4, Integer.parseInt(deckTotal));

                                ps.execute();
                                ps.close();
                                
                                request.setAttribute("deck_id", Integer.toString(deckId));
                                request.setAttribute("deck_total", deckTotal);
                            }
                            else {
                                int oldTotal = rs.getInt("card_total");
                                rs.close();
                                ps.close();
                                
                                java.util.Date date = new Date();
                                Object dateUpdated = new java.sql.Timestamp(date.getTime());

                                query = "UPDATE `" + secure.DBStructure.table10 + "` SET total = ?, date_updated = ? WHERE id = ?";
                                ps = connection.prepareStatement(query);
                                ps.setInt(1, Integer.parseInt(deckTotal) + prevTotal);
                                ps.setObject(2, dateUpdated);
                                ps.setInt(3, deckId);

                                ps.executeUpdate();
                                ps.close();

                                query = "UPDATE `" + secure.DBStructure.table13 + "` SET card_total = ? WHERE deck_id = ? AND card_id = ?";
                                ps = connection.prepareStatement(query);

                                ps.setInt(1, oldTotal + Integer.parseInt(deckTotal));
                                ps.setInt(2, deckId);
                                ps.setString(3, id);

                                ps.execute();
                                ps.close();
                                
                                request.setAttribute("deck_id", Integer.toString(deckId));
                                request.setAttribute("deck_total", deckTotal);
                            }
                        }
                        else {
                            rs.close();
                            ps.close();
                        }

                    }
                    
                    /* Date */
                    java.util.Date date = new Date();
                    Object dateViewed = new java.sql.Timestamp(date.getTime());
                    query = "UPDATE `" + secure.DBStructure.table1 + "` SET viewed = ? WHERE id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setObject(1, dateViewed);
                    ps.setString(2, id);
                    ps.executeUpdate();
                    ps.close();

                    connection.close();
                    url = "card.jsp";
                }
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("edit_card_comment")) {
            String comment = request.getParameter("comment");
            if(comment.length() > 2048) {
                comment = comment.substring(0, 2048);
            }
            int id = Integer.parseInt(request.getParameter("comment_id"));
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                java.util.Date date = new Date();
                Object dateUpdated = new java.sql.Timestamp(date.getTime());

                String query = "UPDATE `" + secure.DBStructure.table2 + "` SET text = ?, date_added = ? WHERE id = ?";

                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, comment);
                ps.setObject(2, dateUpdated);
                ps.setInt(3, id);

                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/card.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_card_comment")) {
            int commentId = Integer.parseInt(request.getParameter("comment_id"));
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "DELETE FROM `" + secure.DBStructure.table2 + "` WHERE id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, commentId);
                ps.executeUpdate();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table3 + "` WHERE comment_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, commentId);
                ps.executeUpdate();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, 0);
                ps.setInt(2, commentId);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/card.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("edit_deck_comment")) {
            String comment = request.getParameter("comment");
            if(comment.length() > 2048) {
                comment = comment.substring(0, 2048);
            }
            int id = Integer.parseInt(request.getParameter("comment_id"));
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                java.util.Date date = new Date();
                Object dateUpdated = new java.sql.Timestamp(date.getTime());

                String query = "UPDATE `" + secure.DBStructure.table11 + "` SET text = ?, date_added = ? WHERE id = ?";

                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, comment);
                ps.setObject(2, dateUpdated);
                ps.setInt(3, id);

                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_deck_comment")) {
            int commentId = Integer.parseInt(request.getParameter("comment_id"));
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "DELETE FROM `" + secure.DBStructure.table11 + "` WHERE id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, commentId);
                ps.executeUpdate();
                ps.close();
                
                query = "SELECT * FROM `" + secure.DBStructure.table11 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, commentId);
                ResultSet rs2 = ps.executeQuery();
                while(rs2.next()) {
                    query = "SELECT * FROM `" + secure.DBStructure.table12 + "` WHERE comment_id = ?";
                    PreparedStatement ps2 = connection.prepareStatement(query);
                    ps2.setInt(1, rs2.getInt("id"));
                    ResultSet tmp = ps.executeQuery();
                    if(tmp.next()) {
                        int reaction = tmp.getInt("reaction");
                        if(reaction == 1) {
                            int likes = rs2.getInt("likes");
                            query = "UPDATE `" + secure.DBStructure.table11 + "` SET likes = ? WHERE id = ?";
                            PreparedStatement p = connection.prepareStatement(query);
                            p.setInt(1, likes - 1);
                            p.setInt(2, rs2.getInt("id"));
                            p.executeUpdate();
                            p.close();
                        }
                        else {
                            int dislikes = rs2.getInt("dislikes");
                            query = "UPDATE `" + secure.DBStructure.table11 + "` SET dislikes = ? WHERE id = ?";
                            PreparedStatement p = connection.prepareStatement(query);
                            p.setInt(1, dislikes - 1);
                            p.setInt(2, rs2.getInt("comment_id"));
                            p.executeUpdate();
                            p.close();
                        }
                    }
                    tmp.close();
                    ps2.close();
                    
                    query = "DELETE FROM `" + secure.DBStructure.table12 + "` WHERE comment_id = ?";
                    PreparedStatement p = connection.prepareStatement(query);
                    p.setInt(1, rs2.getInt("id"));
                    p.executeUpdate();
                    p.close();
                }
                rs2.close();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, 1);
                ps.setInt(2, commentId);
                ps.executeUpdate();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, 2);
                ps.setInt(2, commentId);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_deck")) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                PreparedStatement ps;
                String query;

                query = "DELETE FROM `" + secure.DBStructure.table10 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();

                query = "DELETE FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                
                query = "SELECT * FROM `" + secure.DBStructure.table11 + "` WHERE deck_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    query = "DELETE FROM `" + secure.DBStructure.table12 + "` WHERE comment_id = ?";
                    PreparedStatement p = connection.prepareStatement(query);
                    p.setInt(1, rs.getInt("id"));
                    p.executeUpdate();
                    p.close();
                    
                    query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, 1);
                    ps.setInt(2, rs.getInt("id"));
                    ps.executeUpdate();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, 2);
                    ps.setInt(2, rs.getInt("id"));
                    ps.executeUpdate();
                    ps.close();
                }
                rs.close();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table11 + "` WHERE deck_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table14 + "` WHERE deck_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                
                rs.close();

                url = "/your_decks.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("edit_collection_comment")) {
            String comment = request.getParameter("comment");
            if(comment.length() > 2048) {
                comment = comment.substring(0, 2048);
            }
            int id = Integer.parseInt(request.getParameter("comment_id"));
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                java.util.Date date = new Date();
                Object dateUpdated = new java.sql.Timestamp(date.getTime());

                String query = "UPDATE `" + secure.DBStructure.table6 + "` SET text = ?, date_added = ? WHERE id = ?";

                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, comment);
                ps.setObject(2, dateUpdated);
                ps.setInt(3, id);

                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/collection.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_collection_comment")) {
            int commentId = Integer.parseInt(request.getParameter("comment_id"));
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "DELETE FROM `" + secure.DBStructure.table6 + "` WHERE id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, commentId);
                ps.executeUpdate();
                ps.close();
                
                query = "SELECT * FROM `" + secure.DBStructure.table6 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, commentId);
                ResultSet rs4 = ps.executeQuery();
                while(rs4.next()) {
                    query = "SELECT * FROM `" + secure.DBStructure.table7 + "` WHERE comment_id = ?";
                    PreparedStatement ps2 = connection.prepareStatement(query);
                    ps2.setInt(1, rs4.getInt("id"));
                    ResultSet tmp = ps.executeQuery();
                    if(tmp.next()) {
                        int reaction = tmp.getInt("reaction");
                        if(reaction == 1) {
                            int likes = rs4.getInt("likes");
                            query = "UPDATE `" + secure.DBStructure.table6 + "` SET likes = ? WHERE id = ?";
                            PreparedStatement p = connection.prepareStatement(query);
                            p.setInt(1, likes - 1);
                            p.setInt(2, rs4.getInt("id"));
                            p.executeUpdate();
                            p.close();
                        }
                        else {
                            int dislikes = rs4.getInt("dislikes");
                            query = "UPDATE `" + secure.DBStructure.table6 + "` SET dislikes = ? WHERE id = ?";
                            PreparedStatement p = connection.prepareStatement(query);
                            p.setInt(1, dislikes - 1);
                            p.setInt(2, rs4.getInt("comment_id"));
                            p.executeUpdate();
                            p.close();
                        }
                    }
                    tmp.close();
                    ps2.close();
                    
                    query = "DELETE FROM `" + secure.DBStructure.table7 + "` WHERE comment_id = ?";
                    PreparedStatement p = connection.prepareStatement(query);
                    p.setInt(1, rs4.getInt("id"));
                    p.executeUpdate();
                    p.close();
                }
                rs4.close();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, 3);
                ps.setInt(2, commentId);
                ps.executeUpdate();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, 4);
                ps.setInt(2, commentId);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/collection.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_collection")) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                PreparedStatement ps;
                String query;

                query = "DELETE FROM `" + secure.DBStructure.table5 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();

                query = "DELETE FROM `" + secure.DBStructure.table8 + "` WHERE collection_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                
                query = "SELECT * FROM `" + secure.DBStructure.table6 + "` WHERE collection_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    query = "DELETE FROM `" + secure.DBStructure.table7 + "` WHERE comment_id = ?";
                    PreparedStatement p = connection.prepareStatement(query);
                    p.setInt(1, rs.getInt("id"));
                    p.executeUpdate();
                    p.close();
                    
                    query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, 3);
                    ps.setInt(2, rs.getInt("id"));
                    ps.executeUpdate();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE type = ? AND type_id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, 4);
                    ps.setInt(2, rs.getInt("id"));
                    ps.executeUpdate();
                    ps.close();
                }
                rs.close();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table6 + "` WHERE collection_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                
                query = "DELETE FROM `" + secure.DBStructure.table9 + "` WHERE collection_id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                
                rs.close();

                url = "/your_collections.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_user")) {
            String id = request.getParameter("id");
            String password = request.getParameter("password");
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                PreparedStatement ps;
                String query;
                ResultSet rs;
                boolean validated = false;
                
                query = "SELECT * FROM `" + secure.DBStructure.table16 + "` WHERE username = ?;";
                ps = connection.prepareStatement(query);
                ps.setString(1, id);
                rs = ps.executeQuery();
                if(rs.next()) {
                    String confirm = secure.DBConnection.generateHash(secure.DBConnection.SALT + password);
                    if(rs.getString("password").equals(confirm)) {
                        validated = true;
                    }
                }
                
                if(validated) {
                    /* delete card information */
                    query = "DELETE FROM `" + secure.DBStructure.table2 + "` WHERE owner = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table3 + "` WHERE username = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table4 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    /* delete notification information */
                    query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE owner = ? OR user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.setString(2, id);
                    ps.executeUpdate();
                    ps.close();

                    /* delete deck information */
                    query = "SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ResultSet rs1 = ps.executeQuery();
                    while(rs1.next()) {
                        query = "DELETE FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ?";
                        PreparedStatement p = connection.prepareStatement(query);
                        p.setInt(1, rs1.getInt("id"));
                        p.executeUpdate();
                        p.close();
                    }
                    rs1.close();

                    query = "DELETE FROM `" + secure.DBStructure.table10 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    query = "SELECT * FROM `" + secure.DBStructure.table11 + "` WHERE owner = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ResultSet rs2 = ps.executeQuery();
                    while(rs2.next()) {
                        query = "SELECT * FROM `" + secure.DBStructure.table12 + "` WHERE comment_id = ?";
                        PreparedStatement ps2 = connection.prepareStatement(query);
                        ps2.setInt(1, rs2.getInt("id"));
                        ResultSet tmp = ps2.executeQuery();
                        if(tmp.next()) {
                            int reaction = tmp.getInt("reaction");
                            if(reaction == 1) {
                                int likes = rs2.getInt("likes");
                                query = "UPDATE `" + secure.DBStructure.table11 + "` SET likes = ? WHERE id = ?";
                                PreparedStatement p = connection.prepareStatement(query);
                                p.setInt(1, likes - 1);
                                p.setInt(2, rs2.getInt("id"));
                                p.executeUpdate();
                                p.close();
                            }
                            else {
                                int dislikes = rs2.getInt("dislikes");
                                query = "UPDATE `" + secure.DBStructure.table11 + "` SET dislikes = ? WHERE id = ?";
                                PreparedStatement p = connection.prepareStatement(query);
                                p.setInt(1, dislikes - 1);
                                p.setInt(2, rs2.getInt("id"));
                                p.executeUpdate();
                                p.close();
                            }
                        }
                        tmp.close();
                        ps2.close();

                        query = "DELETE FROM `" + secure.DBStructure.table12 + "` WHERE comment_id = ?";
                        PreparedStatement p = connection.prepareStatement(query);
                        p.setInt(1, rs2.getInt("id"));
                        p.executeUpdate();
                        p.close();
                    }
                    rs2.close();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table11 + "` WHERE owner = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table14 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    /* delete collection information */
                    query = "SELECT * FROM `" + secure.DBStructure.table5 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ResultSet rs3 = ps.executeQuery();
                    while(rs3.next()) {
                        query = "DELETE FROM `" + secure.DBStructure.table8 + "` WHERE collection_id = ?";
                        PreparedStatement p = connection.prepareStatement(query);
                        p.setInt(1, rs3.getInt("id"));
                        p.executeUpdate();
                        p.close();
                    }
                    rs3.close();

                    query = "DELETE FROM `" + secure.DBStructure.table5 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    query = "SELECT * FROM `" + secure.DBStructure.table6 + "` WHERE owner = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ResultSet rs4 = ps.executeQuery();
                    while(rs4.next()) {
                        query = "SELECT * FROM `" + secure.DBStructure.table7 + "` WHERE comment_id = ?";
                        PreparedStatement ps2 = connection.prepareStatement(query);
                        ps2.setInt(1, rs4.getInt("id"));
                        ResultSet tmp = ps2.executeQuery();
                        if(tmp.next()) {
                            int reaction = tmp.getInt("reaction");
                            if(reaction == 1) {
                                int likes = rs4.getInt("likes");
                                query = "UPDATE `" + secure.DBStructure.table6 + "` SET likes = ? WHERE id = ?";
                                PreparedStatement p = connection.prepareStatement(query);
                                p.setInt(1, likes - 1);
                                p.setInt(2, rs4.getInt("id"));
                                p.executeUpdate();
                                p.close();
                            }
                            else {
                                int dislikes = rs4.getInt("dislikes");
                                query = "UPDATE `" + secure.DBStructure.table6 + "` SET dislikes = ? WHERE id = ?";
                                PreparedStatement p = connection.prepareStatement(query);
                                p.setInt(1, dislikes - 1);
                                p.setInt(2, rs4.getInt("id"));
                                p.executeUpdate();
                                p.close();
                            }
                        }
                        tmp.close();
                        ps2.close();

                        query = "DELETE FROM `" + secure.DBStructure.table7 + "` WHERE comment_id = ?";
                        PreparedStatement p = connection.prepareStatement(query);
                        p.setInt(1, rs4.getInt("id"));
                        p.executeUpdate();
                        p.close();
                    }
                    rs4.close();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table6 + "` WHERE owner = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    query = "DELETE FROM `" + secure.DBStructure.table9 + "` WHERE user = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, id);
                    ps.executeUpdate();
                    ps.close();

                    /* delete user information */
                    query = "DELETE FROM `" + secure.DBStructure.table16 + "` WHERE username = '" + id + "'";
                    ps = connection.prepareStatement(query);
                    ps.executeUpdate();
                    ps.close();
                    
                    request.setAttribute("username", "");
                }
                else {
                    request.setAttribute("username", "error: username not validated");
                }
                
                Cookie[] cookies = request.getCookies();
                if(cookies != null) {            
                    for (Cookie cookie : cookies) {
                        if(cookie.getName().equals("username")) {
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                        }
                    }
                }
            
                url = "/login.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("forgot")) {
            String email = request.getParameter("email");
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                String query;
                PreparedStatement ps;
                
                query = "SELECT * FROM `" + secure.DBStructure.table16 + "` WHERE username = ? AND email= ?";
                ps = connection.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, email);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                    StringBuilder salt = new StringBuilder();
                    Random random = new Random();
                    while (salt.length() < 24) { // length of the random string.
                        int index = (int) (random.nextFloat() * SALTCHARS.length());
                        salt.append(SALTCHARS.charAt(index));
                    }
                    String randomPassword = salt.toString();
                    String convertedPassword = secure.DBConnection.SALT + randomPassword;
                    convertedPassword = secure.DBConnection.generateHash(convertedPassword);
                    
                    String subject = "CardCollector: Password Reset Request";
                    String content = "Greetings from CardCollector!\n\n"
                            + "Please do not reply to this email, it was sent from an unattended mailbox. This email was automatically generated by http://mtg.cardcollector.org in order to reset your password. Your new credentials are produced below:\n\n"
                            + "Username: " + username + "\n"
                            + "Password: " + randomPassword + "\n\n"
                            + "You will need to use these credentials the next time you log in to the website.\n\n"
                            + "Happy Collecting!\n\n"
                            + "Sincerely,\n"
                            + "Wes Harris, creator of Card Collector\n"
                            + "http://mtg.cardcollector.org\n"
                            + "http://markwesleyharris.com";
                    
                    query = "UPDATE `" + secure.DBStructure.table16 + "` SET password = ? WHERE username = ?";
                    ps = connection.prepareStatement(query);
                    ps.setString(1, convertedPassword);
                    ps.setString(2, username);
                    ps.execute();
                    ps.close();

                    try {
                        EmailUtility.sendEmail(host, port, this.user, this.pass, email, subject, content);
                        request.setAttribute("username", "password successfully reset");
                        url = "/login.jsp";
                    } catch (Exception ex) {
                        request.setAttribute("username", "");
                        url = "/index.jsp";
                        request.setAttribute("error", ex);
                        Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                else {
                    request.setAttribute("username", "error: username email mismatch");
                    url = "/login.jsp";
                }
                rs.close();
                ps.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(PopupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            url = "/help.jsp";
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        dispatcher.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
