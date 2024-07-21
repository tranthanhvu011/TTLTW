package model;

public class ChiNhanhAndProduct {
    private String nameProduct;
    private String nameColor;
    private String nameCapacity;
    private int quantityProduct;
    private String nameChiNhanh;
    private String diaChiChiNhanh;

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public String getNameColor() {
        return nameColor;
    }

    public void setNameColor(String nameColor) {
        this.nameColor = nameColor;
    }

    public String getNameCapacity() {
        return nameCapacity;
    }

    public void setNameCapacity(String nameCapacity) {
        this.nameCapacity = nameCapacity;
    }

    public int getQuantityProduct() {
        return quantityProduct;
    }

    public void setQuantityProduct(int quantityProduct) {
        this.quantityProduct = quantityProduct;
    }

    public String getNameChiNhanh() {
        return nameChiNhanh;
    }

    public void setNameChiNhanh(String nameChiNhanh) {
        this.nameChiNhanh = nameChiNhanh;
    }

    public String getDiaChiChiNhanh() {
        return diaChiChiNhanh;
    }

    public void setDiaChiChiNhanh(String diaChiChiNhanh) {
        this.diaChiChiNhanh = diaChiChiNhanh;
    }

    @Override
    public String toString() {
        return "ChiNhanhAndProduct{" +
                "nameProduct='" + nameProduct + '\'' +
                ", nameColor='" + nameColor + '\'' +
                ", nameCapacity='" + nameCapacity + '\'' +
                ", quantityProduct=" + quantityProduct +
                ", nameChiNhanh='" + nameChiNhanh + '\'' +
                ", diaChiChiNhanh='" + diaChiChiNhanh + '\'' +
                '}';
    }
}
