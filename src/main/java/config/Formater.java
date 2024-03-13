package config;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.Locale;

public class Formater {
    static final Locale locale = new Locale("vi", "VN");
    static final DecimalFormat customFormatter;

    static {
        // Initialize the customFormatter with the pattern for rounding to the nearest whole number
        customFormatter = new DecimalFormat("#.###");
    }

    public static String formatCurrency(double price) {
        // Round to the nearest whole number and format
        return customFormatter.format(Math.round(price));
    }
}
