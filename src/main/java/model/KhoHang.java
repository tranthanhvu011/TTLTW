package model;

public class KhoHang {
    int id;
    String nameKho ;
    String   diaChiKho ;
    String  sdtKho ;
    String emailKho;

    public KhoHang(int id, String nameKho, String diaChiKho, String sdtKho, String emailKho) {
        this.id = id;
        this.nameKho = nameKho;
        this.diaChiKho = diaChiKho;
        this.sdtKho = sdtKho;
        this.emailKho = emailKho;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameKho() {
        return nameKho;
    }

    public void setNameKho(String nameKho) {
        this.nameKho = nameKho;
    }

    public String getDiaChiKho() {
        return diaChiKho;
    }

    public void setDiaChiKho(String diaChiKho) {
        this.diaChiKho = diaChiKho;
    }

    public String getSdtKho() {
        return sdtKho;
    }

    public void setSdtKho(String sdtKho) {
        this.sdtKho = sdtKho;
    }

    public String getEmailKho() {
        return emailKho;
    }

    public void setEmailKho(String emailKho) {
        this.emailKho = emailKho;
    }

    @Override
    public String toString() {
        return "KhoHang{" +
                "id=" + id +
                ", nameKho='" + nameKho + '\'' +
                ", diaChiKho='" + diaChiKho + '\'' +
                ", sdtKho='" + sdtKho + '\'' +
                ", emailKho='" + emailKho + '\'' +
                '}';
    }

    public KhoHang() {
    }
}
