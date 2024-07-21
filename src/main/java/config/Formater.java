package config;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.Locale;

public class Formater {
    static final Locale locale = new Locale("vi", "VN");
    static final NumberFormat currencyFormatter;
    static {
        // Initialize the currencyFormatter for VND
        currencyFormatter = NumberFormat.getCurrencyInstance(locale);
        DecimalFormatSymbols symbols = ((DecimalFormat) currencyFormatter).getDecimalFormatSymbols();
        symbols.setCurrencySymbol(""); // Remove the currency symbol
        ((DecimalFormat) currencyFormatter).setDecimalFormatSymbols(symbols);

    }

    public static String formatCurrency(double price) {
        return currencyFormatter.format(Math.round(price)) + "VNĐ";
    }
    public static String formatCurrency1(double price) {
        return currencyFormatter.format(Math.round(price));
    }
}
