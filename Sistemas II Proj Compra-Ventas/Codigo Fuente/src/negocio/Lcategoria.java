
package negocio;

/**
 *
 * @author huanc
 */
public class Lcategoria {
    private int id;
    private String nombre;
    private String descripcion;
    

//Metodos de la clase

    public Lcategoria() {
    }

    public Lcategoria(int id, String nombre, String descripcion, boolean habil) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

   
}

