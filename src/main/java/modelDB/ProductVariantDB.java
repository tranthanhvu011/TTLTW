package modelDB;

public class ProductVariantDB {
    private int id;

    private double price;

    private int color_id;

    private int capacity_id;

    private int state;

    private int product_id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getColor_id() {
        return color_id;
    }

    public void setColor_id(int color_id) {
        this.color_id = color_id;
    }

    public int getCapacity_id() {
        return capacity_id;
    }

    public void setCapacity_id(int capacity_id) {
        this.capacity_id = capacity_id;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    @Override
    public String toString() {
        return "ProductVariantDB{" +
                "id=" + id +
                ", price=" + price +
                ", color_id=" + color_id +
                ", capacity_id=" + capacity_id +
                ", state=" + state +
                ", product_id=" + product_id +
                '}';
    }
}

