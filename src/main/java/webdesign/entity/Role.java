package webdesign.entity;

public class Role {
    private int id;
    private String designation;

    public Role(int id,String designation) {
        this.designation = designation;
        this.id = id;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }


}
