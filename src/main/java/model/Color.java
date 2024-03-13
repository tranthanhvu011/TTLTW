package model;

public class Color {
    static Color instance;
    static Color getInstance(){
        if(instance==null){
            new Color();
        }
            return instance;

    }
    private int id;
    private String name;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }



    @Override
    public String toString() {
        return "Color{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
