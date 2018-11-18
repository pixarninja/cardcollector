import beans.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/DeckServlet"})
@MultipartConfig
public class DeckServlet extends HttpServlet {

    public DeckServlet() {
        super();
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
        if(action.equals("new")) {
            if(username.equals("")) {
                request.setAttribute("username", "error: propted redirect");
                url = "/login.jsp";
            }
            else {
                url = "/new_deck.jsp";
            }
        } else if(action.equals("accept_match")) {
            int owner_id = Integer.parseInt(request.getParameter("id"));
            int challenger_id = Integer.parseInt(request.getParameter("challenger_id"));
            int notification_id = Integer.parseInt(request.getParameter("notification_id"));
            int match_id = Integer.parseInt(request.getParameter("match_id"));
            int won = Integer.parseInt(request.getParameter("won"));
            int matches = Integer.parseInt(request.getParameter("matches"));
            int prev_won = Integer.parseInt(request.getParameter("prev_won"));
            int prev_matches = Integer.parseInt(request.getParameter("prev_matches"));
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
                
                int wins;
                int losses;
                
                /* update owner deck */
                statement = connection.createStatement();
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + owner_id + "'");
                rs.next();
                wins = rs.getInt("wins");
                losses = rs.getInt("losses");
                rs.close();
                
                if(prev_won == wins && prev_matches == wins + losses) {
                    query = "UPDATE `" + secure.DBStructure.table10 + "` SET wins = ?, losses = ? WHERE id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, wins + matches - won);
                    ps.setInt(2, losses + won);
                    ps.setInt(3, owner_id);
                    ps.executeUpdate();
                    ps.close();

                    /* update challenger deck */
                    statement = connection.createStatement();
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + challenger_id + "'");
                    rs.next();
                    wins = rs.getInt("wins");
                    losses = rs.getInt("losses");
                    rs.close();

                    query = "UPDATE `" + secure.DBStructure.table10 + "` SET wins = ?, losses = ? WHERE id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, wins + won);
                    ps.setInt(2, losses + matches - won);
                    ps.setInt(3, challenger_id);
                    ps.executeUpdate();
                    ps.close();    
                }
                
