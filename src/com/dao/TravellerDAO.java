package com.dao;
import java.util.List;
import com.dto.Traveller;
public interface TravellerDAO {
    public Integer addTraveller(Traveller traveller);    
    public void updateTraveller(Integer ID, Traveller traveller );
    public void deleteTraveller(Integer ID);
    public List<Traveller> listTravellers();
   // public List<String> getTravellerNames();
    public Traveller searchTravellerById(Integer ID);
}

