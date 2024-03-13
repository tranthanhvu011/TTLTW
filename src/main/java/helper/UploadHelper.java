package helper;

import config.URLConfig;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class UploadHelper {

    public static String uploadFile(HttpServletRequest request, Part filePart,String urlSave) {
        String fileName = null;
        try {
            String rootPath = request.getServletContext().getRealPath("");
            String basePath = rootPath + urlSave + File.separator;
            System.out.println(basePath);
            InputStream inputStream = null;
            OutputStream outputStream = null;
            fileName = FileHelper.generateFileName(filePart.getSubmittedFileName());
            try {
                File outputFilePath = new File(basePath + fileName);
                inputStream = filePart.getInputStream();
                outputStream = new FileOutputStream(outputFilePath);
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
            } catch (Exception ex) {
                fileName = null;
            } finally {
                if (outputStream != null) {
                    outputStream.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
            }
        } catch (Exception e) {
            fileName = null;
        }
        return fileName;
    }
}