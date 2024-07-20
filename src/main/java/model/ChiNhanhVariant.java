package model;

public class ChiNhanhVariant {
    int id;
    int idchinhanh;
    int idproductvariant;
    int quantity;
    int idkho;

    public ChiNhanhVariant(int id, int idchinhanh, int idproductvariant, int quantity, int idkho) {
        this.id = id;
        this.idchinhanh = idchinhanh;
        this.idproductvariant = idproductvariant;
        this.quantity = quantity;
        this.idkho = idkho;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdchinhanh() {
        return idchinhanh;
    }

    public void setIdchinhanh(int idchinhanh) {
        this.idchinhanh = idchinhanh;
    }

    public int getIdproductvariant() {
        return idproductvariant;
    }

    public void setIdproductvariant(int idproductvariant) {
        this.idproductvariant = idproductvariant;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getIdkho() {
        return idkho;
    }

    public void setIdkho(int idkho) {
        this.idkho = idkho;
    }

    @Override
    public String toString() {
        return "ChiNhanhVariant{" +
                "id=" + id +
                ", idchinhanh=" + idchinhanh +
                ", idproductvariant=" + idproductvariant +
                ", quantity=" + quantity +
                ", idkho=" + idkho +
                '}';
    }
}
