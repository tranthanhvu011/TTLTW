package service;

import java.text.NumberFormat;
import java.util.Locale;

public class NumberUtils {
    public static String formatNumberWithCommas(double number) {
        NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
        return numberFormat.format(number);
    }
}
