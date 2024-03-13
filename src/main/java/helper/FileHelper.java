package helper;

import config.URLConfig;

import java.io.File;
import java.util.UUID;

public class FileHelper {
    public static String generateFileName(String fileName) {
        String name = UUID.randomUUID().toString().replace("-", "");
        int lastIndex = fileName.lastIndexOf(".");
        return name + fileName.substring(lastIndex);
    }

    public static boolean removeFile(String fileName) {
        String urlFile = URLConfig.FULL_URL_SAVE_IMAGE + fileName;
        File file = new File(urlFile);
        if (file.exists())
            return file.delete();
        return false;
    }
}
