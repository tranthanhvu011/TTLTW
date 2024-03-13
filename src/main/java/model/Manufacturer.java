package model;

public class Manufacturer {
    private int id;
    private String NAME;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNAME() {
        return NAME;
    }

    public void setNAME(String NAME) {
        this.NAME = NAME;
    }

    @Override
    public String toString() {
        return "Manufacturer{" +
                "id=" + id +
                ", NAME='" + NAME + '\'' +
                '}';
    }
}