package hu.ak.generics.cafeloop.dao;

import hu.ak.generics.cafeloop.bo.Customer;

import java.sql.SQLException;
import java.util.Optional;

public interface AuthenticationDao {

	Optional<Customer> findCustomerByEmailAndPassword(String email, String password) throws SQLException;
	Optional<Customer> findCustomerByEmail(String email) throws SQLException;
	void updatePassword(String email, String newPassword) throws SQLException;
}
