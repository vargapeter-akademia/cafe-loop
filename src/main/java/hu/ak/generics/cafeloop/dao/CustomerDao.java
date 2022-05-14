package hu.ak.generics.cafeloop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Optional;

import hu.ak.generics.cafeloop.bo.Customer;

public class CustomerDao implements Dao<Customer> {

	private final DatabaseProvider provider = DatabaseProvider.getInstance();

	private static final String INSERT_SQL = "INSERT INTO customer(email, name, pw, salt) values(?, ?, ?, ?);";
	
	public Customer create(Customer entity) {
		try (Connection connection = provider.getConnection();
				PreparedStatement ps = connection.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, entity.getEmail());
			ps.setString(2, entity.getName());
			ps.setString(3, entity.getPassword());
			ps.setInt(4, entity.getSalt());
			
			int updatedRows = ps.executeUpdate();
			
			try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
				if (generatedKeys.next()) {
					int generatedId = generatedKeys.getInt(1);
					entity.setId(generatedId);
				}
			}
			
			return entity;
			
		} catch (SQLException e) {// TODO Auto-generated catch block
			throw new RuntimeException(e);
		}
	}

	public Optional<Customer> findById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Customer> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public Customer update(Customer entity) {
		// TODO Auto-generated method stub
		return null;
	}

	public void deleteById(int id) {
		// TODO Auto-generated method stub

	}

}
