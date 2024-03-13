package modelDB;

public class ProductDB {
    private int id;

    private String name;

    private int manufacturer_id;

    private int specification_id;

    private int info_warranty_id;

    private int sell_quantity;

    private double price;

    private int remaning_quantity;

    private String thumbnail_url;

    private String description;


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

    public int getManufacturer_id() {
        return manufacturer_id;
    }

    public void setManufacturer_id(int manufacturer_id) {
        this.manufacturer_id = manufacturer_id;
    }

    public int getSpecification_id() {
        return specification_id;
    }

    public void setSpecification_id(int specification_id) {
        this.specification_id = specification_id;
    }

    public int getInfo_warranty_id() {
        return info_warranty_id;
    }

    public void setInfo_warranty_id(int info_warranty_id) {
        this.info_warranty_id = info_warranty_id;
    }

    public int getSell_quantity() {
        return sell_quantity;
    }

    public void setSell_quantity(int sell_quantity) {
        this.sell_quantity = sell_quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getRemaning_quantity() {
        return remaning_quantity;
    }

    public void setRemaning_quantity(int remaning_quantity) {
        this.remaning_quantity = remaning_quantity;
    }

    public String getThumbnail_url() {
        return thumbnail_url;
    }

    public void setThumbnail_url(String thumbnail_url) {
        this.thumbnail_url = thumbnail_url;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public static ProductDB mapDataToObject(int id,String name, int manufacturer_id, int sell_quantity,
                                     int remain_quantity, double price, String description,
                                     int info_warranty_id) {
        ProductDB productDB = new ProductDB();
        productDB.setId(id);
        productDB.setName(name);
        productDB.setManufacturer_id(manufacturer_id);
        productDB.setSell_quantity(sell_quantity);
        productDB.setRemaning_quantity(remain_quantity);
        productDB.setPrice(price);
        productDB.setDescription(description);
        productDB.setInfo_warranty_id(info_warranty_id);
        return productDB;
    }
}
