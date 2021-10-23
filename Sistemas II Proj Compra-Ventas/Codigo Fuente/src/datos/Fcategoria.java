package datos;

import database.Conexion;
import java.sql.*;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import negocio.Lcategoria;

/**
 *
 * @author huanc
 */
public class Fcategoria {

    //Atributos o variables de clase
    private Conexion objDB = new Conexion();
    private Connection cn = objDB.conectar();
    private String sSQL = "";

    public Integer totalregistros;

    //Metodos de clase
    //Mostrar
    public DefaultTableModel mostrar(String buscar) {
        DefaultTableModel modelo;
        String[] titulos = {"Id", "Nombre", "Descripción"};
        String[] registro = new String[3];
        totalregistros = 0;
        modelo = new DefaultTableModel(null, titulos);
        sSQL = "SELECT * FROM categoria WHERE nombre LIKE '" + buscar + "%' ORDER BY id DESC";
        try {
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sSQL);
            while (rs.next()) {
                registro[0] = rs.getString("id");
                registro[1] = rs.getString("nombre");
                registro[2] = rs.getString("descripcion");
                totalregistros++;
                modelo.addRow(registro);

            }
            return modelo;

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }

    }
    //Buscar

    public DefaultTableModel buscar(String buscar, String campo) {
        DefaultTableModel modelo;
        String[] titulos = {"Id", "Nombre", "Descripción"};
        String[] registro = new String[3];
        totalregistros = 0;
        modelo = new DefaultTableModel(null, titulos);
        sSQL = "SELECT * FROM categoria WHERE "+ campo +" LIKE '" + buscar + "%' ORDER BY id DESC";
        try {
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sSQL);
            while (rs.next()) {
                registro[0] = rs.getString("id");
                registro[1] = rs.getString("nombre");
                registro[2] = rs.getString("descripcion");
                totalregistros++;
                modelo.addRow(registro);

            }
            return modelo;

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }

    }

    public boolean insertar(Lcategoria dts) {
        sSQL = "INSERT INTO categoria(nombre,descripcion) VALUES (?,?)";
        try {
            PreparedStatement ps = cn.prepareStatement(sSQL);
            ps.setString(1, dts.getNombre());
            ps.setString(2, dts.getDescripcion());

            int n = ps.executeUpdate();
            if (n != 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
            return false;
        }
    }

    public boolean actualizar(Lcategoria dts) {
        sSQL = "UPDATE categoria SET nombre=?, descripcion=? WHERE id=?";
        try {
            PreparedStatement ps = cn.prepareStatement(sSQL);
            ps.setString(1, dts.getNombre());
            ps.setString(2, dts.getDescripcion());
            ps.setInt(3, dts.getId());

            int n = ps.executeUpdate();
            if (n != 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
            return false;
        }
    }

    public boolean eliminar(Lcategoria dts) {
        sSQL = "DELETE FROM categoria WHERE id=?";
        try {
            PreparedStatement ps = cn.prepareStatement(sSQL);
            ps.setInt(1, dts.getId());

            int n = ps.executeUpdate();
            if (n != 0) {
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            JOptionPane.showConfirmDialog(null, e);
            return false;
        }
    }

    public int existe(String nombred){
        
        sSQL="SELECT COUNT(idempleado) FROM categoria WHERE nombre=?";
        try {
            PreparedStatement ps=cn.prepareStatement(sSQL);
            ps.setString(1, nombred);
            ResultSet rs=ps.executeQuery();
              if(rs.next()){
                   totalregistros++;
                   return rs.getInt(1);
              }
              return 1;
        } catch (Exception e) {
        return 1;
        }
    }
    
    
    /*public boolean existe(String texto){
    boolean resp=false;
    sSQL="SELECT nombre FROM categoria WHERE nombre=?";
    
    
    
    
    return resp;
    }*/
    
//Final    
}
