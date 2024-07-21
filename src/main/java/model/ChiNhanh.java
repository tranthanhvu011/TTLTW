package model;

public class ChiNhanh {
    private int id;
    private String name;
    private String diaChiChiNhanh;
    private String sdtChiNhanh;
    private String emailChiNhanh;

    public ChiNhanh(int id, String name, String diaChiChiNhanh, String sdtChiNhanh, String emailChiNhanh) {
        this.id = id;
        this.name = name;
        this.diaChiChiNhanh = diaChiChiNhanh;
        this.sdtChiNhanh = sdtChiNhanh;
        this.emailChiNhanh = emailChiNhanh;
    }

    public ChiNhanh() {
    }

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

    public String getDiaChiChiNhanh() {
        return diaChiChiNhanh;
    }

    public void setDiaChiChiNhanh(String diaChiChiNhanh) {
        this.diaChiChiNhanh = diaChiChiNhanh;
    }

    public String getSdtChiNhanh() {
        return sdtChiNhanh;
    }

    public void setSdtChiNhanh(String sdtChiNhanh) {
        this.sdtChiNhanh = sdtChiNhanh;
    }

    public String getEmailChiNhanh() {
        return emailChiNhanh;
    }

    public void setEmailChiNhanh(String emailChiNhanh) {
        this.emailChiNhanh = emailChiNhanh;
    }

    @Override
    public String toString() {
        return "ChiNhanh{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", diaChiChiNhanh='" + diaChiChiNhanh + '\'' +
                ", sdtChiNhanh='" + sdtChiNhanh + '\'' +
                ", emailChiNhanh='" + emailChiNhanh + '\'' +
                '}';
    }
}
