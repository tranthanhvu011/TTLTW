package model;


public class ProductInventory {

    private int id;
    private int idKho;
    private int idProductVariant;
    private int quantityProductVariant;
    private double priceOneProductVariant;
    private double priceAllProductVariant;

    // Constructor with parameters
    public ProductInventory(int id, int idKho, int idProductVariant, int quantityProductVariant, double priceOneProductVariant, double priceAllProductVariant) {
        this.id = id;
        this.idKho = idKho;
        this.idProductVariant = idProductVariant;
        this.quantityProductVariant = quantityProductVariant;
        this.priceOneProductVariant = priceOneProductVariant;
        this.priceAllProductVariant = priceAllProductVariant;
    }

    // Default constructor
    public ProductInventory() {
    }

    // Getter and setter for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and setter for idKho
    public int getIdKho() {
        return idKho;
    }

    public void setIdKho(int idKho) {
        this.idKho = idKho;
    }

    // Getter and setter for idProductVariant
    public int getIdProductVariant() {
        return idProductVariant;
    }

    public void setIdProductVariant(int idProductVariant) {
        this.idProductVariant = idProductVariant;
    }

    // Getter and setter for quantityProductVariant
    public int getQuantityProductVariant() {
        return quantityProductVariant;
    }

    public void setQuantityProductVariant(int quantityProductVariant) {
        this.quantityProductVariant = quantityProductVariant;
    }

    // Getter and setter for priceOneProductVariant
    public double getPriceOneProductVariant() {
        return priceOneProductVariant;
    }

    public void setPriceOneProductVariant(double priceOneProductVariant) {
        this.priceOneProductVariant = priceOneProductVariant;
    }

    // Getter and setter for priceAllProductVariant
    public double getPriceAllProductVariant() {
        return priceAllProductVariant;
    }

    public void setPriceAllProductVariant(double priceAllProductVariant) {
        this.priceAllProductVariant = priceAllProductVariant;
    }

    @Override
    public String toString() {
        return "ProductInventory{" +
                "id=" + id +
                ", idKho=" + idKho +
                ", idProductVariant=" + idProductVariant +
                ", quantityProductVariant=" + quantityProductVariant +
                ", priceOneProductVariant=" + priceOneProductVariant +
                ", priceAllProductVariant=" + priceAllProductVariant +
                '}';
    }
}
