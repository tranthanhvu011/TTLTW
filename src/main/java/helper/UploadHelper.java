package helper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.io.*;

public class UploadHelper {

    public static String uploadFile(HttpServletRequest request, Part filePart, String urlSave) {
        String fileName = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try {
            // Đường dẫn lưu vào project
            String rootPath = request.getServletContext().getRealPath("");
            String projectBasePath = "C:\\Users\\ADMIN\\IdeaProjects\\TTLTW\\src\\main\\webapp\\" + urlSave + File.separator;
            System.out.println("Saving file to project folder: " + projectBasePath);

            // Đường dẫn lưu vào thư mục Tomcat (ví dụ: trong thư mục webapps của Tomcat)
            String tomcatBasePath = rootPath + urlSave + File.separator;
            System.out.println("Saving file to Tomcat folder: " + tomcatBasePath);

            // Tạo thư mục nếu không tồn tại
            ensureDirectoryExists(projectBasePath);
            ensureDirectoryExists(tomcatBasePath);

            // Đọc dữ liệu từ file
            fileName = FileHelper.generateFileName(filePart.getSubmittedFileName());
            inputStream = filePart.getInputStream();

            // Lưu file vào thư mục của project
            saveFile(inputStream, projectBasePath + fileName);

            // Reset inputStream để lưu vào Tomcat
            inputStream = filePart.getInputStream(); // Cần reset nếu dùng lại inputStream
            saveFile(inputStream, tomcatBasePath + fileName);

        } catch (Exception ex) {
            ex.printStackTrace();
            fileName = null;
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return fileName;
    }

    private static void ensureDirectoryExists(String path) {
        File directory = new File(path);
        if (!directory.exists()) {
            directory.mkdirs();
        }
    }

    private static void saveFile(InputStream inputStream, String outputPath) throws IOException {
        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(new File(outputPath));
            int read = 0;
            final byte[] bytes = new byte[1024];
            while ((read = inputStream.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        } finally {
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }}