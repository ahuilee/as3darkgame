package darkjserv;

public class AssetNPCLoadItem implements IAssetLoadItem
{
	
	public int id = 0;
	public String url = "";
	
	public AssetNPCLoadItem(int id, String url)
	{
		this.id = id;
		this.url = url;
	}

	public byte getType() {
		// TODO Auto-generated method stub
		return 1;
	}

	public String getURL() {
		// TODO Auto-generated method stub
		return url;
	}

	public int getAssetId() {
		// TODO Auto-generated method stub
		return id;
	}
	
	public String toString()
	{
		return String.format("<AssetNPCLoadItem id=%d>", id);
	}

}
