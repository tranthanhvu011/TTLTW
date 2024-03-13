package service;

import config.JDBIConnector;
import dao.CapacityDAO;
import dao.ColorDAO;
import dao.ProductVariantDAO;
import model.*;
import modelDB.ProductVariantDB;

import javax.inject.Inject;
import javax.swing.text.html.Option;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductVariantService {

    @Inject
    private ProductVariantDAO productVariantDAO;
    @Inject
    private ColorDAO colorDAO;
    @Inject
    private ProductService productService;
    @Inject
    private CapacityDAO capacityDAO;
    @Inject
    private ProductImageService productImageService;
    @Inject
    private OrderProductVariantService orderProductVariantService;



    public List<ProductVariant> getAllProductVariant(int limit, int offset) {
        List<ProductVariantDB> productVariantDBs = productVariantDAO.getAllProductVariant(limit,offset);
        return mapFromListDBToListObject(productVariantDBs);
    }

    public boolean deleteProductVariant(int idP) {
        try {
            productImageService.deleteAllProductImageByProductVariantId(idP);
            orderProductVariantService.deleteOrderProductVariantByProductVariantId(idP);
        } catch (Exception e) {
            return false;
        }
        return productVariantDAO.deleteProductVariant(idP);
    }

    public List<ProductVariant> searchProductVariant(String keyword) {
        List<ProductVariantDB> productVariantDBs = productVariantDAO.findProductVariantByKeyword(keyword);
        return mapFromListDBToListObject(productVariantDBs);
    }

    public List<ProductVariant> mapFromListDBToListObject(List<ProductVariantDB> productVariantDBs) {
        List<ProductVariant> productVariants = new ArrayList<>();
        for (ProductVariantDB productVariantDB : productVariantDBs) {
            ProductVariant productVariant = mapFromDBToObject(productVariantDB);
            Product product = productService.findProductForManageProductPageById(productVariantDB.getProduct_id());
            if (product == null) {
                product = new Product();
            }
            productVariant.setProduct(product);
            productVariants.add(productVariant);
        }
        return productVariants;
    }


    public ProductVariant findProductVariantById(int id) {
        ProductVariantDB productVariantDB = productVariantDAO.findProductVariantById(id);
        ProductVariant productVariant = mapFromDBToObject(productVariantDB);
        Product product = productService.findDetailProductById(productVariantDB.getProduct_id());
        if (product == null) {
            product = new Product();
        }
        productVariant.setProduct(product);

        return productVariant;
    }
    public ProductVariant findProduct(int id){
        ProductVariantDB productVariantDB = ProductVariantDAO.getInstance().findProductVariantById(id);
        ProductVariant productVariant = mapFromDBToObject(productVariantDB);
        Product product = productService.findDetailProductById(productVariantDB.getProduct_id());
        if (product == null) {
            product = new Product();
        }
        productVariant.setProduct(product);

        return productVariant;
    }
    public ProductVariant mapFromDBToObject(ProductVariantDB productVariantDB) {
        ProductVariant productVariant = new ProductVariant();
        productVariant.setId(productVariantDB.getId());
        productVariant.setPrice(productVariantDB.getPrice());
        productVariant.setState(productVariantDB.getState());
        Color color = colorDAO.findColorById(productVariantDB.getColor_id());
        if (color == null) {
            color = new Color();
        }
        productVariant.setColor(color);
        Capacity capacity = capacityDAO.findCapacityById(productVariantDB.getCapacity_id());
        if (capacity == null) {
            capacity = new Capacity();
        }
        productVariant.setCapacity(capacity);
        List<ProductImage> productImages = productImageService.getAllProductImageByProductVariantId(productVariantDB.getId());
        if (productImages == null) {
            productImages = new ArrayList<>();
        }
        productVariant.setProductImages(productImages);
        return productVariant;
    }

    public Integer addProductVariant(ProductVariantDB productVariantDB) {
        return productVariantDAO.addProductVariant(productVariantDB);
    }

    public List<ProductVariant> getAllProductVariantByIdProduct(int idProduct) {
        List<ProductVariantDB> productVariantDBS = productVariantDAO.getAllProductVariantByIdProduct(idProduct);
        List<ProductVariant> productVariants = new ArrayList<>();
        if (productVariantDBS != null) {
            for (ProductVariantDB productVariantDB : productVariantDBS) {
                ProductVariant productVariant = mapFromDBToObject(productVariantDB);
                productVariants.add(productVariant);
            }
        }
        return productVariants.isEmpty() ? null : productVariants;
    }

    public int update(ProductVariantDB productVariantDB) {
       return productVariantDAO.update(productVariantDB);
    }

    public List<Integer> findProductVariantByCapacityId(int id) {
        return productVariantDAO.findProductVariantByCapacityId(id);
    }

    public List<Integer> findProductVariantByColorId(int id) {
        return productVariantDAO.findProductVariantByColorId(id);
    }

    public int countNumberPage() {
        return productVariantDAO.countNumberPage();
    }
}
