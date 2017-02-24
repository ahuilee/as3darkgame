package darkjserv.storages;

import java.util.ArrayList;

public class UserAccountData
{
	
	public String username = "";
	
	
	public ArrayList<Integer> charPks = new ArrayList<Integer> (); 
	
	public String toString()
	{
		
		return String.format("<UserAccountData username=%s>", username);
	}
	

}
