package darkjserv.net;

import java.io.DataInputStream;

public interface ICommandCallback 
{

	void success(int ask, DataInputStream rd);
}
