package dao;

import config.JDBIConnector;
import model.Capacity;
import model.Manufacturer;

import java.util.List;

public class CapacityDAO {
    static CapacityDAO instance;
    public static CapacityDAO getInstance(){
        if (instance==null){
            instance=  new CapacityDAO();
        }
        return instance;
    }
    public Capacity findCapacityById(int capacityId) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Capacities WHERE id = :id")
                        .bind("id", capacityId)
                        .mapToBean(Capacity.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public Capacity findCapacityByName(String capacityName) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Capacities WHERE name = ?")
                        .bind(0, capacityName)
                        .mapToBean(Capacity.class)
                        .findFirst()
                        .orElse(null)
        );
    }


    public List<Capacity> getAllCapacities() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Capacities")
                        .mapToBean(Capacity.class)
                        .list());
    }


    public static void main(String[] args) {
    }

    public List<Capacity> findCapacityWithKeyword(String keyword) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM capacities WHERE name LIKE ?")
                        .bind(0, "%" + keyword + "%")
                        .mapToBean(Capacity.class)
                        .list());
    }

    public int insertCapacity(String name) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO capacities(name) VALUES (?)")
                        .bind(0, name)
                        .execute());
    }

    public boolean alertCapacity(int idCapacity, String nameCapacity) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE capacities SET name = ? WHERE id = ?")
                        .bind(0, nameCapacity)
                        .bind(1, idCapacity)
                        .execute()) > 0;
    }

    public boolean deleteCapacity(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM capacities WHERE id = ?")
                        .bind(0, id)
                        .execute()) > 0;
    }
}
