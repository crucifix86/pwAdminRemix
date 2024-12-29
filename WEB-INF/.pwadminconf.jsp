<%@page import="java.io.*"%>

<%
//-------------------------------------------------------------------------------------------------------------------------
//------------------------------- SETTINGS --------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------
    // Enable or disable the IP whitelist. Set to true to enable, false to disable.
    boolean enable_ip_whitelist = true;

    // pwadmin access username as md5 encrypted string
    // default username is admin -> 21232f297a57a5a743894a0e4a801fc3 (md5 of admin)
    String iweb_username = "21232f297a57a5a743894a0e4a801fc3";

	// pwadmin access password as md5 encrypted string
	// default password is admin -> 21232f297a57a5a743894a0e4a801fc3 (md5 of admin)
	String iweb_password = "21232f297a57a5a743894a0e4a801fc3";

	// connection settings to the mysql pw database
	String db_host = "localhost";
	String db_port = "3306";
	String db_user = "admin";
	String db_password = "InEYJXhKB9Ux8";
	String db_database = "pw";

	// Type of your items database required for mapping id's to names
	// Options are my or pwi
	String item_labels = "pwi";

	// Absolute path to your PW-Server main directory (startscript, stopscript, /gamed)
	// requires a tailing slash
	String pw_server_path = "/home/";

	// If you have hundreds of characters or heavy web acces through this site
	// It is recommend to turn the realtime character list feature off (false)
	// to prevent server from overload injected by character list generation
	boolean enable_character_list = true;

	String pw_server_name = "Perfect World";
	String pw_server_description = "Fixed by DaMadBoy, 151 iweb from Bola, Merged by Sora1984";

//-------------------------------------------------------------------------------------------------------------------------
//----------------------------- END SETTINGS ------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------

	String pw_server_exp = "?";
	String pw_server_sp = "?";
	String pw_server_drop = "?";
	String pw_server_coins = "?";

	BufferedReader bfr = new BufferedReader(new FileReader(pw_server_path + "gamed/ptemplate.conf"));

	String row;
	while((row = bfr.readLine()) != null)
	{
		row = row.replaceAll("\\s", "");
		if(row.indexOf("exp_bonus=") != -1)
		{
			int pos = row.length();
			if(row.indexOf("#") != -1)
			{
				pos = row.indexOf("#");
			}
			pw_server_exp = row.substring(10, pos);
		}
		if(row.indexOf("sp_bonus=") != -1)
		{
			int pos = row.length();
			if(row.indexOf("#") != -1)
			{
				pos = row.indexOf("#");
			}
			pw_server_sp = row.substring(9, pos);
		}
		if(row.indexOf("drop_bonus=") != -1)
		{
			int pos = row.length();
			if(row.indexOf("#") != -1)
			{
				pos = row.indexOf("#");
			}
			pw_server_drop = row.substring(11, pos);
		}
		if(row.indexOf("money_bonus=") != -1)
		{
			int pos = row.length();
			if(row.indexOf("#") != -1)
			{
				pos = row.indexOf("#");
			}
			pw_server_coins = row.substring(12, pos);
		}
	}

	bfr.close();

	if(request.getSession().getAttribute("items") == null)
	{
		String[] items = new String[30001];

		try
		{
			bfr = new BufferedReader(new InputStreamReader(new FileInputStream(new File(request.getRealPath("/include/items") + "/default.dat")), "UTF8"));
			if(item_labels.compareTo("my") == 0)
			{
				bfr = new BufferedReader(new InputStreamReader(new FileInputStream(new File(request.getRealPath("/include/items") + "/my.dat")), "UTF8"));
			}
			if(item_labels.compareTo("pwi") == 0)
			{
				bfr = new BufferedReader(new InputStreamReader(new FileInputStream(new File(request.getRealPath("/include/items") + "/pwi.dat")), "UTF8"));
			}
			int count = 0;
			while((row = bfr.readLine()) != null && count < 30001)
			{
				items[count] = row;
				count++;
			}
			bfr.close();
		}
		catch(Exception e)
		{
		}

		request.getSession().setAttribute("items", items);
	}
%>