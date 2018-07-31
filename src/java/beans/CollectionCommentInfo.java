package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CollectionCommentInfo implements Serializable{
    
    private static LinkedHashMap commentsById = new LinkedHashMap();
    private static LinkedHashMap commentsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int collectionId;
    private String owner;
    private String text;
    private int likes;
    private int dislikes;
    private java.util.Date dateAdded;
    
    public CollectionCommentInfo() {
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

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table6 + "` ORDER BY date_added ASC");
            
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int collectionId = rs.getInt("collection_id");
                String owner = rs.getString("owner");
                String text = rs.getString("text");
                int likes = rs.getInt("likes");
                int dislikes = rs.getInt("dislikes");
                java.util.Date dateAdded = rs.getDate("date_added");
                
                commentsById.put(id, new CollectionCommentInfo(id, collectionId, owner, text, likes, dislikes, dateAdded));
                commentsByNum.put(num, new CollectionCommentInfo(id, collectionId, owner, text, likes, dislikes, dateAdded));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CollectionCommentInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CollectionCommentInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CollectionCommentInfo(int id, int collectionId, String owner, String text, int likes, int dislikes, java.util.Date dateAdded) {
        this.id = id;
        this.collectionId = collectionId;
        this.owner = owner;
        this.text = text;
        this.likes = likes;
        this.dislikes = dislikes;
        this.dateAdded = dateAdded;
    }
    
    public static CollectionCommentInfo getCommentById(int id) {
        return ((CollectionCommentInfo)commentsById.get(id));
    }
    
    public static CollectionCommentInfo getCommentByNum(int num) {
        return ((CollectionCommentInfo)commentsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getCollectionId() {
        return collectionId;
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