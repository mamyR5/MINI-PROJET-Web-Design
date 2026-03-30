package webdesign.model;

public class Categorie {
    
    private int id;
    private String designation;
    private String couleurFond;
    private String couleurTexte;



    // Constructeur vide
    public Categorie() {}

    // Constructeur complet
    public Categorie(int id, String designation) {
        this.id = id;
        this.designation = designation;
    }

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }
    public String getCouleurFond() {
       return couleurFond;
    }

    public void setCouleurFond(String couleurFond) {
        this.couleurFond = couleurFond;
    }
        public String getCouleurTexte() {
        return couleurTexte;
    }

    public void setCouleurTexte(String couleurTexte) {
        this.couleurTexte = couleurTexte;
    }
}

