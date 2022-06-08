package hu.ak.generics.cafeloop.util;

import java.time.DayOfWeek;
import java.time.LocalDate;

public final class DeliveryUtils {

    public enum DeliveryFrequency {
        EACH_MONDAY_AND_THURSDAY {
            @Override
            public LocalDate calculateNextDeliveryDay(LocalDate referenceDate) {
                LocalDate midReferenceDate = LocalDate.from(DayOfWeek.THURSDAY.adjustInto(referenceDate));

                if (referenceDate.isBefore(midReferenceDate)) {
                    return midReferenceDate;
                }

                return nextMonday(referenceDate);
            }

        },
        EACH_MONDAY {
            @Override
            public LocalDate calculateNextDeliveryDay(LocalDate referenceDate) {
                return LocalDate.from(DayOfWeek.MONDAY.adjustInto(referenceDate.plusWeeks(1)));
            }

        },
        EVERY_OTHER_MONDAY {
            @Override
            public LocalDate calculateNextDeliveryDay(LocalDate referenceDate) {
                return nextMonday(referenceDate.plusWeeks(1));
            }

        },
        FIRST_MONDAY_OF_EACH_MONTH {
            @Override
            public LocalDate calculateNextDeliveryDay(LocalDate referenceDate) {
                LocalDate firstDayOfNextMonth = referenceDate.plusMonths(1).withDayOfMonth(1);
                LocalDate firstOrLastMondayOfMonth = nextMonday(firstDayOfNextMonth);

                if (firstOrLastMondayOfMonth.isBefore(firstDayOfNextMonth)) {
                    return firstOrLastMondayOfMonth.plusWeeks(1);
                }

                return firstOrLastMondayOfMonth;
            }

        };

        public abstract LocalDate calculateNextDeliveryDay(LocalDate referenceDate);

    }

    public static LocalDate nextMonday(LocalDate referenceDate) {
        return LocalDate.from(DayOfWeek.MONDAY.adjustInto(referenceDate.plusWeeks(1)));
    }

    public static LocalDate getNextDeliveryDay(String frequencyCode) {
        return DeliveryFrequency.valueOf(frequencyCode).calculateNextDeliveryDay(LocalDate.now());
    }

}
