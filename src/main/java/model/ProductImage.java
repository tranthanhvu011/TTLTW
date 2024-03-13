package model;

public class ProductImage {

    private int id;
    private int product_variant_id;
    private String image_url;
    private String image_index0;
    public int getId() {
        return id;
    }
    private String firstImageUrl; // Thêm field mới



    public void setId(int id) {
        this.id = id;
    }

    public int getProduct_variant_id() {
        return product_variant_id;
    }

    public void setProduct_variant_id(int product_variant_id) {

        this.product_variant_id = product_variant_id;
    }

    public String getImage_url() {
        return image_url;
    }


    @Override
    public String toString() {
        return "ProductImage{" +
                "id=" + id +
                ", product_variant_id=" + product_variant_id +
                ", image_url='" + image_url + '\'' +
                '}';
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;


    }

}
