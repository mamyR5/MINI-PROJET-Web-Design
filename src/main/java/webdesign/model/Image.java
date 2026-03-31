package webdesign.model;

public class Image {

    private int id;
    private String fichier;
    private String alt;
    private int idArticle;

    // Constructeur vide
    public Image() {
    }

    // Constructeur complet
    public Image(int id, String fichier, String alt, int idArticle) {
        this.id = id;
        this.fichier = fichier;
        this.alt = alt;
        this.idArticle = idArticle;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFichier() {
        return fichier;
    }

    public void setFichier(String fichier) {
        this.fichier = fichier;
    }

    public String getAlt() {
        return alt;
    }

    public void setAlt(String alt) {
        this.alt = alt;
    }

    public int getIdArticle() {
        return idArticle;
    }

    public void setIdArticle(int idArticle) {
        this.idArticle = idArticle;
    }
}
