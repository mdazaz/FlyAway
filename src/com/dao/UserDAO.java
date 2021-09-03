package com.dao;
import java.util.List;

import com.dto.Airport;
import com.dto.User;
public interface UserDAO {
    public Integer addUser(User user);
    public User getUser(String userName, String Password);
    public void updateUser(Integer ID, User user );
    public void deleteUser(Integer ID);
    public User getUserById(Integer ID);
    public List<User> listUsers();
   // public List<String> getUserNames();
   // public Airport searchUserById(Integer ID);
}





