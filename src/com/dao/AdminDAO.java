package com.dao;
import java.util.List;
import com.dto.Admin;

public interface AdminDAO {
    public Integer addAdmin(Admin admin);
    public Admin getAdmin(String userName, String Password);
    /*
    public void updatePassword(Integer ID, String Password );
    public void deleteAdmin(Integer ID);
    public List<Admin> listAdmin();
    public List<String> getAdmin();
    
    public Admin searchUserById(Integer ID);
    */
}





