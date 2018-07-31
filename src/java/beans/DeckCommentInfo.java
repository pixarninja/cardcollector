package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeckCommentInfo implements Serializable{
    
    private static LinkedHashMap commentsById = new LinkedHashMap();
    private static LinkedHashMap commentsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int deckId;
    private String owner;
    private String text;
    private int likes;
    private int dislikes;
    private java.util.Date dateAdded;
    
    public DeckCommentInfo() {
        try {
            commentsById = new LinkedHashMap();
            commentsByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table11 + "` ORDER BY date_added ASC");
            
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int deckId = rs.getInt("deck_id");
                String owner = rs.getString("owner");
                String text = rs.getString("text");
                int likes = rs.getInt("likes");
                int dislikes = rs.getInt("dislikes");
                java.util.Date dateAdded = rs.getDate("date_added");
                
                commentsById.put(id, new DeckCommentInfo(id, deckId, owner, text, likes, dislikes, dateAdded));
                commentsByNum.put(num, new DeckCommentInfo(id, deckId, owner, text, likes, dislikes, dateAdded));
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
    
    public DeckCommentInfo(int id, int deckId, String owner, String text, int likes, int dislikes, java.util.Date dateAdded) {
        this.id = id;
        this.deckId = deckId;
        this.owner = owner;
        this.text = text;
        this.likes = likes;
        this.dislikes = dislikes;
        this.dateAdded = dateAdded;
    }
    
    public static DeckCommentInfo getCommentById(int id) {
        return ((DeckCommentInfo)commentsById.get(id));
    }
    
    public static DeckCommentInfo getCommentByNum(int num) {
        return ((DeckCommentInfo)commentsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getDeckId() {
        return deckId;
    }
    
    public String getOwner() {
        return owner;
    }
    
    public String getText() {
        return text;
    }
    
    public int getLikes() {
        return likes;
    }
    
    public int getDislikes() {
        return dislikes;
    }
    
    public java.util.Date getDateAdded() {
        return dateAdded;
    }
    
}