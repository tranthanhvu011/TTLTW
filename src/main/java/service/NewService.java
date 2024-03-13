package service;

import dao.NewDAO;
import model.News;

import java.util.List;
import java.util.Optional;

public class NewService {
    public static List<News> getAllNews(){
        return NewDAO.getAllNews();
    }
    public static News getNewsByID(int id){
        return NewDAO.getNewsById(id);
    }
    public static boolean deleteNews(int id){
        return NewDAO.deleteNews(id);
    }
    public static boolean addNews(String title, String content, String url_image){
        return  NewDAO.addNews(title,content,url_image);
    }
    public static List<News> searchNews(String keyWord){

        return NewDAO.searchNewsByKeyword(keyWord);
    }
    public Optional<News> SelectNewsIndex(int index) {
        Optional<News> news = NewDAO.getNewsIndex(index);
//        news.ifPresent(n -> System.out.println("Found news: " + n));
        return news;
    }
    public static void main(String[] args) {
        // Tạo một đối tượng NewService
        NewService newService = new NewService();

        // Gọi phương thức trong NewService và lấy kết quả
        Optional<News> news1 = newService.SelectNewsIndex(1);
        Optional<News> news2 = newService.SelectNewsIndex(2);

        // Kiểm tra và in ra kết quả
        if (news1.isPresent()) {
            System.out.println("News 1 Found: " + news1.get());
        } else {
            System.out.println("News 1 not found.");
        }

        if (news2.isPresent()) {
            System.out.println("News 2 Found: " + news2.get());
        } else {
            System.out.println("News 2 not found.");
        }
    }
}
