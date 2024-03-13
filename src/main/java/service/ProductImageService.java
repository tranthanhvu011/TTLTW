package service;

import dao.ProductImageDAO;
import model.ProductImage;

import javax.inject.Inject;
import java.util.List;

public class ProductImageService {

    @Inject
    private ProductImageDAO productImageDAO;

    public List<ProductImage> getAllProductImageByProductVariantId(int id) {
        return productImageDAO.getAllProductImageByProductVariantId(id);
    }

    public int addImages(Integer idProductVariant, List<String> images) {
        return productImageDAO.insert(idProductVariant,images);
    }

    public void deleteAllProductImageByProductVariantId(int idP) {
        productImageDAO.deleteAllProductImageByProductVariantId(idP);
    }
}
