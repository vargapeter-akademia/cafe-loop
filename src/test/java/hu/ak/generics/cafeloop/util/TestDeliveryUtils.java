package hu.ak.generics.cafeloop.util;

import org.junit.jupiter.api.Test;

import java.time.DayOfWeek;
import java.time.LocalDate;

import static hu.ak.generics.cafeloop.util.DeliveryUtils.DeliveryFrequency.EACH_MONDAY;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class TestDeliveryUtils {

    @Test
    public void testCalculateNextDeliveryDayEachMonday() {

        LocalDate monday = LocalDate.from(DayOfWeek.MONDAY.adjustInto(LocalDate.now()));
        assertEquals(monday.plusWeeks(1), EACH_MONDAY.calculateNextDeliveryDay(monday));

    }

}
