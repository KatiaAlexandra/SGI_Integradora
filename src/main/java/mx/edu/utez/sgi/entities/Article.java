package mx.edu.utez.sgi.entities;

public class Article {
    private long article_id;
    private String inventory_number;
    private String article_name;
    private String brand_model;
    private String serial_num;
    private String specifications;
    private Manager manager;
    private Classroom classroom;

    public Article() {
    }

    public Article(long article_id,String inventory_number,String article_name,String brand_model,String serial_num,String specifications,Manager manager, Classroom classroom){
        this.article_id= article_id;
        this.inventory_number= inventory_number;
        this.article_name=article_name;
        this.brand_model=brand_model;
        this.serial_num=serial_num;
        this.specifications=specifications;
        this.manager = manager;
        this.classroom=classroom;
    }

    public Article(String inventory_number, String article_name, String brand_model, String serial_num, String specifications, Manager manager, Classroom classroom) {
        this.inventory_number = inventory_number;
        this.article_name = article_name;
        this.brand_model = brand_model;
        this.serial_num = serial_num;
        this.specifications = specifications;
        this.manager = manager;
        this.classroom = classroom;
    }

    public Article(long article_id) {
        this.article_id = article_id;
    }

    public long getArticle_id() {
        return article_id;
    }

    public void setArticle_id(long article_id) {
        this.article_id = article_id;
    }

    public String getInventory_number() {
        return inventory_number;
    }

    public void setInventory_number(String inventory_number) {
        this.inventory_number = inventory_number;
    }

    public String getArticle_name() {
        return article_name;
    }

    public void setArticle_name(String article_name) {
        this.article_name = article_name;
    }

    public String getBrand_model() {
        return brand_model;
    }

    public void setBrand_model(String brand_model) {
        this.brand_model = brand_model;
    }

    public String getSerial_num() {
        return serial_num;
    }

    public void setSerial_num(String serial_num) {
        this.serial_num = serial_num;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public Manager getManager() {  // Corregido para devolver un objeto Manager
        return manager;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }

    public Classroom getClassroom() {  // Corregido para devolver un objeto Classroom
        return classroom;
    }

    public void setClassroom(Classroom classroom) {
        this.classroom = classroom;
    }
}