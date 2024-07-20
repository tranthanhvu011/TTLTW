package dao;

import config.JDBIConnector;
import model.*;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import org.jdbi.v3.core.statement.Update;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    public boolean insertComment(JSONObject newComment, int idProduct) {
        try {
            String commentsJson = jdbi.withHandle(handle ->
                    handle.createQuery("SELECT comment FROM products WHERE id = ?")
                            .bind(0, idProduct)
                            .mapTo(String.class)
                            .findFirst()
                            .orElse("[]")  // Nếu không có bình luận, trả về một mảng rỗng
            );

            JSONArray comments = new JSONArray(commentsJson);
            int maxId = 0;
            for (int i = 0; i < comments.length(); i++) {
                JSONObject comment = comments.getJSONObject(i);
                int id = comment.getInt("id");
                if (id > maxId) {
                    maxId = id;
                }
            }newComment.put("id", maxId + 1);
            comments.put(newComment);

            String updatedCommentsJson = comments.toString();
            String query = "UPDATE products SET comment = ? WHERE id = ?";

            return jdbi.withHandle(handle -> {
                int success = handle.createUpdate(query)
                        .bind(0, updatedCommentsJson)
                        .bind(1, idProduct)
                        .execute();
                return success > 0;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static JSONArray getAllCommentProduct() {
        String query = "SELECT comment FROM products";
        JSONArray allComments = new JSONArray();
        try {
            List<String> commentsJsonList = jdbi.withHandle(handle ->
                    handle.createQuery(query)
                            .mapTo(String.class)
                            .list()
            );

            // Duyệt qua từng chuỗi JSON trong danh sách và thêm vào JSONArray
            for (String commentsJson : commentsJsonList) {
                JSONArray comments = new JSONArray(commentsJson);
                for (int i = 0; i < comments.length(); i++) {
                    allComments.put(comments.getJSONObject(i));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return allComments;
    }


    public static JSONArray getActiveCommentsByProductId(int productId) {
        String query = "SELECT comment FROM products WHERE id = ?";
        JSONArray activeComments = new JSONArray();
        try  {
            String commentsJson = jdbi.withHandle(handle -> handle.createQuery(query)
                    .bind(0, productId)
                    .mapTo(String.class)
                    .findOnly());
            JSONArray comments = new JSONArray(commentsJson);
            for (int i = 0; i < comments.length(); i++) {
                JSONObject comment = comments.getJSONObject(i);
                if (comment.getInt("isActive") == 1) {
                    activeComments.put(comment);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activeComments;
    }
public static boolean isActiveComment(int idProduct, int idComment) {
        String updateComment = "select comment from products where id = ?";
        try {
                String commentsJson = jdbi.withHandle(handle ->
                        handle.createQuery(updateComment).
                        bind(0, idProduct)
                                .mapTo(String.class)
                                .findOnly());
                JSONArray jsonArray = new JSONArray(commentsJson);
                boolean update = false;
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                if (jsonObject.getInt("id") == idComment) {
                    jsonObject.put("isActive", 1);
                    update = true;
                    break;
                }
            }
          if (update) {
              String updateQuery = "UPDATE products SET comment = ? WHERE id = ?";
              jdbi.withHandle(handle ->
                      handle.createUpdate(updateQuery)
                              .bind(0, jsonArray.toString())
                              .bind(1, idProduct)
                              .execute());
          }
            return update;
        } catch (Exception e) {
           e.printStackTrace();
            return false;
        }

    }
    public static boolean isNotActiveComment(int idProduct, int idComment) {
        String updateComment = "select comment from products where id = ?";
        try {
            String commentsJson = jdbi.withHandle(handle ->
                    handle.createQuery(updateComment).
                            bind(0, idProduct)
                            .mapTo(String.class)
                            .findOnly());
            JSONArray jsonArray = new JSONArray(commentsJson);
            boolean update = false;
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                if (jsonObject.getInt("id") == idComment) {
                    jsonObject.put("isActive", 0);
                    update = true;
                    break;
                }
            }
            if (update) {
                String updateQuery = "UPDATE products SET comment = ? WHERE id = ?";
                jdbi.withHandle(handle ->
                        handle.createUpdate(updateQuery)
                                .bind(0, jsonArray.toString())
                                .bind(1, idProduct)
                                .execute());
            }
            return update;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public boolean deleteComment(int idProduct, int idComment) {
        String query = "select comment from products where id = ?";
        String updateQuery = "UPDATE products SET comment = :comment WHERE id = :idProduct";

        try {
            String commentArray = jdbi.withHandle(handle -> handle.createQuery(query)
                    .bind(0, idProduct)
                    .mapTo(String.class)
                    .findOnly());
            JSONArray jsonArray = new JSONArray(commentArray);
            boolean found = false;
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                if (jsonObject.optInt("id") == idComment) {
                    jsonArray.remove(i);
                    found = true;
                    break;
                }
            }
            if (!found) {
                return false;
            }
            String updatedCommentArray = jsonArray.toString();
            int rowsUpdated = jdbi.withHandle(handle -> handle.createUpdate(updateQuery)
                    .bind("comment", updatedCommentArray)
                    .bind("idProduct", idProduct)
                    .execute());
            return rowsUpdated > 0;
        }catch (Exception e) {
            e.printStackTrace();
            return false;
        }}
    public static boolean addReply(int idProduct, int commentId, String replierName, String replyContent) {
        // Các câu truy vấn SQL
        String query = "SELECT comment FROM products WHERE id = ?";
        String updateQuery = "UPDATE products SET comment = :comment WHERE id = :idProduct";

        // Lấy JSON hiện tại từ cơ sở dữ liệu
        String existingCommentsJson = jdbi.withHandle(handle -> handle.createQuery(query)
                .bind(0, idProduct)
                .mapTo(String.class)
                .findOnly());

        JSONArray comments = new JSONArray(existingCommentsJson);
        boolean updated = false;

        for (int i = 0; i < comments.length(); i++) {
            JSONObject comment = comments.getJSONObject(i);
            if (comment.getInt("id") == commentId) {
                JSONArray replies = comment.optJSONArray("replies");
                if (replies == null) {
                    replies = new JSONArray();
                    comment.put("replies", replies);
                }
                JSONObject reply = new JSONObject();
                reply.put("id", getNextReplyId(replies));
                reply.put("nameComment", replierName);
                reply.put("content", replyContent);
                reply.put("timestamp", new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(new Date()));
                replies.put(reply);
                updated = true;
                break;
            }
        }

        if (!updated) {
            return false;
        }

        // Cập nhật JSON trong cơ sở dữ liệu
        String updatedCommentsJson = comments.toString();
        int rowsUpdated = jdbi.withHandle(handle -> handle.createUpdate(updateQuery)
                .bind("comment", updatedCommentsJson)
                .bind("idProduct", idProduct)
                .execute());

        return rowsUpdated > 0;
    }

    private static int getNextReplyId(JSONArray replies) {
        int maxId = 0;
        for (int i = 0; i < replies.length(); i++) {
            int currentId = replies.getJSONObject(i).getInt("id");
            if (currentId > maxId) {
                maxId = currentId;
            }
        }
        return maxId + 1;
    }
    public static JSONArray getReplyByComment(int idProduct, int idComment) {
        String query = "SELECT comment FROM products WHERE id = ?";
        JSONArray replies = new JSONArray();
        try {
            String commentProduct = jdbi.withHandle(handle ->
                    handle.createQuery(query)
                            .bind(0, idProduct)
                            .mapTo(String.class)
                            .findOnly()
            );

            JSONArray comments = new JSONArray(commentProduct);
            for (int i = 0; i < comments.length(); i++) {
                JSONObject comment = comments.getJSONObject(i);
                if (comment.optInt("id") == idComment) {
                    if (comment.has("replies")) {
                        replies = comment.getJSONArray("replies");
                    }
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return replies;
    }
    public static boolean UpdateReply(int idProduct, int idComment, int idReply, String contentComment) {
        String query = "SELECT comment FROM products WHERE id = ?";
        String updateQuery = "UPDATE products SET comment = ? WHERE id = ?";
        try {
            String all = jdbi.withHandle(handle -> handle.createQuery(query)
                    .bind(0, idProduct)
                    .mapTo(String.class)
                    .findOnly());
//            // In giá trị của 'all' để kiểm tra
//            System.out.println("JSON from database: " + all);
//
//            // Kiểm tra nếu dữ liệu nhận được là null hoặc không phải JSON Array
//            if (all == null || !all.trim().startsWith("[")) {
//                System.err.println("Invalid JSON format: " + all);
//                return false;
//            }
            JSONArray jsonArray = new JSONArray(all);
            boolean update = false;
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                if (jsonObject.optInt("id") == idComment) {
                    if (jsonObject.has("replies")) {
                        JSONArray repliesArray = jsonObject.getJSONArray("replies");
                        for (int j = 0; j < repliesArray.length(); j++) {
                            JSONObject replyObject = repliesArray.getJSONObject(j);
                            if (replyObject.optInt("id") == idReply) {
                                replyObject.put("content", contentComment);
                                update = true;
                                break;
                            }
                        }
                    }
                    if (update) {
                        break;
                    }
                }
            }
            if (update) {
                String updatedCommentsJson = jsonArray.toString();
                int rowsUpdated = jdbi.withHandle(handle -> handle.createUpdate(updateQuery)
                        .bind(0, updatedCommentsJson)
                        .bind(1, idProduct)
                        .execute());
                return rowsUpdated > 0;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
//       JSONArray jsonArray = getAllCommentProduct();
//       boolean trueOrFalse = isActiveComment(161, 1);
//       System.out.print(jsonArray);
        ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
//        System.out.print(addReply(174, 2, "aivaynhfasfasfi", "concasattaone"));
//        System.out.print(getReplyByComment(174,1));
//        System.out.print(getActiveCommentsByProductId(174));
        System.out.print(UpdateReply(174, 8, 1,"Con cặtgifif v"));
        }
    }










