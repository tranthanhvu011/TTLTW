package dao;

import config.JDBIConnector;
import model.ProductImage;
import service.ProductImageService;

import java.io.BufferedReader;
import java.util.List;

public class ProductImageDAO {
    public List<ProductImage> getAllProductImageByProductVariantId(int id) {
        List<ProductImage> productImages = JDBIConnector.me().withHandle(handle -> {
            return handle.createQuery("SELECT * FROM productimages WHERE product_variant_id = :id")
                    .bind("id", id)
                    .mapToBean(ProductImage.class)
                    .list();
        });
        return productImages.isEmpty() ? null : productImages;
    }

    public int insert(Integer idProductVariant, List<String> images) {
        String query = createQueryToInsertImage(idProductVariant, images);
        return JDBIConnector.me().withHandle(
                handle -> handle.createUpdate(query).execute()
        );
    }

    private String createQueryToInsertImage(int id, List<String> nameImages) {
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append("INSERT INTO ProductImages(product_variant_id,image_url) VALUES");
        for (int i = 0; i < nameImages.size(); i++) {
            stringBuffer.append("(").append(id).append(",").append("'").append(nameImages.get(i)).append("'),");
            if (i == nameImages.size() - 1)
                stringBuffer.append("(").append(id).append(",").append("'").append(nameImages.get(i)).append("');");
        }
        return stringBuffer.toString();
    }

    public void deleteAllProductImageByProductVariantId(int idP) {
        String query = "DELETE FROM ProductImages WHERE product_variant_id = ?";
        JDBIConnector.me().withHandle(handle -> {
            return handle.createUpdate(query).bind(0, idP).execute();
        });
    }
}
