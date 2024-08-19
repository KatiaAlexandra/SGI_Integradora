package mx.edu.utez.sgi.entities;

public class Manager {
    private Long Manager_ID;
    private String Manager_Status;
    private String First_Name;
    private String Second_Name;
    private String First_Lastname;
    private String Second_Lastname;
    private Long Employee_Num;
    private String Custody_date;

    public Manager(){
    }

    public Manager(Long manager_ID, String manager_Status, String first_Name, String second_Name, String first_Lastname, String second_Lastname, Long employee_Num, String custody_date) {
        this.Manager_ID = manager_ID;
        this.Manager_Status = manager_Status;
        this.First_Name = first_Name;
        this.Second_Name = second_Name;
        this.First_Lastname = first_Lastname;
        this.Second_Lastname = second_Lastname;
        this.Employee_Num = employee_Num;
        this.Custody_date = custody_date;
    }

    public Manager(String manager_Status, String first_Name, String second_Name, String first_Lastname, String second_Lastname, Long employee_Num, String custody_date) {
        this.Manager_Status = manager_Status;
        this.First_Name = first_Name;
        this.Second_Name = second_Name;
        this.First_Lastname = first_Lastname;
        this.Second_Lastname = second_Lastname;
        this.Employee_Num = employee_Num;
        this.Custody_date = custody_date;
    }

    public String getCustody_date() {
        return Custody_date;
    }

    public void setCustody_date(String custody_date) {
        Custody_date = custody_date;
    }

    public Long getEmployee_Num() {
        return Employee_Num;
    }

    public void setEmployee_Num(Long employee_Num) {
        Employee_Num = employee_Num;
    }

    public String getSecond_Lastname() {
        return Second_Lastname;
    }

    public void setSecond_Lastname(String second_Lastname) {
        Second_Lastname = second_Lastname;
    }

    public String getFirst_Lastname() {
        return First_Lastname;
    }

    public void setFirst_Lastname(String first_Lastname) {
        First_Lastname = first_Lastname;
    }

    public String getSecond_Name() {
        return Second_Name;
    }

    public void setSecond_Name(String second_Name) {
        Second_Name = second_Name;
    }

    public String getFirst_Name() {
        return First_Name;
    }

    public void setFirst_Name(String first_Name) {
        First_Name = first_Name;
    }

    public String getManager_Status() {
        return Manager_Status;
    }

    public void setManager_Status(String manager_Status) {
        Manager_Status = manager_Status;
    }

    public Long getManager_ID() {
        return Manager_ID;
    }

    public void setManager_ID(Long manager_ID) {
        Manager_ID = manager_ID;
    }
}
