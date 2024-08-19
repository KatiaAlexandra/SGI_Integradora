package mx.edu.utez.sgi.entities;

public class History {
    private String date_creation;
    private String inventory_number;
    private String article;
    private String type_transaction;
    private String Username;

    public History() {
    }

    public History(String date_creation, String inventory_number, String article, String type_transaction, String username) {
        this.date_creation = date_creation;
        this.inventory_number = inventory_number;
        this.article = article;
        this.type_transaction = type_transaction;
        this.Username = username;
    }

    public String getDate_creation() {
        return date_creation;
    }

    public void setDate_creation(String date_creation) {
        this.date_creation = date_creation;
    }

    public String getInventory_number() {
        return inventory_number;
    }

    public void setInventory_number(String inventory_number) {
        this.inventory_number = inventory_number;
    }

    public String getArticle() {
        return article;
    }

    public void setArticle(String article) {
        this.article = article;
    }

    public String getType_transaction() {
        return type_transaction;
    }

    public void setType_transaction(String type_transaction) {
        this.type_transaction = type_transaction;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }
}