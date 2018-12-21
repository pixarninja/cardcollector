package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RecentInfo implements Serializable{
    
    private static LinkedHashMap recentsByNum = new LinkedHashMap();
    private Connection connection;
    
    private DeckInfo deck;
    private CollectionInfo collection;
    private UserInfo user;
    
    public RecentInfo() {
        try {
            recentsByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statementDeck = connection.createStatement();
            Statement statementCollection = connection.createStatement();
            Statement statementUser = connection.createStatement();

            ResultSet rsDeck = statementDeck.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` ORDER BY date_updated DESC");
            ResultSet rsCollection = statementCollection.executeQuery("SELECT * FROM `" + secure.DBStructure.table5 + "` ORDER BY date_updated DESC");
            ResultSet rsUser = statementUser.executeQuery("SELECT * FROM `" + secure.DBStructure.table16 + "` ORDER BY joined DESC");
            DeckInfo deck;
            CollectionInfo collection;
            UserInfo userInfo;
            int num = 1;
            while(true) {
                if(rsDeck.next()) {
                    int id = rsDeck.getInt("id");
                    String name = rsDeck.getString("name");
                    String user = rsDeck.getString("user");
                    String top = rsDeck.getString("top");
                    String bottom = rsDeck.getString("bottom");
                    int entries = rsDeck.getInt("entries");
                    int total = rsDeck.getInt("total");
                    java.util.Date dateUpdated = rsDeck.getDate("date_updated");
                    String description = rsDeck.getString("description");
                    int wins = rsDeck.getInt("wins");
                    int losses = rsDeck.getInt("losses");
                    deck = new DeckInfo(id, name, user, top, bottom, entries, total, dateUpdated, description, wins, losses);
                }
                else {
                    deck = null;
                }
                if(rsCollection.next()) {
                    int id = rsCollection.getInt("id");
                    String name = rsCollection.getString("name");
                    String user = rsCollection.getString("user");
                    String top = rsCollection.getString("top");
                    String middle = rsCollection.getString("middle");
                    String bottom = rsCollection.getString("bottom");
                    int entries = rsCollection.getInt("entries");
                    int total = rsCollection.getInt("total");
                    java.util.Date dateUpdated = rsCollection.getDate("date_updated");
                    String description = rsCollection.getString("description");
                    collection = new CollectionInfo(id, name, user, top, middle, bottom, entries, total, dateUpdated, description);
                }
                else {
                    collection = null;
                }
                if(rsUser.next()) {
                    String user = rsUser.getString("username");
                    String pass = rsUser.getString("password");
                    String picture = rsUser.getString("picture");
                    if(picture == null || picture.equals("") || picture.equals("null")) {
                        picture = "images/blank_user.jpg";
                    }
                    String email = rsUser.getString("email");
                    String name = rsUser.getString("name");
                    java.util.Date dateJoined = rsUser.getDate("joined");
                    String bio = rsUser.getString("bio");
                    String notifications = rsUser.getString("notifications");

                    userInfo = new UserInfo(user, pass, picture, email, name, dateJoined, bio, notifications);
                }
                else {
                    userInfo = null;
                }
                if((deck == null && collection == null && userInfo == null) || num > 24) {
                    break;
                }
                
                recentsByNum.put(num, new RecentInfo(deck, collection, userInfo));
                num++;
            }
            rsDeck.close();
            rsCollection.close();
            rsUser.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RecentInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(RecentInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public RecentInfo(DeckInfo deck, CollectionInfo collection, UserInfo user) {
        this.deck = deck;
        this.collection = collection;
        this.user = user;
    }
    
    public static RecentInfo getRecentsByNum(int num) {
        return ((RecentInfo)recentsByNum.get(num));
    }
    
    public DeckInfo getDeck() {
        return deck;
    }
    
    public CollectionInfo getCollection() {
        return collection;
    }
    
    public UserInfo getUser() {
        return user;
    }
    
}
