package dao;

import config.JDBIConnector;
import model.*;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDeltailDAO {
    private static final Jdbi jdbi = JDBIConnector.me();



    public static List<ProductVariant> getAllProductVariant(int productId) {
        return jdbi.withHandle(handle -> {
            // Custom RowMapper for ProductVariant
            RowMapper<ProductVariant> productVariantRowMapper = new RowMapper<ProductVariant>() {
                @Override
                public ProductVariant map(ResultSet rs, StatementContext ctx) throws SQLException {
                    ProductVariant variant = new ProductVariant();
                    variant.setId(rs.getInt("id"));
                    variant.setPrice(rs.getDouble("price"));
                    variant.setState(rs.getInt("state"));

                    Product product = new Product();
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    // ... other product fields
                    Specification specification = new Specification();
                    specification.setId(rs.getInt("id"));
                    specification.setBluetooth(rs.getString("bluetooth"));
                    specification.setBattery_capacity(rs.getString("battery_capacity"));
                    specification.setCamera_before(rs.getString("camera_before"));
                    specification.setCamera_after(rs.getString("camera_after"));
                    specification.setCart_slot(rs.getString("cart_slot"));
                    specification.setChip_set(rs.getString("chip_set"));
                    specification.setCpu_speed(rs.getString("cpu_speed"));
                    specification.setDimensions(rs.getString("dimensions"));
                    specification.setDisplay_type(rs.getString("display_type"));
                    specification.setPort_sac(rs.getString("port_sac"));
                    specification.setRam(rs.getString("ram"));
                    specification.setRom(rs.getString("rom"));
                    specification.setThe_sim(rs.getString("the_sim"));

                    InfoWarranty infoWarranty = new InfoWarranty();
                    infoWarranty.setId(rs.getInt("id"));
                    infoWarranty.setTime_warranty(rs.getString("time_warranty"));
                    infoWarranty.setAddress_warranty(rs.getString("address_warranty"));
                    infoWarranty.setTerm_waranty(rs.getString("term_waranty"));

                    Manufacturer manufacturer = new Manufacturer();
                    manufacturer.setNAME(rs.getString("manufacturerName"));

                    product.setManufacturer(manufacturer);

// ... other specification fields
                    product.setInfoWarranty(infoWarranty);
                    product.setSpecification(specification);
                    variant.setProduct(product);

                    Color color = new Color();
                    // Set properties for Color
                    color.setName(rs.getString("colorName"));
                    // ... other color fields
                    variant.setColor(color);

                    Capacity capacity = new Capacity();
                    // Set properties for Capacity
                    capacity.setName(rs.getString("capacityValue"));
                    // ... other capacity fields
                    variant.setCapacity(capacity);

                    // Fetch and set ProductImages separately
                    List<ProductImage> images = handle.createQuery(
                                    "SELECT id, product_variant_id, image_url FROM productimages WHERE product_variant_id = :variantId")
                            .bind("variantId", variant.getId())
                            .mapToBean(ProductImage.class)
                            .list();
                    variant.setProductImages(images);

                    return variant;
                }
            };

            return handle.createQuery(
                            "SELECT pv.id, pv.price, pv.state, " +
                                    "p.name, s.bluetooth, s.camera_after,s.battery_capacity, s.camera_before, s.cart_slot, s.chip_set, s.cpu_speed, p.description," +
                                    "s.dimensions, s.display_type, s.port_sac, s.ram, s.rom, s.the_sim, m.NAME as manufacturerName, " +
                                    "info.time_warranty, info.address_warranty, info.term_waranty," + // Add other product fields here
                                    "c.name as colorName, cap.name as capacityValue " +
                                    "FROM productvariants pv " +
                                    "INNER JOIN colors c ON pv.color_id = c.id " +
                                    "INNER JOIN capacities cap ON pv.capacity_id = cap.id " +
                                    "INNER JOIN products p ON pv.product_id = p.id " +
                                    "LEFT JOIN specifications s ON p.specification_id = s.id " +
                                    "LEFT JOIN infowarranties info ON p.info_warranty_id = info.id " +
                                    "inner JOIN manufacturers m ON p.manufacturer_id = m.id " +



                                    "WHERE pv.product_id = :productId")
                    .bind("productId", productId)
                    .map(productVariantRowMapper)
                    .list();
        });
    }

    public static ProductVariant getProductVariantByColorAndCapacity(int productId, int colorId, int capacityId) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery(
                            "SELECT pv.id, pv.price, pv.state, " +
                                    "p.name, p.description, " +
                                    "s.*, m.NAME as manufacturerName, " +
                                    "info.*, " +
                                    "c.name as colorName, cap.name as capacityValue " +
                                    "FROM productvariants pv " +
                                    "INNER JOIN colors c ON pv.color_id = c.id " +
                                    "INNER JOIN capacities cap ON pv.capacity_id = cap.id " +
                                    "INNER JOIN products p ON pv.product_id = p.id " +
                                    "LEFT JOIN specifications s ON p.specification_id = s.id " +
                                    "LEFT JOIN infowarranties info ON p.info_warranty_id = info.id " +
                                    "INNER JOIN manufacturers m ON p.manufacturer_id = m.id " +
                                    "WHERE pv.product_id = :productId AND pv.color_id = :colorId AND pv.capacity_id = :capacityId")
                    .bind("productId", productId)
                    .bind("colorId", colorId)
                    .bind("capacityId", capacityId)
                    .mapToBean(ProductVariant.class) // or use a custom RowMapper if necessary
                    .findFirst()
                    .orElse(null);
        });
    }

    public static void main(String[] args) {
        List<ProductVariant> productVariantList = getAllProductVariant(2);
        for (ProductVariant variant : productVariantList) {
            System.out.println(variant);
        }
    }

}








