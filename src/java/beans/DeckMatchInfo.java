package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeckMatchInfo implements Serializable{
    
    private static LinkedHashMap matchesById = new LinkedHashMap();
    private static LinkedHashMap matchesByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int challengerId;
    private int ownerId;
    private String text;
    private java.util.Date dateAdded;
    private int won;
    private int matches;
    
    public DeckMatchInfo() {
        try {
            matchesById = new LinkedHashMap();
            matchesByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table18 + "` ORDER BY date_added ASC");
            
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int challegerId = rs.getInt("challenger_id");
                int ownerId = rs.getInt("owner_id");
                String text = rs.getString("text");
                java.util.Date dateAdded = rs.getDate("date_added");
                int won = rs.getInt("won");
                int matches = rs.getInt("matches");
                
                matchesById.put(id, new DeckMatchInfo(id, challegerId, ownerId, text, dateAdded, won, matches));
                matchesByNum.put(num, new DeckMatchInfo(id, challegerId, ownerId, text, dateAdded, won, matches));
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
    
    public DeckMatchInfo(int id, int challengerId, int ownerId, String text, java.util.Date dateAdded, int won, int matches) {
        this.id = id;
        this.challengerId = challengerId;
        this.ownerId = ownerId;
        this.text = text;
        this.dateAdded = dateAdded;
        this.won = won;
        this.matches = matches;
    }
    
    public static DeckMatchInfo getMatchById(int id) {
        return ((DeckMatchInfo)matchesById.get(id));
    }
    
    public static DeckMatchInfo getMatchByNum(int num) {
        return ((DeckMatchInfo)matchesByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getChallengerId() {
        return challengerId;
    }
    
    public int getOwnerId() {
        return ownerId;
    }
    
    public String getText() {
        return text;
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
    
}