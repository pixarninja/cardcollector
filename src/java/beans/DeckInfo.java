package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeckInfo implements Serializable{
    
    private static LinkedHashMap decksById = new LinkedHashMap();
    private static LinkedHashMap decksByNum = new LinkedHashMap();
    private static LinkedHashMap decksByNumAlpha = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String name;
    private String user;
    private String top;
    private String bottom;
    private int entries;
    private int total;
    private java.util.Date dateUpdated;
    private String description;
    private int wins;
    private int losses;
    
    public DeckInfo() {
        try {
            decksById = new LinkedHashMap();
            decksByNum = new LinkedHashMap();
            decksByNumAlpha = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` ORDER BY date_updated DESC");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String user = rs.getString("user");
                String top = rs.getString("top");
                String bottom = rs.getString("bottom");
                int entries = rs.getInt("entries");
                int total = rs.getInt("total");
                java.util.Date dateUpdated = rs.getDate("date_updated");
                String description = rs.getString("description");
                int wins = rs.getInt("wins");
                int losses = rs.getInt("losses");
                
                decksById.put(id, new DeckInfo(id, name, user, top, bottom, entries, total, dateUpdated, description, wins, losses));
                decksByNum.put(num, new DeckInfo(id, name, user, top, bottom, entries, total, dateUpdated, description, wins, losses));
                num++;
            }
            rs.close();
            
            statement = connection.createStatement();

            rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table10 + "` ORDER BY name ASC");
            num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String user = rs.getString("user");
                String top = rs.getString("top");
                String bottom = rs.getString("bottom");
                int entries = rs.getInt("entries");
                int total = rs.getInt("total");
                java.util.Date dateUpdated = rs.getDate("date_updated");
                String description = rs.getString("description");
                int wins = rs.getInt("wins");
                int losses = rs.getInt("losses");
                
                decksByNumAlpha.put(num, new DeckInfo(id, name, user, top, bottom, entries, total, dateUpdated, description, wins, losses));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeckInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DeckInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DeckInfo(int id, String name, String user, String top, String bottom, int entries, int total, java.util.Date dateUpdated, String description, int wins, int losses) {
        this.id = id;
        this.name = name;
        this.user = user;
        this.top = top;
        this.bottom = bottom;
        this.entries = entries;
        this.total = total;
        this.dateUpdated = dateUpdated;
        this.description = description;
        this.wins = wins;
        this.losses = losses;
    }
    
    public static DeckInfo getDeckById(int id) {
        return ((DeckInfo)decksById.get(id));
    }
    
    public static DeckInfo getDeckByNum(int num) {
        return ((DeckInfo)decksByNum.get(num));
    }
    
    public static DeckInfo getDeckByNumAlpha(int num) {
        return ((DeckInfo)decksByNumAlpha.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public String getUser() {
        return user;
    }
    
    public String getTop() {
        return top;
    }
    
    public String getBottom() {
        return bottom;
    }
    
    public int getEntries() {
        return entries;
    }
    
    public int getTotal() {
        return total;
    }
    
    public java.util.Date getDateUpdated() {
        return dateUpdated;
    }
    
    public String getDescription() {
        return description;
    }
    
    public int getWins() {
        return wins;
    }
    
    public int getLosses() {
        return losses;
    }
    
}
