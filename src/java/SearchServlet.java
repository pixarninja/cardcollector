import beans.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.BitSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

    public SearchServlet() {
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
        if(action.equals("users")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table16 + "` ORDER BY joined DESC;";
                PreparedStatement ps = connection.prepareStatement(query);
                
                ResultSet rs = ps.executeQuery( );

                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("username"));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/user_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("users_alpha")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String search = "";
                String prefix = "";
                String order = "";
                String orderBy = "";
                int count = 0;
                if((request.getParameter("order") != null) && !request.getParameter("order").equals("")) {
                    request.setAttribute("order", request.getParameter("order"));
                    if(request.getParameter("order").equals("asc")) {
                        order = " ASC;";
                    }
                    else {
                        order = " DESC;";
                    }
                }
                else {
                    order = " ASC;";
                }
                if((request.getParameter("order_by") != null) && !request.getParameter("order_by").equals("")) {
                    request.setAttribute("order_by", request.getParameter("order_by"));
                    orderBy = " ORDER BY " + request.getParameter("order_by");
                }
                else {
                    orderBy = " ORDER BY name";
                }
                String[] parameters = {"name", "user"};
                for (String name : parameters) {
                    request.setAttribute(name, request.getParameter(name));
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " AND";
                        }
                        if(name.equals("user")) {
                            search += prefix + " username LIKE ?";
                        }
                        else {
                            search += prefix + " " + name + " LIKE ?";
                        }
                    }
                }
                search += (orderBy + order);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table16 + "`" + search;
                PreparedStatement ps = connection.prepareStatement(query);
                
                int i = 1;
                for (String name : parameters) {
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        ps.setString(i, "%" + value + "%");
                        i++;
                    }
                }
                
                ResultSet rs = ps.executeQuery( );

                count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("username"));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/user_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("search")) {
            request.setAttribute("total", 1);
            url = "/advanced.jsp";
        } else if(action.equals("decks")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table10 + "` ORDER BY date_updated DESC;";
                PreparedStatement ps = connection.prepareStatement(query);
                
                ResultSet rs = ps.executeQuery( );
                
                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), Integer.toString(rs.getInt("id")));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/deck_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("decks_alpha")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String search = "";
                String prefix = "";
                String order = "";
                String orderBy = "";
                String inclusion = "";
                int count = 0;
                if((request.getParameter("order") != null) && !request.getParameter("order").equals("")) {
                    request.setAttribute("order", request.getParameter("order"));
                    if(request.getParameter("order").equals("asc")) {
                        order = " ASC;";
                    }
                    else {
                        order = " DESC;";
                    }
                }
                else {
                    order = " ASC;";
                }
                if((request.getParameter("order_by") != null) && !request.getParameter("order_by").equals("")) {
                    request.setAttribute("order_by", request.getParameter("order_by"));
                    orderBy = " ORDER BY " + request.getParameter("order_by");
                }
                else {
                    orderBy = " ORDER BY name";
                }
                if((request.getParameter("inclusion") != null) && !request.getParameter("inclusion").equals("")) {
                    request.setAttribute("inclusion", request.getParameter("inclusion"));
                    if(request.getParameter("inclusion").equals("inc")) {
                        inclusion = " OR";
                    }
                    else {
                        inclusion = " AND";
                    }
                }
                else {
                    inclusion = " AND";
                }
                String[] parameters = {"name", "user"};
                for (String name : parameters) {
                    request.setAttribute(name, request.getParameter(name));
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " " + inclusion;
                        }
                        search += prefix + " " + name + " LIKE ?";
                    }
                }
                search += (orderBy + order);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table10 + "`" + search;
                PreparedStatement ps = connection.prepareStatement(query);
                
                int i = 1;
                for (String name : parameters) {
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        ps.setString(i, "%" + value + "%");
                        i++;
                    }
                }
                
                ResultSet rs = ps.executeQuery( );

                count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), Integer.toString(rs.getInt("id")));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/deck_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("collections")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table5 + "` ORDER BY date_updated DESC;";
                PreparedStatement ps = connection.prepareStatement(query);
                
                ResultSet rs = ps.executeQuery( );

                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), Integer.toString(rs.getInt("id")));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/collection_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("collections_alpha")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String search = "";
                String prefix = "";
                String order = "";
                String orderBy = "";
                String inclusion = "";
                int count = 0;
                if((request.getParameter("order") != null) && !request.getParameter("order").equals("")) {
                    request.setAttribute("order", request.getParameter("order"));
                    if(request.getParameter("order").equals("asc")) {
                        order = " ASC;";
                    }
                    else {
                        order = " DESC;";
                    }
                }
                else {
                    order = " ASC;";
                }
                if((request.getParameter("order_by") != null) && !request.getParameter("order_by").equals("")) {
                    request.setAttribute("order_by", request.getParameter("order_by"));
                    orderBy = " ORDER BY " + request.getParameter("order_by");
                }
                else {
                    orderBy = " ORDER BY name";
                }
                if((request.getParameter("inclusion") != null) && !request.getParameter("inclusion").equals("")) {
                    request.setAttribute("inclusion", request.getParameter("inclusion"));
                    if(request.getParameter("inclusion").equals("inc")) {
                        inclusion = " OR";
                    }
                    else {
                        inclusion = " AND";
                    }
                }
                String[] parameters = {"name", "user"};
                for (String name : parameters) {
                    request.setAttribute(name, request.getParameter(name));
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = " " + inclusion;
                        }
                        search += prefix + " " + name + " LIKE ?";
                    }
                }
                search += (orderBy + order);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table5 + "`" + search;
                PreparedStatement ps = connection.prepareStatement(query);
                
                int i = 1;
                for (String name : parameters) {
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        ps.setString(i, "%" + value + "%");
                        i++;
                    }
                }
                
                ResultSet rs = ps.executeQuery( );

                count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), Integer.toString(rs.getInt("id")));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/collection_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("cards")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table1 + "` ORDER BY viewed DESC;";
                PreparedStatement ps = connection.prepareStatement(query);
                
                ResultSet rs = ps.executeQuery( );

                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("id"));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/card_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("cards_alpha")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String search = "";
                String prefix = "";
                String order = "";
                String orderBy = "";
                String inclusion = "";
                String manaInclusion = "";
                boolean selective = false;
                int count = 0;
                if((request.getParameter("order") != null) && !request.getParameter("order").equals("")) {
                    request.setAttribute("order", request.getParameter("order"));
                    if(request.getParameter("order").equals("asc")) {
                        order = " ASC;";
                    }
                    else {
                        order = " DESC;";
                    }
                }
                else {
                    order = " ASC;";
                }
                if((request.getParameter("order_by") != null) && !request.getParameter("order_by").equals("")) {
                    request.setAttribute("order_by", request.getParameter("order_by"));
                    orderBy = " ORDER BY " + request.getParameter("order_by");
                }
                else {
                    orderBy = " ORDER BY name";
                }
                if((request.getParameter("inclusion") != null) && !request.getParameter("inclusion").equals("")) {
                    request.setAttribute("inclusion", request.getParameter("inclusion"));
                    if(request.getParameter("inclusion").equals("inc")) {
                        inclusion = " OR";
                    }
                    else {
                        inclusion = " AND";
                    }
                }
                if((request.getParameter("mana_inclusion") != null) && !request.getParameter("mana_inclusion").equals("")) {
                    request.setAttribute("mana_inclusion", request.getParameter("mana_inclusion"));
                    if(request.getParameter("mana_inclusion").equals("inc")) {
                        manaInclusion = " OR";
                    }
                    else {
                        manaInclusion = " AND";
                    }
                }
                if((request.getParameter("selective") != null) && !request.getParameter("selective").equals("")) {
                    request.setAttribute("selective", request.getParameter("selective"));
                    if(request.getParameter("selective").equals("inc")) {
                        selective = false;
                    }
                    else {
                        selective = true;
                    }
                }
                else {
                    selective = false;
                }
                if(request.getParameter("-")!= null && !request.getParameter("-").equals("")) { // check if None is selected
                    if(count == 0) {
                        prefix = " WHERE";
                        count++;
                    }
                    else {
                        prefix = inclusion;
                    }
                    
                    search += prefix + " legalities LIKE '000000000000'";
                }
                else {
                    String[] legalities = {"S", "F", "R", "M", "L", "A", "V", "P", "C", "1", "D", "B"};
                    String legality = "";
                    boolean processed = false;
                    for(String flag : legalities) {
                        request.setAttribute(flag, request.getParameter(flag));
                        String value = request.getParameter(flag);
                        if(value != null && !value.equals("")) {
                            processed = true;
                            legality += "1";
                        }
                        else {
                            legality += "_";
                        }
                    }
                    if(processed) {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = inclusion;
                        }
                        
                        search += prefix + " legalities LIKE '" + legality + "'";
                    }
                }
                String[] parameters = {"common", "uncommon", "rare", "mythic", "set_id", "name", "type", "text", "flavor", "min_cmc", "max_cmc", "set_name", "min_power", "max_power", "min_toughness", "max_toughness", "artist", "year"};
                for (String name : parameters) {
                    request.setAttribute(name, request.getParameter(name));
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        if(count == 0) {
                            prefix = " WHERE";
                            count++;
                        }
                        else {
                            prefix = inclusion;
                        }
                        if(name.equals("common") || name.equals("uncommon") || name.equals("rare") || name.equals("mythic")) {
                            search += prefix + " " + value + " LIKE '%" + name + "%'";
                        }
                        else if(name.equals("min_power")) {
                            search += prefix + " power >= ?";
                        }
                        else if(name.equals("max_power")) {
                            search += prefix + " power <= ?";
                        }
                        else if(name.equals("min_toughness")) {
                            search += prefix + " toughness >= ?";
                        }
                        else if(name.equals("max_toughness")) {
                            search += prefix + " toughness <= ?";
                        }
                        else if(name.equals("min_cmc")) {
                            search += prefix + " cmc >= ?";
                        }
                        else if(name.equals("max_cmc")) {
                            search += prefix + " cmc <= ?";
                        }
                        else if(name.equals("year")) {
                            search += prefix + " year = ?";
                        }
                        else if(name.equals("name") || name.equals("type") || name.equals("text") || name.equals("flavor")) {
                            search += prefix + " ((" + name + " LIKE ?) OR (rev_" + name + " LIKE ?))";
                        }
                        else {
                            search += prefix + " " + name + " LIKE ?";
                        }
                    }
                }
                int num = 1;
                int total = 0;
                String[] options = {"white", "blue", "black", "red", "green", "colorless"};
                for (String name : options) {
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        if(value.equals("on")) {
                            total++;
                        }
                    }
                }
                if(selective && total > 0) {
                    /* first group all the selected options */
                    for(String name : options) {
                        String value = request.getParameter(name);
                        if((value != null) && !value.equals("")) {
                            if(value.equals("off")) {
                                continue;
                            }
                            String postfix = "";
                            if(num == 1) {
                                if(count == 0) {
                                    prefix = " WHERE (";
                                    count++;
                                }
                                else {
                                    prefix = inclusion + " (";
                                }
                            }
                            else {
                                prefix = manaInclusion + " ";
                            }
                            if(num >= total) {
                                postfix += " )";
                            }
                            prefix += "(";
                            postfix += ")";
                            if(name.equals("white")) {
                                search += prefix + " mc LIKE '%W%'" + postfix;
                            }
                            else if(name.equals("blue")) {
                                search += prefix + " mc LIKE '%U%'" + postfix;
                            }
                            else if(name.equals("black")) {
                                search += prefix + " mc LIKE '%B%'" + postfix;
                            }
                            else if(name.equals("red")) {
                                search += prefix + " mc LIKE '%R%'" + postfix;
                            }
                            else if(name.equals("green")) {
                                search += prefix + " mc LIKE '%G%'" + postfix;
                            }
                            else if(name.equals("colorless")) {
                                search += prefix + " mc LIKE '%C%' OR (mc != '' AND mc NOT LIKE '%W%' AND mc NOT LIKE '%U%' AND mc NOT LIKE '%B%' AND mc NOT LIKE '%R%' AND mc NOT LIKE '%G%')" + postfix;
                            }
                            num++;
                        }
                    }
                    /* now group all the unselected options */
                    for(String name : options) {
                        String value = request.getParameter(name);
                        if((value != null) && !value.equals("")) {
                            if(value.equals("on")) {
                                continue;
                            }
                            if(name.equals("white")) {
                                search += " AND mc NOT LIKE '%W%'";
                            }
                            else if(name.equals("blue")) {
                                search += " AND mc NOT LIKE '%U%'";
                            }
                            else if(name.equals("black")) {
                                search += " AND mc NOT LIKE '%B%'";
                            }
                            else if(name.equals("red")) {
                                search += " AND mc NOT LIKE '%R%'";
                            }
                            else if(name.equals("green")) {
                                search += " AND mc NOT LIKE '%G%'";
                            }
                            else if(name.equals("colorless")) {
                                search += " AND mc NOT LIKE '%C%'";
                            }
                            num++;
                        }
                    }
                }
                else {
                    for(String name : options) {
                        String value = request.getParameter(name);
                        if((value != null) && !value.equals("")) {
                            if(value.equals("off")) {
                                continue;
                            }
                            if(count == 0) {
                                prefix = " WHERE";
                                count++;
                            }
                            else {
                                prefix = " " + manaInclusion;
                            }
                            if(name.equals("white")) {
                                search += prefix + " mc LIKE '%W%'";
                            }
                            else if(name.equals("blue")) {
                                search += prefix + " mc LIKE '%U%'";
                            }
                            else if(name.equals("black")) {
                                search += prefix + " mc LIKE '%B%'";
                            }
                            else if(name.equals("red")) {
                                search += prefix + " mc LIKE '%R%'";
                            }
                            else if(name.equals("green")) {
                                search += prefix + " mc LIKE '%G%'";
                            }
                            else if(name.equals("colorless")) {
                                search += prefix + " mc LIKE '%C%' OR (mc != '' AND mc NOT LIKE '%W%' AND mc NOT LIKE '%U%' AND mc NOT LIKE '%B%' AND mc NOT LIKE '%R%' AND mc NOT LIKE '%G%')";
                            }
                        }
                    }
                }
                
                search += (orderBy + order);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table1 + "`" + search;
                PreparedStatement ps = connection.prepareStatement(query);
                
                int i = 1;
                for (String name : parameters) {
                    String value = request.getParameter(name);
                    if((value != null) && !value.equals("")) {
                        if(name.equals("common") || name.equals("uncommon") || name.equals("rare") || name.equals("mythic")) {
                            continue;
                        }
                        else if(name.equals("min_power") || name.equals("max_power") || name.equals("min_toughness") || name.equals("max_toughness") || name.equals("min_cmc") || name.equals("max_cmc")) {
                            ps.setInt(i, Integer.parseInt(value));
                        }
                        else if(name.equals("year")) {
                            ps.setString(i, value);
                        }
                        else if(name.equals("name") || name.equals("type") || name.equals("text") || name.equals("flavor")) {
                            ps.setString(i, "%" + value + "%");
                            i++;
                            ps.setString(i, "%" + value + "%");
                        }
                        else {
                            ps.setString(i, "%" + value + "%");
                        }
                        i++;
                    }
                }
                
                ResultSet rs = ps.executeQuery( );

                count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("id"));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/card_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("cards_quick")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                int count = 0;
                String search = "";
                String prefix = "";
                String order = " ASC";
                String orderBy = " ORDER BY name";
                String inclusion = " OR";
                String[] parameters = {"name", "type", "text", "flavor", "artist", "year"};
                for (String name : parameters) {
                    if(count == 0) {
                        prefix = " WHERE";
                        count++;
                    }
                    else {
                        prefix = inclusion;
                    }
                    if(name.equals("year")) {
                        search += prefix + " year = ?";
                    }
                    else if(name.equals("name") || name.equals("type") || name.equals("text") || name.equals("flavor")) {
                        search += prefix + " ((" + name + " LIKE ?) OR (rev_" + name + " LIKE ?))";
                    }
                    else {
                        search += prefix + " " + name + " LIKE ?";
                    }
                }
                
                search += (orderBy + order);
                
                String query = "SELECT * FROM `" + secure.DBStructure.table1 + "`" + search;
                PreparedStatement ps = connection.prepareStatement(query);
                
                int i = 1;
                String value = request.getParameter("query");
                if((value != null) && !value.equals("")) {
                    for (String name : parameters) {
                        if(name.equals("year")) {
                            ps.setString(i, value);
                        }
                        else if(name.equals("name") || name.equals("type") || name.equals("text") || name.equals("flavor")) {
                            ps.setString(i, "%" + value + "%");
                            i++;
                            ps.setString(i, "%" + value + "%");
                        }
                        else {
                            ps.setString(i, "%" + value + "%");
                        }
                        i++;
                    }
                }
                
                ResultSet rs = ps.executeQuery( );

                count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("id"));
                }
                
                request.setAttribute("total", count);
                
                if(count == 0) {
                    url = "/advanced.jsp";
                }
                else {
                    url = "/card_results.jsp";
                }

                rs.close();
                connection.close();
            } catch (ClassNotFoundException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                request.setAttribute("username", "");
                url = "/index.jsp";
                request.setAttribute("error", ex);
                Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if(action.equals("more_cards")) {
            url = "/card_results.jsp";
        } else if(action.equals("less_cards")) {
            url = "/card_results.jsp";
        } else if(action.equals("more_decks")) {
            url = "/deck_results.jsp";
        } else if(action.equals("less_decks")) {
            url = "/deck_results.jsp";
        } else if(action.equals("more_collections")) {
            url = "/collection_results.jsp";
        } else if(action.equals("less_collections")) {
            url = "/collection_results.jsp";
        } else if(action.equals("more_users")) {
            url = "/user_results.jsp";
        } else if(action.equals("less_users")) {
            url = "/user_results.jsp";
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
