package model;

import java.sql.Timestamp;
import java.util.Date;

import java.sql.Timestamp;

public class NhapHangProductVariant {
    private int id;
    private int idnhaphang;
    private int idkho;
    private int idProductVariant;
    private int quantityProduct;
    private double priceOneProduct;
    private double priceAllProduct;
    private Timestamp ngayNhapHang;

    public NhapHangProductVariant() {
    }

    public NhapHangProductVariant(int id, int idnhaphang, int idkho, int idProductVariant, int quantityProduct, double priceOneProduct, double priceAllProduct, Timestamp ngayNhapHang) {
        this.id = id;
        this.idnhaphang = idnhaphang;
        this.idkho = idkho;
        this.idProductVariant = idProductVariant;
        this.quantityProduct = quantityProduct;
        this.priceOneProduct = priceOneProduct;
        this.priceAllProduct = priceAllProduct;
        this.ngayNhapHang = ngayNhapHang;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdnhaphang() {
        return idnhaphang;
    }

    public void setIdnhaphang(int idnhaphang) {
        this.idnhaphang = idnhaphang;
    }

    public int getIdkho() {
        return idkho;
    }

    public void setIdkho(int idkho) {
        this.idkho = idkho;
    }

    public int getIdProductVariant() {
        return idProductVariant;
    }

    public void setIdProductVariant(int idProductVariant) {
        this.idProductVariant = idProductVariant;
    }

    public int getQuantityProduct() {
        return quantityProduct;
    }

    public void setQuantityProduct(int quantityProduct) {
        this.quantityProduct = quantityProduct;
    }

    public double getPriceOneProduct() {
        return priceOneProduct;
    }

    public void setPriceOneProduct(double priceOneProduct) {
        this.priceOneProduct = priceOneProduct;
    }

    public double getPriceAllProduct() {
        return priceAllProduct;
    }

    public void setPriceAllProduct(double priceAllProduct) {
        this.priceAllProduct = priceAllProduct;
    }

    public Timestamp getNgayNhapHang() {
        return ngayNhapHang;
    }

    public void setNgayNhapHang(Timestamp ngayNhapHang) {
        this.ngayNhapHang = ngayNhapHang;
    }

    @Override
    public String toString() {
        return "NhapHangProductVariant{" +
                "id=" + id +
                ", idnhaphang=" + idnhaphang +
                ", idkho=" + idkho +
                ", idProductVariant=" + idProductVariant +
                ", quantity=" + quantityProduct +
                ", priceOneProduct=" + priceOneProduct +
                ", priceAllProduct=" + priceAllProduct +
                ", ngayNhapHang=" + ngayNhapHang +
                '}';
    }
}
