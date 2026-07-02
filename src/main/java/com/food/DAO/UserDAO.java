package com.food.DAO;

import com.food.model.User;
import java.util.List;

public interface UserDAO {
    boolean addUser(User user);
    User getUser(int userId);
    User getUserByEmail(String email);
    List<User> getAllUsers();
    boolean updateUser(User user);
    boolean deleteUser(int userId);
}
