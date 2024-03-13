package service;

import dao.*;
import model.*;
import modelDB.ProductDB;

import javax.inject.Inject;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    @Inject
    private ProductDAO productDAO;
    @Inject
    private ManufacturerDAO manufacturerDAO;
    @Inject
    private WarrantyDAO warrantyDAO;
    @Inject
    private SpecificationDAO specificationDAO;
    @Inject
    private DiscountDAO discountDAO;
    @Inject
    private RateDAO rateDAO;
    @Inject
    private DiscountProductDAO discountProductDAO;
    @Inject
    private ProductVariantDAO productVariantDAO;


    public Product findDetailProductById(int productId) {
        ProductDB productDB = productDAO.findProductById(productId);
        Product product = new Product();
        product.setId(productDB.getId());
        product.setName(productDB.getName());
        Manufacturer manufacturer = manufacturerDAO.findManufacturerById(productDB.getManufacturer_id());
        if (manufacturer == null) {
            manufacturer = new Manufacturer();
        }
        product.setManufacturer(manufacturer);
        product.setSellQuantity(productDB.getSell_quantity());
        product.setRemaningQuantity(productDB.getRemaning_quantity());
        product.setThumbnailURL(productDB.getThumbnail_url());
        product.setPrice(productDB.getPrice());
        product.setDescription(productDB.getDescription());
        InfoWarranty warranty = warrantyDAO.findWarrantyById(productDB.getInfo_warranty_id());
        if (warranty == null) {
            warranty = new InfoWarranty();
        }
        product.setInfoWarranty(warranty);
        Specification specification = specificationDAO.findSpecificationBytId(productDB.getSpecification_id());
        if (specification == null) {
            specification = new Specification();
        }
        product.setSpecification(specification);

        List<Discount> discounts = discountDAO.getDiscountsByProductId(productDB.getId());
        if (discounts == null) {
            discounts = new ArrayList<>();
        }
        product.setDiscounts(discounts);
        return product;
    }


    public List<Product> findAllProductForHomePage() {
        List<Product> products = new ArrayList<>();
        List<ProductDB> allProduct = productDAO.findAllProduct();
        for (ProductDB productDB : allProduct) {
            Product product = new Product();
            product.setId(productDB.getId());
            product.setName(productDB.getName());
            Manufacturer manufacturer = manufacturerDAO.findManufacturerById(productDB.getManufacturer_id());
            if (manufacturer == null) {
                manufacturer = new Manufacturer();
            }
            product.setManufacturer(manufacturer);
            product.setSellQuantity(productDB.getSell_quantity());
            product.setRemaningQuantity(productDB.getRemaning_quantity());
            product.setThumbnailURL(productDB.getThumbnail_url());
            product.setPrice(productDB.getPrice());
            List<Discount> discounts = discountDAO.getDiscountsByProductId(productDB.getId());
            if (discounts == null) {
                discounts = new ArrayList<>();
            }
            product.setDiscounts(discounts);
            products.add(product);
        }
        return products;
    }


    public Product findProductForManageProductPageById(int productId) {
        Product product = new Product();
        ProductDB productDB = productDAO.findProductForManageProductPageById(productId);
        product.setId(productDB.getId());
        product.setName(productDB.getName());
        Manufacturer manufacturer = manufacturerDAO.findManufacturerById(productDB.getManufacturer_id());
        if (manufacturer == null) {
            manufacturer = new Manufacturer();
        }
        product.setManufacturer(manufacturer);
        product.setSellQuantity(productDB.getSell_quantity());
        product.setRemaningQuantity(productDB.getRemaning_quantity());
        return product;
    }


    public Integer addProduct(ProductDB productDB) {
        return productDAO.addProduct(productDB);
    }

    public String updateProduct(ProductDB productDB) {
        String code = null;
        try {
            int rowUpdate = productDAO.update(productDB);
            if (rowUpdate > 0)
                code = "OK";
            else
                code = "FAIL";
        } catch (Exception e) {
            code = "ERROR";
            e.printStackTrace();
        }
        return code;
    }

    public List<Integer> findProductByIDWarranty(int id) {
        return productDAO.findProductByIDWarranty(id);
    }

    public void deleteProduct(Integer idP) {
        try {
            discountProductDAO.deleteDiscountProductByProductId(idP);
            rateDAO.deleteRateByProductId(idP);
            productVariantDAO.deleteProductVariantByProductId(idP);
        } catch (Exception e) {
            e.printStackTrace();
        }
        productDAO.deleteProduct(idP);
    }

    public List<Integer> findProductByIDManufacturer(int id) {
        return productDAO.findProductByIDManufacturer(id);
    }
}
