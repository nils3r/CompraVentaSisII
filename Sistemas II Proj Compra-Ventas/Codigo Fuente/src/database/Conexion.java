package database;

import java.sql.*;
import javax.swing.JOptionPane;

public class Conexion {

    private String DB = "dbventas";
    private String URL = "jdbc:mysql://localhost:3306/" + DB;
    private String USER = "root";
    private String PASSWORD = "";

    //Metodos
    public Conexion() {
    }

    public Connection conectar() {
        Connection enlace = null;
        try {
            String DRIVER = "org.gjt.mm.mysql.Driver";
            Class.forName(DRIVER);
            enlace = DriverManager.getConnection(this.URL, this.USER, this.PASSWORD);
            System.out.println("CONECTADO");
        } catch (ClassNotFoundException | SQLException e) {
            JOptionPane.showMessageDialog(null, e.getMessage());
        }
        return enlace;
    }

    //GETTER AND SETTER
    public String getDB() {
        return DB;
    }

    public void setDB(String DB) {
        this.DB = DB;
    }

    public String getURL() {
        return URL;
    }

    public void setURL(String URL) {
        this.URL = URL;
    }

    public String getUSER() {
        return USER;
    }

    public void setUSER(String USER) {
        this.USER = USER;
    }

    public String getPASSWORD() {
        return PASSWORD;
    }

    public void setPASSWORD(String PASSWORD) {
        this.PASSWORD = PASSWORD;
    }

}
