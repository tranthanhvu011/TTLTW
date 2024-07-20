package model;

public class KhoHang {
    int id;
    int  idProduct;
    String name;

    public KhoHang(int id, int idProduct, String name) {
        this.id = id;
        this.idProduct = idProduct;
        this.name = name;
    }

    public KhoHang() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "KhoHang{" +
                "id=" + id +
                ", idProduct=" + idProduct +
                ", name='" + name + '\'' +
                '}';
    }
}