                /* delete notification */
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, notification_id);
                ps.executeUpdate();
                ps.close();
                
                /* delete match */
                query = "DELETE FROM `" + secure.DBStructure.table18 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, match_id);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("reject_match")) {
            int notification_id = Integer.parseInt(request.getParameter("notification_id"));
            int match_id = Integer.parseInt(request.getParameter("match_id"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                String query;
                PreparedStatement ps;
                
                /* delete notification */
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, notification_id);
                ps.executeUpdate();
                ps.close();
                
                /* delete match */
                query = "DELETE FROM `" + secure.DBStructure.table18 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, match_id);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("verify_winloss")) {
            int owner_id = Integer.parseInt(request.getParameter("id"));
            int notification_id = Integer.parseInt(request.getParameter("notification_id"));
            int winloss_id = Integer.parseInt(request.getParameter("winloss_id"));
            int won = Integer.parseInt(request.getParameter("won"));
            int matches = Integer.parseInt(request.getParameter("matches"));
            int prev_won = Integer.parseInt(request.getParameter("prev_won"));
            int prev_matches = Integer.parseInt(request.getParameter("prev_matches"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                String query;
                PreparedStatement ps;
                
                int wins;
                int losses;
                
                /* update owner deck */
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + owner_id + "'");
                rs.next();
                wins = rs.getInt("wins");
                losses = rs.getInt("losses");
                rs.close();
                
                if(prev_won == wins && prev_matches == wins + losses) {
                    /* update owner deck */
                    query = "UPDATE `" + secure.DBStructure.table10 + "` SET wins = ?, losses = ? WHERE id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, won);
                    ps.setInt(2, matches - won);
                    ps.setInt(3, owner_id);
                    ps.executeUpdate();
                    ps.close();
                }
                
                /* delete notification */
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, notification_id);
                ps.executeUpdate();
                ps.close();
                
                /* delete winloss */
                query = "DELETE FROM `" + secure.DBStructure.table19 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, winloss_id);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("reject_winloss")) {
            int notification_id = Integer.parseInt(request.getParameter("notification_id"));
            int winloss_id = Integer.parseInt(request.getParameter("winloss_id"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                String query;
                PreparedStatement ps;
                
                /* delete notification */
                query = "DELETE FROM `" + secure.DBStructure.table15 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, notification_id);
                ps.executeUpdate();
                ps.close();
                
                /* delete winloss */
                query = "DELETE FROM `" + secure.DBStructure.table19 + "` WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, winloss_id);
                ps.executeUpdate();
                ps.close();
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
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

                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table12 + "`");
                
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
                        query = "UPDATE `" + secure.DBStructure.table11 + "` SET likes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, likes + 1);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    
                        statement = connection.createStatement();
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table12 + "` ORDER BY id ASC");

                        /* find the next possible id */
                        int num = 1;
                        while(rs.next()) {
                            if(rs.getInt("id") > num) {
                                break;
                            }
                            num++;
                        }
                        rs.close();
                        
                        query = "INSERT INTO `" + secure.DBStructure.table12 + "` (`id`, `comment_id`, `username`, `reaction`) VALUES (?, ?, ?, ?);";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, num);
                        ps.setInt(2, id);
                        ps.setString(3, username);
                        ps.setInt(4, 1);
                        ps.execute();
                        ps.close();
                    }
                    else {
                        query = "UPDATE `" + secure.DBStructure.table11 + "` SET likes = ?, dislikes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, likes + 1);
                        ps.setInt(2, dislikes - 1);
                        ps.setInt(3, id);
                        ps.execute();
                        ps.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table12 + "` SET reaction = ? WHERE comment_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, 1);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    }
                    
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` WHERE type=2 AND type_id=" + id);
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

                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table11 + "` WHERE id=" + id);
                        if(rs.next()) {

                            String owner = rs.getString("owner");
                            java.util.Date date = new Date();
                            Object dateAdded = new java.sql.Timestamp(date.getTime());

                            query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, count);
                            ps.setInt(2, 2); // 2 for deck comment reaction
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
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
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

                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table12 + "`");
                
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
                        query = "UPDATE `" + secure.DBStructure.table11 + "` SET dislikes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, dislikes + 1);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    
                        statement = connection.createStatement();
                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table12 + "` ORDER BY id ASC");

                        /* find the next possible id */
                        int count = 1;
                        while(rs.next()) {
                            if(rs.getInt("id") > count) {
                                break;
                            }
                            count++;
                        }
                        rs.close();
                        
                        query = "INSERT INTO `" + secure.DBStructure.table12 + "` (`id`, `comment_id`, `username`, `reaction`) VALUES (?, ?, ?, ?);";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, count);
                        ps.setInt(2, id);
                        ps.setString(3, username);
                        ps.setInt(4, 0);
                        ps.execute();
                        ps.close();
                    }
                    else {
                        query = "UPDATE `" + secure.DBStructure.table11 + "` SET likes = ?, dislikes = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, likes - 1);
                        ps.setInt(2, dislikes + 1);
                        ps.setInt(3, id);
                        ps.execute();
                        ps.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table12 + "` SET reaction = ? WHERE comment_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, 0);
                        ps.setInt(2, id);
                        ps.execute();
                        ps.close();
                    }
                    
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` WHERE type=2 AND type_id=" + id);
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

                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table11 + "` WHERE id=" + id);
                        if(rs.next()) {

                            String owner = rs.getString("owner");
                            java.util.Date date = new Date();
                            Object dateAdded = new java.sql.Timestamp(date.getTime());

                            query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, count);
                            ps.setInt(2, 2); // 2 for deck comment reaction
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
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("comment")) {
            String comment = request.getParameter("comment");
            if(comment.length() > 2048) {
                comment = comment.substring(0, 2048);
            }
            String deckId = request.getParameter("id");
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table11 + "` ORDER BY id ASC");
                
                boolean error = false;
                while(rs.next()) {
                    String text = rs.getString("text");
                    String owner = rs.getString("owner");
                    if(text.equals(comment) && owner.equals(username)) {
                        error = true;
                        break;
                    }
                }
                rs.close();
                
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table11 + "` ORDER BY id ASC");
                
                /* find the next possible id */
                int id = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > id) {
                        break;
                    }
                    id++;
                }
                rs.close();
                
                if(!error) {
                    java.util.Date date = new Date();
                    Object dateAdded = new java.sql.Timestamp(date.getTime());

                    String query = "INSERT INTO `" + secure.DBStructure.table11 + "` (`id`, `deck_id`, `owner`, `text`, `likes`, `dislikes`, `date_added`) VALUES (?, ?, ?, ?, ?, ?, ?);";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setInt(1, id);
                    ps.setString(2, deckId);
                    ps.setString(3, username);
                    ps.setString(4, comment);
                    ps.setInt(5, 0);
                    ps.setInt(6, 0);
                    ps.setObject(7, dateAdded);

                    ps.execute();
                    ps.close();
                    
                    rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` WHERE type=1 AND type_id=" + id);
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

                        rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id=" + deckId);
                        if(rs.next()) {

                            String owner = rs.getString("user");
                            date = new Date();
                            dateAdded = new java.sql.Timestamp(date.getTime());

                            query = "INSERT INTO `" + secure.DBStructure.table15 + "` (`id`, `type`, `type_id`, `owner`, `user`, `date_added`, status) VALUES (?, ?, ?, ?, ?, ?, ?);";
                            ps = connection.prepareStatement(query);
                            ps.setInt(1, count);
                            ps.setInt(2, 1); // 1 for deck comment
                            ps.setInt(3, id);
                            ps.setString(4, owner);
                            ps.setString(5, username);
                            ps.setObject(6, dateAdded);
                            ps.setInt(7, 0); // 0 for unread
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
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("submit_edit")) {
            int id = Integer.parseInt((String)request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String cover = request.getParameter("cover");
            String sleeves = request.getParameter("sleeves");
            String delete = request.getParameter("delete");
            String copyCollection = request.getParameter("copy_collection");
            String copyDeck = request.getParameter("copy_deck");
            ArrayList<String> selected = new ArrayList<String>();
            int num = 1;
            boolean error = false;
            int won = 0;
            if(request.getParameter("times_won") != null) {
                won = Integer.parseInt((String) request.getParameter("times_won"));
            }
            int matches = 0;
            if(request.getParameter("times_played") != null) {
                matches = Integer.parseInt((String) request.getParameter("times_played"));
            }
            String verifier = "";
            if(request.getParameter("verifier") != null) {
                verifier = (String) request.getParameter("verifier");
            }
            
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                Statement statement;
                
                if(request.getParameter(Integer.toString(0)) != null && request.getParameter(Integer.toString(0)).equals("select_all")) {
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");
                    
                    while(rs.next()) {
                        String cardId = rs.getString("card_id");
                        if(cardId == null || cardId.equals("")) {
                            continue;
                        }
                        selected.add(rs.getString("card_id"));
                        num++;
                    }
                }
                else {
                    while(true) {
                        String cardId = request.getParameter(Integer.toString(num));
                        if(cardId == null || cardId.equals("")) {
                            num++;
                            continue;
                        }
                        else if(cardId.equals("ENDTOKEN")) {
                            break;
                        }
                        selected.add(request.getParameter(Integer.toString(num)));
                        num++;
                    }
                }
                
                /* Name */
                if(name != null && !name.equals("")) {
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE user='" + username + "';");
                    while (rs.next()) {
                        if(rs.getString("name").equals(name) && rs.getInt("id") != id) {
                            error = true;
                            break;
                        }
                    }
                    rs.close();
                    
                    if(!error) {
                        
                        String query = "UPDATE `" + secure.DBStructure.table10 + "` SET name = ? WHERE id = ?";
                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setString(1, name);
                        ps.setInt(2, id);
                        ps.executeUpdate();
                        ps.close();
                        
                    }
                    else {
                        request.setAttribute("error", "error: name");
                    }
                }
                
                /* Description */
                if(description != null && !description.equals("") && !error) {

                    String query = "UPDATE `" + secure.DBStructure.table10 + "` SET description = ? WHERE id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, description);
                    ps.setInt(2, id);
                    ps.executeUpdate();
                    ps.close();
                    
                }
                
                /* Winloss */
                if(verifier != null && !verifier.equals("") && !error) {
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + id + "'");
                    rs.next();
                    int wins = rs.getInt("wins");
                    int losses = rs.getInt("losses");
                    rs.close();
                    
                    if(won != wins || losses != (matches - wins)) {
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

                        String query = "INSERT INTO `" + secure.DBStructure.table19 + "` (`id`, `verifier_id`, `owner_id`, `date_added`, `won`, `matches`, `prev_won`, `prev_matches`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setInt(1, winlossId);
                        ps.setString(2, verifier);
                        ps.setInt(3, id);
                        ps.setObject(4, dateAdded);
                        ps.setInt(5, won);
                        ps.setInt(6, matches);
                        ps.setInt(7, wins);
                        ps.setInt(8, wins + losses);
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
                        ps.setString(4, verifier);
                        ps.setString(5, username);
                        ps.setObject(6, dateAdded);
                        ps.setInt(7, 0);
                        ps.execute();
                        ps.close();
                    }
                }
                
                /* Cover */
                if(cover != null && !cover.equals("") && !error) {
                    
                    String query = "UPDATE `" + secure.DBStructure.table10 + "` SET top = ? WHERE id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, cover);
                    ps.setInt(2, id);
                    ps.executeUpdate();
                    ps.close();
                    
                }
                
                /* Sleeves */
                if(sleeves != null && !sleeves.equals("") && !error) {
                    
                    String query = "UPDATE `" + secure.DBStructure.table10 + "` SET bottom = ? WHERE id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, sleeves);
                    ps.setInt(2, id);
                    ps.executeUpdate();
                    ps.close();
                    
                }
                
                /* Update Total */
                statement = connection.createStatement();
                ResultSet check = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");
                
                while (check.next()) {

                    String total = request.getParameter("total" + check.getString("card_id"));
                    String query;
                    PreparedStatement ps;
                    
                    if(total != null && !total.equals("") && Integer.parseInt(total) > 0) {
                        
                        statement = connection.createStatement();
                        ResultSet tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "' AND card_id = '" + check.getString("card_id") + "'");
                        tmp.next();
                        int prevTotal = tmp.getInt("card_total");
                        tmp.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table13 + "` SET card_total = ? WHERE deck_id = ? AND card_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, Integer.parseInt(total));
                        ps.setInt(2, id);
                        ps.setString(3, check.getString("card_id"));
                        ps.executeUpdate();
                        ps.close();
                        
                        statement = connection.createStatement();
                        tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + id + "'");
                        tmp.next();
                        int deckTotal = tmp.getInt("total") + Integer.parseInt(total) - prevTotal;
                        tmp.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table10 + "` SET total = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, deckTotal);
                        ps.setInt(2, id);
                        ps.executeUpdate();
                        ps.close();
                    }
                    
                }
                check.close();
                
                /* Copy Collection */
                if(copyCollection != null && !copyCollection.equals("") && !error) {
                    
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");
                    
                    while (rs.next()) {
                        
                        if(!selected.contains(rs.getString("card_id"))) {
                            continue;
                        }
                        
                        String total = request.getParameter("total" + rs.getString("card_id"));
                        int cardTotal;
                        if(total != null && !total.equals("")) {
                            cardTotal = Integer.parseInt(total);
                        }
                        else {
                            cardTotal = rs.getInt("card_total");
                        }
                        
                        statement = connection.createStatement();
                        ResultSet tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table8 + "` ORDER BY id ASC");
                        
                        /* find the next possible id */
                        int count = 1;
                        while(tmp.next()) {
                            if(tmp.getInt("id") > count) {
                                break;
                            }
                            count++;
                        }
                        tmp.close();
                        
                        statement = connection.createStatement();
                        tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table8 + "` WHERE collection_id = '" + copyCollection + "' AND card_id = '" + rs.getString("card_id") + "'");
                        if(tmp.next()) {
                            tmp.close();
                            continue;
                        }
                        tmp.close();
                        
                        String cardId = rs.getString("card_id");
                        String query = "INSERT INTO `" + secure.DBStructure.table8 + "` (`id`, `collection_id`, `card_id`, `card_total`) VALUES (?, ?, ?, ?);";
                        PreparedStatement ps = connection.prepareStatement(query);

                        ps.setInt(1, count);
                        ps.setString(2, copyCollection);
                        ps.setString(3, cardId);
                        ps.setInt(4, cardTotal);
                        ps.execute();
                        ps.close();
                        
                        statement = connection.createStatement();
                        tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table5 + "` WHERE id = '" + copyCollection + "'");
                        tmp.next();
                        int collectionTotal = tmp.getInt("total") + cardTotal;
                        int entries = tmp.getInt("entries") + 1;
                        tmp.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table5 + "` SET total = ?, entries = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, collectionTotal);
                        ps.setInt(2, entries);
                        ps.setString(3, copyCollection);
                        ps.executeUpdate();
                        ps.close();
                        
                    }
                    rs.close();
                    
                }
                
                /* Copy Deck */
                if(copyDeck != null && !copyDeck.equals("") && !error) {
                    
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");
                    
                    while (rs.next()) {
                        
                        if(!selected.contains(rs.getString("card_id"))) {
                            continue;
                        }
                        
                        String total = request.getParameter("total" + rs.getString("card_id"));
                        int cardTotal;
                        if(total != null && !total.equals("")) {
                            cardTotal = Integer.parseInt(total);
                        }
                        else {
                            cardTotal = rs.getInt("card_total");
                        }
                        
                        statement = connection.createStatement();
                        ResultSet tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` ORDER BY id ASC");
                        
                        /* find the next possible id */
                        int count = 1;
                        while(tmp.next()) {
                            if(tmp.getInt("id") > count) {
                                break;
                            }
                            count++;
                        }
                        tmp.close();
                        
                        statement = connection.createStatement();
                        tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + copyDeck + "' AND card_id = '" + rs.getString("card_id") + "'");
                        if(tmp.next()) {
                            tmp.close();
                            continue;
                        }
                        tmp.close();
                        
                        String cardId = rs.getString("card_id");
                        String query = "INSERT INTO `" + secure.DBStructure.table13 + "` (`id`, `deck_id`, `card_id`, `card_total`) VALUES (?, ?, ?, ?);";
                        PreparedStatement ps = connection.prepareStatement(query);

                        ps.setInt(1, count);
                        ps.setString(2, copyDeck);
                        ps.setString(3, cardId);
                        ps.setInt(4, cardTotal);
                        ps.execute();
                        ps.close();
                        
                        statement = connection.createStatement();
                        tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + copyDeck + "'");
                        tmp.next();
                        int deckTotal = tmp.getInt("total") + cardTotal;
                        int entries = tmp.getInt("entries") + 1;
                        tmp.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table10 + "` SET total = ?, entries = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, deckTotal);
                        ps.setInt(2, entries);
                        ps.setString(3, copyDeck);
                        ps.executeUpdate();
                        ps.close();
                        
                    }
                    rs.close();
                    
                }
                
                /* Delete */
                if(delete != null && delete.equals("delete_selected") && !error) {
                    
                    statement = connection.createStatement();
                    ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");
                    
                    while (rs.next()) {
                        if(!selected.contains(rs.getString("card_id"))) {
                            continue;
                        }
                        
                        /* Date */
                        java.util.Date date = new Date();
                        Object dateViewed = new java.sql.Timestamp(date.getTime());
                        String query = "UPDATE `" + secure.DBStructure.table1 + "` SET viewed = ? WHERE id = ?";
                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setObject(1, dateViewed);
                        ps.setString(2, rs.getString("card_id"));
                        ps.executeUpdate();
                        ps.close();
                        
                        statement = connection.createStatement();
                        ResultSet tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "' AND card_id = '" + rs.getString("card_id") + "'");
                        tmp.next();
                        int cardTotal = tmp.getInt("card_total");
                        tmp.close();

                        query = "DELETE FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ? AND card_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, id);
                        ps.setString(2, rs.getString("card_id"));
                        ps.executeUpdate();
                        ps.close();
                        
                        statement = connection.createStatement();
                        tmp = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + id + "'");
                        tmp.next();
                        int deckTotal = tmp.getInt("total") - cardTotal;
                        int entries = tmp.getInt("entries") - 1;
                        if(entries < 0) {
                            entries = 0;
                        }
                        String newCover = tmp.getString("top");
                        CardInfo card = CardInfo.getCardById(rs.getString("card_id"));
                        if(newCover != null && card != null && card.getFront() != null && newCover.equals(card.getFront())) {
                            newCover = null;
                        }
                        tmp.close();
                        
                        query = "UPDATE `" + secure.DBStructure.table10 + "` SET total = ?, entries = ?, top = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, deckTotal);
                        ps.setInt(2, entries);
                        ps.setString(3, newCover);
                        ps.setInt(4, id);
                        ps.executeUpdate();
                        ps.close();
                    }
                    rs.close();
                    
                }
                
                /* Date */
                if(!error) {
                    java.util.Date date = new Date();
                    Object dateUpdated = new java.sql.Timestamp(date.getTime());
                    String query = "UPDATE `" + secure.DBStructure.table10 + "` SET date_updated = ? WHERE id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setObject(1, dateUpdated);
                    ps.setInt(2, id);
                    ps.executeUpdate();
                    ps.close();
                }
                
                /* Assurance */
                int total = 0;
                int entries = 0;
                statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");

                while(rs.next()) {
                    total += rs.getInt("card_total");
                    entries++;
                }
                rs.close();
                
                String query = "UPDATE `" + secure.DBStructure.table10 + "` SET total = ?, entries = ? WHERE id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, total);
                ps.setInt(2, entries);
                ps.setInt(3, id);
                ps.executeUpdate();
                ps.close();
                
                if(error) {
                    url = "/edit_deck.jsp";
                }
                else {
                    url = "/deck.jsp";
                }
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("delete_card")) {
            int id = Integer.parseInt((String)request.getParameter("id"));
            String cardId = (String)request.getParameter("card_id");
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                Statement statement;
                
                statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = '" + id + "'");

                rs.next();
                int cardTotal = rs.getInt("card_total");
                rs.close();

                String query = "DELETE FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ? AND card_id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.setString(2, cardId);
                ps.executeUpdate();
                ps.close();

                statement = connection.createStatement();
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = '" + id + "'");
                rs.next();
                int deckTotal = rs.getInt("total") - cardTotal;
                int entries = rs.getInt("entries") - 1;
                if(entries < 0) {
                    entries = 0;
                }
                String newCover = rs.getString("top");
                CardInfo card = CardInfo.getCardById(cardId);
                if(newCover != null && card != null && card.getFront() != null && newCover.equals(card.getFront())) {
                    newCover = null;
                }
                rs.close();

                query = "UPDATE `" + secure.DBStructure.table10 + "` SET total = ?, entries = ?, top = ? WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setInt(1, deckTotal);
                ps.setInt(2, entries);
                ps.setString(3, newCover);
                ps.setInt(4, id);
                ps.executeUpdate();
                ps.close();
                                    
                /* Date */
                java.util.Date date = new Date();
                Object dateUpdated = new java.sql.Timestamp(date.getTime());
                query = "UPDATE `" + secure.DBStructure.table10 + "` SET date_updated = ? WHERE id = ?";
                ps = connection.prepareStatement(query);
                ps.setObject(1, dateUpdated);
                ps.setInt(2, id);
                ps.executeUpdate();
                ps.close();
                
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("create")) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            if(description == null || description.equals("")) {
                description = null;
            }
            boolean error = false;
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                String query;
                PreparedStatement ps;

                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE user='" + username + "';");
                
                while (rs.next()) {
                    if(rs.getString("name").equals(name)) {
                        error = true;
                        break;
                    }
                }
                rs.close();
                
                statement = connection.createStatement();
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` ORDER BY id ASC");
                
                /* find the next possible id */
                int id = 1;
                while(rs.next()) {
                    if(rs.getInt("id") > id) {
                        break;
                    }
                    id++;
                }
                rs.close();
                
                if(!error) {
                    query = "INSERT INTO `" + secure.DBStructure.table10 + "` (`id`, `name`, `user`, `top`, `bottom`, `entries`, `total`, `date_updated`, `description`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";

                    ps = connection.prepareStatement(query);
                    java.util.Date date = new Date();
                    Object dateUpdated = new java.sql.Timestamp(date.getTime());

                    ps.setInt(1, id);
                    ps.setString(2, name);
                    ps.setString(3, username);
                    ps.setString(4, null);
                    ps.setString(5, null);
                    ps.setInt(6, 0);
                    ps.setInt(7, 0);
                    ps.setObject(8, dateUpdated);
                    ps.setString(9, description);
                    ps.execute();
                    ps.close();
                    url = "/your_decks.jsp";
                }
                else {
                    request.setAttribute("error", "error: name");
                    url = "/new_deck.jsp";
                }
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("favorite")) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table14 + "` WHERE user='" + username + "'");
                
                boolean error = false;
                while(rs.next()) {
                    if(rs.getInt("deck_id") == id) {
                        error = true;
                    }
                }
                rs.close();
                
                rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table14 + "` ORDER BY id ASC");
                
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
                    String query = "INSERT INTO `" + secure.DBStructure.table14 + "` (`id`, `deck_id`, `user`) VALUES (?, ?, ?);";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setInt(1, count);
                    ps.setInt(2, id);
                    ps.setString(3, username);

                    ps.execute();
                    ps.close();
                }
                else {
                    String query = "DELETE FROM `" + secure.DBStructure.table14 + "` WHERE deck_id=" + id + " AND user='" + username + "'";

                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.executeUpdate();
                    ps.close();
                }
                
                connection.close();
                url = "/profile.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("edit")) {
            url = "/edit_deck.jsp";
        } else if(action.equals("remove_card")) {
            String cardId = request.getParameter("card_id");
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);

                String query = "SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ? AND card_id = ?";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, id);
                ps.setString(2, cardId);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next()) {
                    int oldTotal = rs.getInt("card_total");
                    rs.close();
                    ps.close();

                    query = "SELECT * FROM `" + secure.DBStructure.table10 + "` WHERE id = ?";
                    ps = connection.prepareStatement(query);
                    ps.setInt(1, id);
                    rs = ps.executeQuery();

                    if(rs.next()) {
                        int newEntries = rs.getInt("entries") - 1;
                        int newTotal = rs.getInt("total") - oldTotal;
                        rs.close();
                        ps.close();

                        query = "UPDATE `" + secure.DBStructure.table10 + "` SET entries = ? AND total = ? WHERE id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, newEntries);
                        ps.setInt(2, newTotal);
                        ps.setInt(3, id);
                        ps.executeUpdate();
                        ps.close();
                        
                        query = "DELETE FROM `" + secure.DBStructure.table13 + "` WHERE deck_id = ? AND card_id = ?";
                        ps = connection.prepareStatement(query);
                        ps.setInt(1, id);
                        ps.setString(2, cardId);
                        ps.execute();
                        ps.close();
                    }
                    else {
                        rs.close();
                        ps.close();
                    }
                }
                else {
                    rs.close();
                    ps.close();
                }
                
                connection.close();
                url = "/deck.jsp";
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(DeckServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("your_decks")) {
            if(username.equals("")) {
                request.setAttribute("username", "error: propted redirect");
                url = "/login.jsp";
            }
            else {
                url = "/your_decks.jsp";
            }
        } else if(action.equals("deck")) {
            url = "/deck.jsp";
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
