package webdesign.model;

import java.sql.Timestamp;

public class Article {
    private int id;
    private String titre;
    private String contenu;
    private Timestamp datePublication;
    private Categorie categorie;
    private int idUtilisateur;

    // Constructeur vide
    public Article() {}

    // Constructeur complet
    public Article(int id, String titre, String contenu, 
                   Timestamp datePublication, Categorie categorie, int idUtilisateur) {
        this.id = id;
        this.titre = titre;
        this.contenu = contenu;
        this.datePublication = datePublication;
        this.categorie = categorie;
        this.idUtilisateur = idUtilisateur;
    }

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getContenu() { return contenu; }
    public void setContenu(String contenu) { this.contenu = contenu; }

    public Timestamp getDatePublication() { return datePublication; }
    public void setDatePublication(Timestamp datePublication) { 
        this.datePublication = datePublication; 
    }

    public Categorie getCategorie() { return categorie; }
    public void setCategorie(Categorie categorie) { this.categorie = categorie; }

    public int getIdUtilisateur() { return idUtilisateur; }
    public void setIdUtilisateur(int idUtilisateur) { this.idUtilisateur = idUtilisateur; }
}