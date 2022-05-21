package hu.ak.generics.cafeloop.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface Dao<T> {
	
	// CRUD
	
	// Create
	// Read
	// Update
	// Delete
	
	T create(T entity) throws SQLException;
	
	Optional<T> findById(int id) throws SQLException;
	
	List<T> findAll() throws SQLException; // TODO mi van akkor, ha rengeteg entitást olvasnánk be?
	
	boolean update(T entity) throws SQLException; // TODO PCL

	boolean deleteById(int id) throws SQLException; // Biztosan mindenre meg szeretnénk engedni a törlést? Virtuális törlés
	
}
