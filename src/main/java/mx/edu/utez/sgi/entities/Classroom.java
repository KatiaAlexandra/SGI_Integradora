package mx.edu.utez.sgi.entities;

public class Classroom {
    private long classroom_id;
    private String classroom_name;
    private Building building;

    public Classroom() {
    }

    public Classroom(long classroom_id, String classroom_name, Building building) {
        this.classroom_id = classroom_id;
        this.classroom_name = classroom_name;
        this.building = building;
    }

    public long getClassroom_id() {
        return classroom_id;
    }

    public void setClassroom_id(long classroom_id) {
        this.classroom_id = classroom_id;
    }

    public String getClassroom_name() {
        return classroom_name;
    }

    public void setClassroom_name(String classroom_name) {
        this.classroom_name = classroom_name;
    }

    public Building getBuilding() {
        return building;
    }

    public void setBuilding(Building building) {
        this.building = building;
    }
}