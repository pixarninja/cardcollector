package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeckWinLossInfo implements Serializable{
    
    private static LinkedHashMap winlossById = new LinkedHashMap();
    private static LinkedHashMap winlossByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String verifierId;
    private int ownerId;
    private java.util.Date dateAdded;
    private int won;
    private int matches;
    private int prevWon;
    private int prevMatches;
    
    public DeckWinLossInfo() {
        try {
            winlossById = new LinkedHashMap();
            winlossByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table19 + "` ORDER BY date_added ASC");
            
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String verifierId = rs.getString("verifier_id");
                int ownerId = rs.getInt("owner_id");
                java.util.Date dateAdded = rs.getDate("date_added");
                int won = rs.getInt("won");
                int matches = rs.getInt("matches");
                int prevWon = rs.getInt("prev_won");
                int prevMatches = rs.getInt("prev_matches");
                
                winlossById.put(id, new DeckWinLossInfo(id, verifierId, ownerId, dateAdded, won, matches, prevWon, prevMatches));
                winlossByNum.put(num, new DeckWinLossInfo(id, verifierId, ownerId, dateAdded, won, matches, prevWon, prevMatches));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeckCommentInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DeckCommentInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DeckWinLossInfo(int id, String verifierId, int ownerId, java.util.Date dateAdded, int won, int matches, int prevWon, int prevMatches) {
        this.id = id;
        this.verifierId = verifierId;
        this.ownerId = ownerId;
        this.dateAdded = dateAdded;
        this.won = won;
        this.matches = matches;
        this.prevWon = prevWon;
        this.prevMatches = prevMatches;
    }
    
    public static DeckWinLossInfo getWinLossById(int id) {
        return ((DeckWinLossInfo)winlossById.get(id));
    }
    
    public static DeckWinLossInfo getWinLossByNum(int num) {
        return ((DeckWinLossInfo)winlossByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public String getVerifierId() {
        return verifierId;
    }
    
    public int getOwnerId() {
        return ownerId;
    }
    
    public java.util.Date getDateAdded() {
        return dateAdded;
    }
    
    public int getWon() {
        return won;
    }
    
    public int getMatches() {
        return matches;
    }
    
    public int getPrevWon() {
        return prevWon;
    }
    
    public int getPrevMatches() {
        return prevMatches;
    }
    
}