package hu.ak.generics.cafeloop.bo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Subscription {

    private int id;
    private Customer customer;
    private LocalDate subscriptionDate;
    private Frequency frequency;
    private String address;
    private List<SubscriptionItem> items;

}
