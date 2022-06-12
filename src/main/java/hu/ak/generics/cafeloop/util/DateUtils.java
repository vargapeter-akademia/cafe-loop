package hu.ak.generics.cafeloop.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public final class DateUtils {
    private final static DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy. MM. dd. EEEE");

    public static String formatDateWithDayName(LocalDate date) {
        return date.format(DATE_FORMATTER);
    }

}
