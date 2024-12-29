<%@page import="java.sql.*"%>
<%@page import="protocol.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.goldhuman.Common.Octets"%>
<%@page import="com.goldhuman.IO.Protocol.Rpc.Data.DataVector"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@include file="../../WEB-INF/.pwadminconf.jsp"%>

<html>
<head>
<link rel="shortcut icon" href="../../include/fav.ico">
<link rel="stylesheet" type="text/css" href="../../include/style.css">
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<%!

	String int2occupation(int c)
	{
		String s;
	    	switch(c)
	    	{
			case 0:	s = "Warrior"; break;
			case 1:	s = "Mage"; break;
			case 2:	s = "Monk"; break;
			case 3:	s = "WereFox"; break;
			case 4:	s = "WereBeast"; break;
			case 5:	s = "Genie"; break;
			case 6:	s = "Archer"; break;
			case 7:	s = "Priest"; break;
			default:	s = "unknown";
	    	}
		return s;
	}
%>

	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>

	<tr>
		<th height="1" align="left" valign="middle" style="padding: 5px;">
			<font size="+1"><b>
				GameMaster Control:
			</b></font>
		</th>
		<th height="1" colspan="2" align="right" valign="middle" style="padding: 5px;">
			<table cellpadding="0" cellspacing="2" border="0">
				<tr>
				</tr>
			</table>
		</th>
	</tr>

	<tr bgcolor="#f0f0f0">
		<td colspan="3" align="center" style="padding: 5px;">
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center" style="padding: 5px;">
		</td>
	</tr>
	<%
	boolean allowed = false;
		if(request.getSession().getAttribute("ssid") == null)
		{
			out.println("<p align=\"right\"><font color=\"#ee0000\"><b>Login for GM Control...</b></font></p>");
		}
		else
		{
			allowed = true;
		}
		if(allowed)
		{
			out.println("<tr><td colspan=\"3\" align=\"center\" valign=\"top\">");
				out.println("<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"top\">");
					out.println("<table width=\"350\" cellpadding=\"2\" cellspacing=\"0\" style=\"border: 1px solid #cccccc;\">");
						out.println("<tr><th align=\"center\" colspan=\"3\" style=\"padding: 5;\">Game Masters</th></tr>");
						out.println("<tr bgcolor=\"#f0f0f0\"><td><b>Name</b></td><td><b>Occupation</b></td><td align=\"center\"><b>Level</b></td></tr>");
							try
							{
								Class.forName("com.mysql.jdbc.Driver").newInstance();
								Connection connection = DriverManager.getConnection("jdbc:mysql://" + db_host + ":" + db_port + "/" + db_database, db_user, db_password);
								Statement statement = connection.createStatement();
								ResultSet rs;
								rs = (statement.executeQuery("SELECT * FROM auth where zoneid='1' GROUP BY userid;"));
								while(rs.next())
								{
									Statement statement2 = connection.createStatement();
									ResultSet rs2;
									rs2 = (statement2.executeQuery("SELECT name FROM users WHERE ID = '" + rs.getString("userid") + "';"));
									while (rs2.next())
									{
										out.println("<tr><td style=\"border-top: 1px solid #cccccc\"><b>Account :" + rs.getString("userid") + ": " + rs2.getString("name") + "</b></td><td style=\"border-top: 1px solid #cccccc\"><a href=\"../../index.jsp?page=account&action=changegm&type=id&ident=" + rs.getString("userid") + "&act=delete\" target=\"_parent\"\"><b>Remove GM</b></a></td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><a href=\"details.jsp?process=view&userid=" + rs.getString("userid") + "\"><b>Permissions</b></a></td></tr>");
									}
									DataVector dv = GameDB.getRolelist(Integer.parseInt(rs.getString("userid")));
									if(dv != null)
									{
										Iterator itr = dv.iterator();
										while(itr.hasNext())
										{
								       		IntOctets ios = (IntOctets)itr.next();
								       		int roleid = ios.m_int;
								       		String rolename = ios.m_octets.getString();
								     	  		int rolelevel = GameDB.getRoleStatus(roleid).level;
								      	 		String roleoccupation = int2occupation(GameDB.get(roleid).base.cls);
											out.println("<tr><td style=\"border-top: 1px solid #cccccc\"><a href=\"../../index.jsp?page=role&show=details&ident=" + roleid + "&type=id\" target=\"_parent\">" + rolename + "</a></td><td style=\"border-top: 1px solid #cccccc\">" + roleoccupation + "</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\">" + rolelevel + "</td></tr>");
										}	
									}
								}
							}
							catch(Exception e)
							{
								out.println("<tr><td align=\"center\" colspan=\"3\" style=\"border-top: 1px solid #cccccc\"><font color=\"#ee0000\"><b>Connection to MySQL Database Failed</b></font></td></tr>");
							}
		}
%>
</td></tr></table>
</td></tr>
</table>
</html>