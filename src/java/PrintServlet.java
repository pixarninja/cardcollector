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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Wesley
 */
@WebServlet(urlPatterns = {"/SelectionServlet"})
public class PrintServlet extends HttpServlet {

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
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                String id = request.getParameter("id");
                
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table1 + "` WHERE id='" + id + "'");
                
                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("id"));
                    request.setAttribute(Integer.toString(count) + "total", 1);
                }
                
                url = "/print.jsp";
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
        } else if(action.equals("collection")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                int id;
                if(request.getParameter("id") != null && !request.getParameter("id").equals("")) {
                    id = Integer.parseInt(request.getParameter("id"));
                }
                else {
                    id = 0;
                }
                
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table8 + "` WHERE collection_id=" + id + " ORDER BY card_total ASC");
                
                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("card_id"));
                    request.setAttribute(Integer.toString(count) + "total", rs.getInt("card_total"));
                }
                
                url = "/print.jsp";
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
        } else if(action.equals("deck")) {
            try {
                String driver = secure.DBConnection.driver;
                Class.forName(driver);
                String dbURL = secure.DBConnection.dbURL;
                String user = secure.DBConnection.username;
                String pass = secure.DBConnection.password;
                Connection connection = DriverManager.getConnection(dbURL, user, pass);
                
                int id;
                if(request.getParameter("id") != null && !request.getParameter("id").equals("")) {
                    id = Integer.parseInt(request.getParameter("id"));
                }
                else {
                    id = 0;
                }
                
                Statement statement = connection.createStatement();
                ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` WHERE deck_id=" + id + " ORDER BY card_total ASC");
                
                int count = 0;
                while(rs.next()) {
                    count++;
                    request.setAttribute(Integer.toString(count), rs.getString("card_id"));
                    request.setAttribute(Integer.toString(count) + "total", rs.getInt("card_total"));
                }
                
                url = "/print.jsp";
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
