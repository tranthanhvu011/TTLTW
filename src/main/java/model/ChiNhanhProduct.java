package model;

public class ChiNhanhProduct {
    int idChiNhanh;
    int idProductVariant;
    int quantityProductVariant;
    double priceOneProductVariant;
    double getPriceAllProductVariant;

    public ChiNhanhProduct() {
    }

    public ChiNhanhProduct(int idChiNhanh, int idProductVariant, int quantityProductVariant, double priceOneProductVariant, double getPriceAllProductVariant) {
        this.idChiNhanh = idChiNhanh;
        this.idProductVariant = idProductVariant;
        this.quantityProductVariant = quantityProductVariant;
        this.priceOneProductVariant = priceOneProductVariant;
        this.getPriceAllProductVariant = getPriceAllProductVariant;
    }

    public int getIdChiNhanh() {
        return idChiNhanh;
    }

    public void setIdChiNhanh(int idChiNhanh) {
        this.idChiNhanh = idChiNhanh;
    }

    public int getIdProductVariant() {
        return idProductVariant;
    }

    public void setIdProductVariant(int idProductVariant) {
        this.idProductVariant = idProductVariant;
    }

    public int getQuantityProductVariant() {
        return quantityProductVariant;
    }

    public void setQuantityProductVariant(int quantityProductVariant) {
        this.quantityProductVariant = quantityProductVariant;
    }

    public double getPriceOneProductVariant() {
        return priceOneProductVariant;
    }

    public void setPriceOneProductVariant(double priceOneProductVariant) {
        this.priceOneProductVariant = priceOneProductVariant;
    }

    public double getGetPriceAllProductVariant() {
        return getPriceAllProductVariant;
    }

    public void setGetPriceAllProductVariant(double getPriceAllProductVariant) {
        this.getPriceAllProductVariant = getPriceAllProductVariant;
    }

    @Override
    public String toString() {
        return "ChiNhanhProduct{" +
                "idChiNhanh=" + idChiNhanh +
                ", idProductVariant=" + idProductVariant +
                ", quantityProductVariant=" + quantityProductVariant +
                ", priceOneProductVariant=" + priceOneProductVariant +
                ", getPriceAllProductVariant=" + getPriceAllProductVariant +
                '}';
    }
}
