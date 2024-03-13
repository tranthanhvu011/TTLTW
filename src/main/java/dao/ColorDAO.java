package dao;

import config.JDBIConnector;
import model.Color;

import java.util.List;

public class ColorDAO {

    public Color findColorById(int colorId) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Colors WHERE id = :id")
                        .bind("id", colorId)
                        .mapToBean(Color.class)
                        .findFirst()
                        .orElse(null)
        );
    }
    public Color findColorByName(String name) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Colors WHERE name = ?")
                        .bind(0, name)
                        .mapToBean(Color.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public List<Color> getAllColors() {

        List<Color> colors = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM Colors")
                        .mapToBean(Color.class)
                        .list());
        return colors.isEmpty() ? null : colors;
    }

    public List<Color> findColorWithKeyWord(String keyword) {
        List<Color> colors = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM telephone.colors WHERE colors.name LIKE ? or colors.id LIKE ?")
                        .bind(0, "%" + keyword + "%")
                        .bind(1, "%" + keyword + "%")
                        .mapToBean(Color.class)
                        .list());
        return colors.isEmpty() ? null : colors;
    }

    public boolean insertColor(String name) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("INSERT INTO Colors(name) VALUES (?)")
                        .bind(0, name)
                        .execute()
        ) > 0;
    }

    public boolean editColor(int idColor, String nameColor) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("UPDATE Colors SET name = ? WHERE id = ?")
                        .bind(0, nameColor)
                        .bind(1, idColor)
                        .execute()
        ) > 0;
    }

    public boolean deleteColor(int id) {
        return JDBIConnector.me().withHandle(handle ->
                handle.createUpdate("DELETE FROM Colors WHERE id = ?")
                        .bind(0, id)
                        .execute()
        ) > 0;
    }
}
