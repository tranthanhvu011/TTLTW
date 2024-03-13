package model;

import java.util.List;

public class Product {

    private int id;

    private String name;

    private Manufacturer manufacturer;

    private Specification specification;

    private InfoWarranty infoWarranty;

    private int sellQuantity;

    private double price;
    private double priceNew;

    private int remaningQuantity;

    private String thumbnailURL;

    private String description;

    private List<Discount> discounts;

    public List<Discount> getDiscounts() {
        return discounts;
    }

    public void setDiscounts(List<Discount> discounts) {
        this.discounts = discounts;
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

    public Manufacturer getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(Manufacturer manufacturer) {
        this.manufacturer = manufacturer;
    }

    public Specification getSpecification() {
        return specification;
    }

    public void setSpecification(Specification specification) {
        this.specification = specification;
    }

    public InfoWarranty getInfoWarranty() {
        return infoWarranty;
    }

    public void setInfoWarranty(InfoWarranty infoWarranty) {
        this.infoWarranty = infoWarranty;
    }

    public int getSellQuantity() {
        return sellQuantity;
    }

    public void setSellQuantity(int sellQuantity) {
        this.sellQuantity = sellQuantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getRemaningQuantity() {
        return remaningQuantity;
    }

    public void setRemaningQuantity(int remaningQuantity) {
        this.remaningQuantity = remaningQuantity;
    }

    public String getThumbnailURL() {
        return thumbnailURL;
    }

    public void setThumbnailURL(String thumbnailURL) {
        this.thumbnailURL = thumbnailURL;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPercentDiscount() {
        int percentDiscount = 0;
        if (!discounts.isEmpty()) {
            Discount discount = discounts.get(0);
            percentDiscount = (int) ((discount.getCost() / price) * 100);
        }
        return percentDiscount;
    }
    public double calculatePriceNew() {
        double priceAnd = price;
        if (!discounts.isEmpty()) {
            priceAnd -= discounts.get(0).getCost();
        }
        return priceAnd;
    }
    public double getPriceNew() {
        this.priceNew = calculatePriceNew();
        return priceNew;
    }

    public void setPriceNew(double priceNew) {
        this.priceNew = priceNew;
    }

    @Override
    public String toString() {

        StringBuilder discountString = new StringBuilder();
        if (discounts != null) {
            for (Discount discount : discounts) {
                discountString.append(discount.toString()).append("\n");
            }
        }
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", manufacturer=" + manufacturer +
//                ", specification=" + specification.toString() +
//                ", infoWarranty=" + infoWarranty.toString() +
                ", sellQuantity=" + sellQuantity +
                ", price=" + price +
//                ", remaningQuantity='" + remaningQuantity + '\'' +
                ", thumbnailURL='" + thumbnailURL + '\'' +
//                ", description='" + description + '\'' +
                ", discounts=" + discountString + '\'' +
                ", newPrice=" + priceNew + '\'' +
                '}';
    }


}
