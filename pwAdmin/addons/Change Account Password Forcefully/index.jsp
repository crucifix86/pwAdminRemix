<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.security.*"%>
<%@include file="../../WEB-INF/.pwadminconf.jsp"%>

<%!
    	String pw_encode(String salt, MessageDigest alg)
	{
		alg.reset(); 
		alg.update(salt.getBytes());
		byte[] digest = alg.digest();
		StringBuffer hashedpasswd = new StringBuffer();
		String hx;
		for(int i=0; i<digest.length; i++)
		{
			hx =  Integer.toHexString(0xFF & digest[i]);
			//0x03 is equal to 0x3, but we need 0x03 for our md5sum
			if(hx.length() == 1)
			{
				hx = "0" + hx;
			} 
			hashedpasswd.append(hx);
		}
		salt = "0x" + hashedpasswd.toString();

        	return salt;
   	}
%>

<%
	boolean allowed = false;

	if(request.getSession().getAttribute("ssid") == null)
	{
		out.println("<p align=\"right\"><font color=\"#ee0000\"><b>Login for Account administration...</b></font></p>");
	}
	else
	{
		allowed = true;
	}

	String message = "<br>";
	if(request.getParameter("action") != null)
	{
			String action = new String(request.getParameter("action"));

			if(action.compareTo("passwd") == 0)
			{
				String login = request.getParameter("login");
				String password_old = request.getParameter("password_old");
				String password_new = request.getParameter("password_new");

				if(login.length() > 0 && password_new.length() > 0)
				{
					if(password_new.length() < 4 || password_new.length() > 10)
					{
						message = "<font color=\"ee0000\">Only 4-10 Characters</font>";
					}
					else
					{
						String alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_";
						boolean check = true;
						char c;
						for(int i=0; i<password_new.length(); i++)
						{
							c = password_new.charAt(i);
							if (alphabet.indexOf(c) == -1)
							{
								check = false;
								break;
							}
						}

						if(!check)
						{
							message = "<font color=\"ee0000\">Forbidden Characters</font>";
						}
						else
						{
							try
							{
								Class.forName("com.mysql.jdbc.Driver").newInstance();
								Connection connection = DriverManager.getConnection("jdbc:mysql://" + db_host + ":" + db_port + "/" + db_database, db_user, db_password);
								Statement statement = connection.createStatement();
								ResultSet rs = statement.executeQuery("SELECT ID, passwd FROM users WHERE name='" + login + "'");
								String password_stored = "";
								String id_stored = "";
								int count = 0;
								while(rs.next())
								{
									id_stored = rs.getString("ID");
									password_stored = rs.getString("passwd");
									count++;
								}

								if(count <= 0)
								{
									message = "<font color=\"ee0000\">User Don't Exists</font>";
								}
								else
								{
									password_old = pw_encode(login + password_old, MessageDigest.getInstance("MD5"));

									// Some hard encoding problems requires a strange solution...
									// changePasswd -> wrong encoding password destroyed...
									// Only a temp entry in database gives us a correct encoded password for comparsion

									rs = statement.executeQuery("call adduser('" + login + "_TEMP_USER', " + password_old + ", '0', '0', '0', '0', '', '0', '0', '0', '0', '0', '0', '0', '', '', " + password_old + ")");
									rs = statement.executeQuery("SELECT passwd FROM users WHERE name='" + login + "_TEMP_USER'");
									rs.next();
									password_old = rs.getString("passwd");

									// Delete temp entry
									statement.executeUpdate("DELETE FROM users WHERE name='" + login + "_TEMP_USER'");

									{
										password_new = pw_encode(login + password_new, MessageDigest.getInstance("MD5"));

										// LOCK TABLE to ensure that nobody else get the original ID of the user
										statement.executeUpdate("LOCK TABLE users WRITE");
										// Delete old entry
										statement.executeUpdate("DELETE FROM users WHERE name='" + login + "'");
										// Add new entry
										rs = statement.executeQuery("call adduser('" + login + "', " + password_new + ", '0', '0', '0', '0', '', '0', '0', '0', '0', '0', '0', '0', '', '', " + password_new + ")");
										// change new entry ID to original ID - necessary to keep characters of this account
										statement.executeUpdate("UPDATE users SET ID='" + id_stored + "' WHERE name='" + login + "'");
										// UNLOCK TABLES
										statement.executeUpdate("UNLOCK TABLES");

										message = "<font color=\"00cc00\">Password Changed</font>";
									}
								}

								rs.close();
								statement.close();
								connection.close();
							}
							catch(Exception e)
							{
								message = "<font color=\"#ee0000\"><b>Connection to MySQL Database Failed</b></font>";
							}
						}
					}
				}
			}

			
	}
%>


<head>
	<link rel="shortcut icon" href="../../include/fav.ico">
	<link rel="stylesheet" type="text/css" href="../../include/style.css">
</head>

<table width="800" cellpadding="0" cellspacing="0" border="0">

<tr>
	<td height="1" align="center" valign="top" colspan="3">
		<b><% out.print(message); %></b>
	</td>
</tr>

<tr>
	<td height="1" align="center" valign="top" colspan="3">
		<br>
	</td>
</tr>


	<td align="center" valign="top">
		<form action="index.jsp?page=account&action=passwd" method="post" style="margin: 0px;">
			<table width="240" cellpadding="5" cellspacing="0" style="border:1px solid #cccccc;">
				<tr>
					<th align="center" colspan="2">
						<b><font color="#ffffff">CHANGE ACCOUNT PASSWORD</font></b>
					</th>
				</tr>
				<tr>
					<td>Login Name:</td><td align="right"><input type="text" name="login" style="width: 100; text-align: center;"></td>
				</tr>
				<tr>
					<td>New Password:</td><td align="right"><input type="password" name="password_new" style="width: 100; text-align: center;"></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><input type="image" name="submit" src="../../include/btn_change.jpg" style="border: 0px;"></td>
				</tr>
			</table>
		</form>
	</td>
</table>