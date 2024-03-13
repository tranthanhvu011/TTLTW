package service;

import dao.ProductDeltailDAO;
import model.ProductVariant;

import java.util.ArrayList;
import java.util.List;

public class ProductDetalService {
    private ProductDeltailDAO productDetailDAO = new ProductDeltailDAO();

    public static List<ProductVariant> getAllProductVariant(int productId) {
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
        List<ProductVariant> listProductVariant = productDeltailDAO.getAllProductVariant(productId);
        return listProductVariant;
    }
    public ProductVariant getProductVariantByColorAndCapacity(int productId, int colorId, int capacityId) {
        return productDetailDAO.getProductVariantByColorAndCapacity(productId, colorId, capacityId);
    }
    public static void main(String[] args) {
        List<ProductVariant> productVariants = ProductDetalService.getAllProductVariant(2);
        System.out.println(productVariants);
    }
}
