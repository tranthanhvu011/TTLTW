package model;

import java.util.List;

public class ProductVariant {

    private int id;
    private String name;
    private double price;
    private Product product;
    private List<ProductImage> productImages;
    private Color color;
    private Capacity capacity;
    private int colorId;
    private int capacityId;
    private String nameCapacity;
    private String nameColor;
    private String nameProduct;

    public String getNameCapacity() {
        return nameCapacity;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public void setNameCapacity(String nameCapacity) {
        this.nameCapacity = nameCapacity;
    }

    public String getNameColor() {
        return nameColor;
    }

    public void setNameColor(String nameColor) {
        this.nameColor = nameColor;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public int getCapacityId() {
        return capacityId;
    }

    public void setCapacityId(int capacityId) {
        this.capacityId = capacityId;
    }

    private int state;


    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public List<ProductImage> getProductImages() {
        return productImages;
    }

    public void setProductImages(List<ProductImage> productImages) {
        this.productImages = productImages;
    }

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public Capacity getCapacity() {
        return capacity;
    }

    @Override
    public String toString() {
        return "ProductVariant{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", product=" + product +
                ", productImages=" + productImages +
                ", color=" + color +
                ", capacity=" + capacity +
                ", colorId=" + colorId +
                ", capacityId=" + capacityId +
                ", nameCapacity='" + nameCapacity + '\'' +
                ", nameColor='" + nameColor + '\'' +
                ", nameProduct='" + nameProduct + '\'' +
                ", state=" + state +
                '}';
    }

    public void setCapacity(Capacity capacity) {
        this.capacity = capacity;


    }

    public void setFirstImageUrl(String firstImageUrl) {
    }
}
