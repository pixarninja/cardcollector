package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CardCommentInfo implements Serializable{
    
    private static LinkedHashMap commentsById = new LinkedHashMap();
    private static LinkedHashMap commentsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String cardId;
    private String owner;
    private String text;
    private int likes;
    private int dislikes;
    private java.util.Date dateAdded;
    
    public CardCommentInfo() {
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

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table2 + "` ORDER BY date_added ASC");
            
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String cardId = rs.getString("card_id");
                String owner = rs.getString("owner");
                String text = rs.getString("text");
                int likes = rs.getInt("likes");
                int dislikes = rs.getInt("dislikes");
                java.util.Date dateAdded = rs.getDate("date_added");
                
                commentsById.put(id, new CardCommentInfo(id, cardId, owner, text, likes, dislikes, dateAdded));
                commentsByNum.put(num, new CardCommentInfo(id, cardId, owner, text, likes, dislikes, dateAdded));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CardCommentInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CardCommentInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CardCommentInfo(int id, String cardId, String owner, String text, int likes, int dislikes, java.util.Date dateAdded) {
        this.id = id;
        this.cardId = cardId;
        this.owner = owner;
        this.text = text;
        this.likes = likes;
        this.dislikes = dislikes;
        this.dateAdded = dateAdded;
    }
    
    public static CardCommentInfo getCommentById(int id) {
        return ((CardCommentInfo)commentsById.get(id));
    }
    
    public static CardCommentInfo getCommentByNum(int num) {
        return ((CardCommentInfo)commentsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public String getCardId() {
        return cardId;
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