package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NotificationInfo implements Serializable{
    
    private static LinkedHashMap notificationsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String owner;
    private String user;
    private int type;
    private int typeId;
    private java.util.Date dateAdded;
    private int status;
    
    public NotificationInfo() {
        try {
            notificationsByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table15 + "` ORDER BY date_added DESC");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String owner = rs.getString("owner");
                String user = rs.getString("user");
                int type = rs.getInt("type");
                int typeId = rs.getInt("type_id");
                java.util.Date dateAdded = rs.getDate("date_added");
                int status = rs.getInt("status");
                
                notificationsByNum.put(num, new NotificationInfo(id, type, typeId, owner, user, dateAdded, status));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NotificationInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(NotificationInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public NotificationInfo(int id, int type, int typeId, String owner, String user, java.util.Date dateAdded, int status) {
        this.id = id;
        this.type = type;
        this.typeId = typeId;
        this.owner = owner;
        this.user = user;
        this.dateAdded = dateAdded;
        this.status = status;
    }
    
    public static NotificationInfo getNotificationByNum(int num) {
        return ((NotificationInfo)notificationsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getType() {
        return type;
    }
    
    public int getTypeId() {
        return typeId;
    }
    
    public String getOwner() {
        return owner;
    }
    
    public String getUser() {
        return user;
    }
    
    public java.util.Date getDateAdded() {
        return dateAdded;
    }
    
    public int getStatus() {
        return status;
    }
    
}
