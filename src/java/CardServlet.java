/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Wesley
 */
@WebServlet(urlPatterns = {"/CardServlet"})
public class CardServlet extends HttpServlet {

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
        if(action.equals("card")) {
            String id = request.getParameter("id");
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                /* Date */
                java.util.Date date = new Date();
                Object dateViewed = new java.sql.Timestamp(date.getTime());
                String query = "UPDATE `" + secure.DBStructure.table1 + "` SET viewed = ? WHERE id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setObject(1, dateViewed);
                ps.setString(2, id);
                ps.executeUpdate();
                ps.close();
                
                url = "/card.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("upvote")) {
            int id = Integer.parseInt(request.getParameter("comment_id"));
            int likes = Integer.parseInt(request.getParameter("likes"));
            int dislikes = Integer.parseInt(request.getParameter("dislikes"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();

                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table3 + "`");
                
                boolean error = false;
                boolean first = true;
                while(rs.next()) {
                    if((rs.getInt("comment_id") == id) && (rs.getString("username").equals(username))) {
                        first = false;
                        if(rs.getInt("reaction") == 1) {
                            error = true;
                        }
                        break;
                    }
                }
                rs.close();
                
                if(!error) {
                    String query;
                    PreparedStatement ps;
                    
                    if(first) {
                        query = "UPDATE `" + secure.DBStructure.table2 + "` SET likes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, likes + 1);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    
                        statement = connection.createStatement();
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table3 + "` ORDER BY id ASC");

                        int num = 1;
                        while(rs.next()) {
                            if(rs.getInt("id") > num) {
                                break;
                            }
                            num++;
                        }
                        rs.close();
                        
                        query = "INSERT INTO `" + secure.DBStructure.table3 + "` (`id`, `comment_id`, `username`, `reaction`) VALUES (?, ?, ?, ?);";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, num);
                        ps.setInt(2, id);
                        ps.setString(3, username);
                        ps.setInt(4, 1);
                        ps.execute();
                        ps.close();
                    }
                    else {
                        query = "UPDATE `" + secure.DBStructure.table2 + "` SET likes = ?, dislikes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, likes + 1);
                        ps.setInt(2, dislikes - 1);
                        ps.setInt(3, id);
                        ps.execute();
                        ps.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table3 + "` SET reaction = ? WHERE comment_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, 1);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    }
                    
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` WHERE type=0 AND type_id=" + id);
                    if(!rs.next()) {
                        rs.close();
                        
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
                        
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table2 + "` WHERE id=" + id);
                        if(rs.next()) {
                        
                            String owner = rs.getString("owner");
                            java.util.Date date = new Date();
                            Object dateAdded = new java.sql.Timestamp(date.getTime());

                            query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, count);
                            ps.setInt(2, 0); // 0 for card comment reaction
                            ps.setInt(3, id);
                            ps.setString(4, owner);
                            ps.setString(5, username);
                            ps.setObject(6, dateAdded);
                            ps.setInt(7, 0); // 0 for like
                            ps.execute();
                            ps.close();
                        }
                        rs.close();
                    }
                    else {
                        rs.close();
                    }
                }

                connection.close();
                url = "/card.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("downvote")) {
            int id = Integer.parseInt(request.getParameter("comment_id"));
            int likes = Integer.parseInt(request.getParameter("likes"));
            int dislikes = Integer.parseInt(request.getParameter("dislikes"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();

                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table3 + "`");
                
                boolean error = false;
                boolean first = true;
                while(rs.next()) {
                    if((rs.getInt("comment_id") == id) && (rs.getString("username").equals(username))) {
                        first = false;
                        if(rs.getInt("reaction") == 0) {
                            error = true;
                        }
                        break;
                    }
                }
                rs.close();
                
                if(!error) {
                    String query;
                    PreparedStatement ps;
                    
                    if(first) {
                        query = "UPDATE `" + secure.DBStructure.table2 + "` SET dislikes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, dislikes + 1);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    
                        statement = connection.createStatement();
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table3 + "` ORDER BY id ASC");

                        int num = 1;
                        while(rs.next()) {
                            if(rs.getInt("id") > num) {
                                break;
                            }
                            num++;
                        }
                        rs.close();
                        
                        query = "INSERT INTO `" + secure.DBStructure.table3 + "` (`id`, `comment_id`, `username`, `reaction`) VALUES (?, ?, ?, ?);";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, num);
                        ps.setInt(2, id);
                        ps.setString(3, username);
                        ps.setInt(4, 0);
                        ps.execute();
                        ps.close();
                    }
                    else {
                        query = "UPDATE `" + secure.DBStructure.table2 + "` SET likes = ?, dislikes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, likes - 1);
                        ps.setInt(2, dislikes + 1);
                        ps.setInt(3, id);
                        ps.execute();
                        ps.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table3 + "` SET reaction = ? WHERE comment_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, 0);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    }
                    
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` WHERE type=0 AND type_id=" + id);
                    if(!rs.next()) {
                        rs.close();
                        
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
                        
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table3 + "` WHERE comment_id=" + id);
                        if(rs.next()) {
                        
                            String owner = rs.getString("username");
                            java.util.Date date = new Date();
                            Object dateAdded = new java.sql.Timestamp(date.getTime());

                            query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, count);
                            ps.setInt(2, 0); // 0 for card comment reaction
                            ps.setInt(3, id);
                            ps.setString(4, owner);
                            ps.setString(5, username);
                            ps.setObject(6, dateAdded);
                            ps.setInt(7, 1); // 1 for dislike
                            ps.execute();
                            ps.close();
                        }
                        rs.close();
                    }
                    else {
                        rs.close();
                    }
                }

                connection.close();
                url = "/card.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("comment")) {
            String comment = request.getParameter("comment");
            if(comment.length() > 2048) {
                comment = comment.substring(0, 2048);
            }
            String cardId = request.getParameter("id");
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table2 + "` ORDER BY id ASC");
                
                int id = 1;
                boolean error = false;
                while(rs.next()) {
                    String text = rs.getString("text");
                    String owner = rs.getString("owner");
                    if(text.equals(comment) && owner.equals(username)) {
                        error = true;
                        break;
                    }
                    if(rs.getInt("id") > id) {
                        break;
                    }
                    id++;
                }
                if(!error) {
                    String query;
                    PreparedStatement ps;
                    
                    /*
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` WHERE type=0 AND type_id=" + id);
                    if(!rs.next()) {
                        rs.close();
                        
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "`");
                        /* find the next possible id
                        int count = 1;
                        while(rs.next()) {
                            if(rs.getInt("id") > count) {
                                break;
                            }
                            count++;
                        }
                        rs.close();
                        Calendar calendar = Calendar.getInstance();
                        java.sql.Date dateAdded = new java.sql.Date(calendar.getTime().getTime());
                        
                        query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?);";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, count);
                        ps.setInt(2, 0); // ... for card comment
                        ps.setInt(3, id);
                        ps.setString(4, username);
                        ps.setObject(5, dateAdded);
                        ps.setInt(6, 0); // 0 for unread
                        ps.execute();
                        ps.close();
                    }
                    else {
                        rs.close();
                    }
                    */
                    
                    java.util.Date date = new Date();
                    Object dateAdded = new java.sql.Timestamp(date.getTime());

                    query = "INSERT INTO `" + secure.DBStructure.table2 + "` (`id`, `card_id`, `owner`, `text`, `likes`, `dislikes`, `date_added`) VALUES (?, ?, ?, ?, ?, ?, ?);";

                    ps = connection.prepareStatement(query);
                    ps.setInt(1, id);
                    ps.setString(2, cardId);
                    ps.setString(3, username);
                    ps.setString(4, comment);
                    ps.setInt(5, 0);
                    ps.setInt(6, 0);
                    ps.setObject(7, dateAdded);

                    ps.execute();
                    ps.close();
                }
                rs.close();
                connection.close();
                url = "/card.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("favorite")) {
            String id = request.getParameter("id");
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table4 + "` WHERE user='" + username + "'");
                
                boolean error = false;
                while(rs.next()) {
                    if(rs.getString("card_id").equals(id)) {
                        error = true;
                    }
                }
                rs.close();
                
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table4 + "` ORDER BY id ASC");
                
                /* find the next possible id */
                int count = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > count) {
                        break;
                    }
                    count++;
                }
                rs.close();
                
                if(!error) {
                    String query = "INSERT INTO `" + secure.DBStructure.table4 + "` (`id`, `card_id`, `user`) VALUES (?, ?, ?);";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setInt(1, count);
                    ps.setString(2, id);
                    ps.setString(3, username);

                    ps.execute();
                    ps.close();
                }
                else {
                    String query = "DELETE FROM `" + secure.DBStructure.table4 + "` WHERE card_id='" + id + "' AND user='" + username + "'";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.executeUpdate();
                    ps.close();
                }
                
                /* Date */
                java.util.Date date = new Date();
                Object dateViewed = new java.sql.Timestamp(date.getTime());
                String query = "UPDATE `" + secure.DBStructure.table1 + "` SET viewed = ? WHERE id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setObject(1, dateViewed);
                ps.setString(2, id);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/profile.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("index")) {
            url = "index.jsp";
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
