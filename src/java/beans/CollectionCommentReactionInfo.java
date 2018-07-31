package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CollectionCommentReactionInfo implements Serializable{
    
    private static LinkedHashMap reactionsById = new LinkedHashMap();
    private Connection connection;
    
    private int commentId;
    private String user;
    private int reaction;
    
    public CollectionCommentReactionInfo() {
        try {
            reactionsById = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table7 + "`");
            
            int id = 1;
            while(rs.next()) {
                int commentId = rs.getInt("comment_id");
                String user = rs.getString("username");
                int reaction = rs.getInt("reaction");
                
                reactionsById.put(id, new CollectionCommentReactionInfo(commentId, user, reaction));
                id++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CollectionCommentReactionInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CollectionCommentReactionInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CollectionCommentReactionInfo(int commentId, String user, int reaction) {
        this.commentId = commentId;
        this.user = user;
        this.reaction = reaction;
    }
    
    public static CollectionCommentReactionInfo getReactionById(int id) {
        return ((CollectionCommentReactionInfo)reactionsById.get(id));
    }
    
    public int getCommentId() {
        return commentId;
    }
    
    public String getUser() {
        return user;
    }
    
    public int getReaction() {
        return reaction;
    }
    
}