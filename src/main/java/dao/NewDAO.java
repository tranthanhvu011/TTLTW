package dao;

import config.JDBIConnector;
import model.News;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.Optional;

public class NewDAO {
    private static final Jdbi jdbi = JDBIConnector.me();

    public static News getNewMain() {
        String query = "SELECT * FROM News ORDER BY create_at DESC LIMIT 1";
        News news = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(News.class)
                        .findFirst()
                        .orElse(null)
        );
        return news;
    }

    public static List<News> getRightSideNews() {
        String rightQuery = "SELECT * FROM News ORDER BY create_at DESC LIMIT 3 OFFSET 1";
        List<News> rightNewsList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(rightQuery)
                        .mapToBean(News.class)
                        .list()
        );
        return rightNewsList;
    }

    public static List<News> getOtherNews() {
        String otherQuery = "SELECT * FROM News ORDER BY create_at DESC LIMIT 18446744073709551610 OFFSET 4";
        List<News> otherNewsList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(otherQuery)
                        .mapToBean(News.class)
                        .list()
        );
        return otherNewsList;
    }


    public static boolean addNews(String title, String content, String url_image) {
        java.util.Date create_at = new java.util.Date();
        String query = "INSERT INTO News (title, content, create_at, update_at, url_image) VALUES (?, ?, ?, ?, ?)";
        int result = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, title)
                        .bind(1, content)
                        .bind(2, create_at)
                        .bind(3, create_at)
                        .bind(4, url_image)
                        .execute()
        );
        return result > 0;
    }

    public static boolean deleteNews(int id) {
        String query = "DELETE FROM News WHERE id = ?";
        int isDelete = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query).bind(0, id).execute()
        );
        return isDelete > 0;
    }

    public static boolean updateNew(int id, String newTitle, String newContent, String newImageUrl) {
        java.util.Date updateNews = new java.util.Date(); // Lấy thời gian hiện tại
        String query = "UPDATE News SET title = ?, content = ?, url_image = ?, update_at=? WHERE id = ?";
        int isUpdate = JDBIConnector.me().withHandle(handle ->
                handle.createUpdate(query).bind(0, newTitle)
                        .bind(1, newContent)
                        .bind(2, newImageUrl)
                        .bind(3, updateNews)
                        .bind(4, id).execute()
        );
        return isUpdate > 0;

    }

    public static News getNewsById(int id) {
        String query = "SELECT * FROM News WHERE id = ?";
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, id)
                        .mapToBean(News.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public static List<News> getAllNews() {
        String query = "SELECT * FROM news ORDER BY ID ASC ";
        List<News> list = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).mapToBean(News.class).list());
        return list;
    }
    public static List<News> searchNewsByKeyword(String keyword) {
        String searchKeyword = "%" + keyword + "%";
        String query = "SELECT * FROM News WHERE title LIKE :searchKeyword OR content LIKE :searchKeyword OR id LIKE :searchKeyword" ;
        List<News> list = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(query).bind("searchKeyword",searchKeyword).mapToBean(News.class).list()
                );
        return list;
    }

    public static Optional<News> getNewsIndex(int index) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM news WHERE `index` = :index ORDER BY update_at DESC LIMIT 1")
                        .bind("index", index)
                        .mapToBean(News.class)
                        .findOne()
        );
    }


//    public static void main(String[] args) {
//       Optional<News> news1 = getNewsIndex(1);
//       if (news1.isPresent()) {
//           News news = news1.get();
//           System.out.println(news.getIndex());
//       }
//    }

}
