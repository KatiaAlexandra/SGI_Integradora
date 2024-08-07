package mx.edu.utez.sgi.entities;

public class Building {
    private long building_ID; // Asegúrate de usar "building_ID" en lugar de "Building_ID" si hay problemas de capitalización
    private String building_name;

    public Building() {
    }

    public Building(long building_ID, String building_name) {
        this.building_ID = building_ID;
        this.building_name = building_name;
    }

    public Building(long building_ID) {
        this.building_ID = building_ID;
    }

    public long getBuilding_ID() {
        return building_ID;
    }

    public void setBuilding_ID(long building_ID) {
        this.building_ID = building_ID;
    }

    public String getBuilding_name() {
        return building_name;
    }

    public void setBuilding_name(String building_name) {
        this.building_name = building_name;
    }
}