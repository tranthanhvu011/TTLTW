package model;

public class NhapHang {
    int id;
    int idKho;
    int idChiNhanh;
    String tenNguoiDaiDien;

    public NhapHang() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdKho() {
        return idKho;
    }

    public void setIdKho(int idKho) {
        this.idKho = idKho;
    }

    public int getIdChiNhanh() {
        return idChiNhanh;
    }

    public void setIdChiNhanh(int idChiNhanh) {
        this.idChiNhanh = idChiNhanh;
    }

    public String getTenNguoiDaiDien() {
        return tenNguoiDaiDien;
    }

    public void setTenNguoiDaiDien(String tenNguoiDaiDien) {
        this.tenNguoiDaiDien = tenNguoiDaiDien;
    }

    @Override
    public String toString() {
        return "NhapHang{" +
                "id=" + id +
                ", idKho=" + idKho +
                ", idChiNhanh=" + idChiNhanh +
                ", tenNguoiDaiDien='" + tenNguoiDaiDien + '\'' +
                '}';
    }
}
