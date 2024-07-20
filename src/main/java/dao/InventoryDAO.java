package dao;

import config.JDBIConnector;
import model.KhoHang;

import java.util.List;

public class InventoryDAO {
    public List<KhoHang> getAllInventory() {
        List<KhoHang> inventoryList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM khohang")
                        .mapToBean(KhoHang.class)
                        .list());
        return inventoryList.isEmpty() ? null : inventoryList;
    }
    // Thêm kho hàng mới
    public boolean addInventory(int idProduct, String name) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO khohang (idProduct, name) VALUES (:idProduct, :name)")
                        .bind("idProduct", idProduct)
                        .bind("name", name)
                        .execute());
        return rowsAffected > 0;
    }
    // Xóa kho hàng theo ID
    public boolean deleteInventory(int id) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM khohang WHERE id = :id")
                        .bind("id", id)
                        .execute());
        return rowsAffected > 0;
    }
    public boolean updateInventory(int id, int idProduct, String name) {
        int rowsAffected = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE khohang SET idProduct = :idProduct, name = :name WHERE id = :id")
                        .bind("id", id)
                        .bind("idProduct", idProduct)
                        .bind("name", name)
                        .execute());
        return rowsAffected > 0;
    }
    // Lấy kho hàng theo ID
    public KhoHang getInventoryByID(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM khohang WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(KhoHang.class)
                        .findOnly());
    }
    public static void main(String[] args) {
        InventoryDAO inventoryDAO = new InventoryDAO();
//        System.out.println(inventoryDAO.getAllInventory());
        System.out.println(inventoryDAO.addInventory(2,"ads"));
    }
}
