<%@page import="java.sql.*"%>
<%@page import="protocol.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.goldhuman.Common.Octets"%>
<%@page import="com.goldhuman.IO.Protocol.Rpc.Data.DataVector"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@include file="../../WEB-INF/.pwadminconf.jsp"%>
<%@include file="items.jsp"%>

<%!
	byte[] hextoByteArray(String x)
  	{
    		if (x.length() < 2)
		{
      			return new byte[0];
		}
    		if (x.length() % 2 != 0)
		{
      			System.err.println("hextoByteArray error! hex size=" + Integer.toString(x.length()));
    		}
    		byte[] rb = new byte[x.length() / 2];
   		for (int i = 0; i < rb.length; ++i)
    		{
      			rb[i] = 0;

      			int n = x.charAt(i + i);
      			if ((n >= 48) && (n <= 57))
        			n -= 48;
      			else
				if ((n >= 97) && (n <= 102))
        				n = n - 97 + 10;
      					rb[i] = (byte)(rb[i] | n << 4 & 0xF0);

      					n = x.charAt(i + i + 1);
      					if ((n >= 48) && (n <= 57))
        					n -= 48;
      					else
					if ((n >= 97) && (n <= 102))
        					n = n - 97 + 10;
      				rb[i] = (byte)(rb[i] | n & 0xF);
    	}
    	return rb;
  }
%>

<html>

<head>
	<link rel="shortcut icon" href="../../include/fav.ico">
	<link rel="stylesheet" type="text/css" href="../../include/style.css">

</head>

<body>

<table align="center" width="500" cellpadding="2" cellspacing="0" style="border: 1px solid #cccccc;">

	<tr>
		<th align="center" style="padding: 5;">
			<b>GET ITEM</b>
		</th>
	</tr>

	<tr bgcolor="#f0f0f0">
		<td align="right">
			<%
				pageContext.include("login.jsp");
			%>
		</td>
	</tr>

	<tr>
		<td align="center" valign="middle">
			<%
				if(request.getSession().getAttribute("user") != null)
				{
					int uid = Integer.parseInt((String)request.getSession().getAttribute("user"));

					Class.forName("com.mysql.jdbc.Driver").newInstance();
					Connection connection = DriverManager.getConnection("jdbc:mysql://" + db_host + ":" + db_port + "/" + db_database, db_user, db_password);
					Statement statement = connection.createStatement();
					ResultSet rs = statement.executeQuery("SELECT zoneid FROM point WHERE uid='" + uid + "'");
					rs.next();
/*    				if(rs.getString("zoneid") != null)
					{
						out.print(" <font color=\"#ee0000\"><b>Disconnect from the game to Get Item!</b></font><br><a href=\"index.jsp\">Reload</a>");
					}
					else
*/
					{
						int roleid = uid;
						if(request.getParameter("roleid") != null)
						{
							roleid = Integer.parseInt(request.getParameter("roleid"));
						}
                                else
                                {
                                    roleid = uid;
                                }

						RoleBean character = GameDB.get(roleid);
/*						int max_cubi = character.pocket.money/unitprice;

						if(request.getParameter("cubi") != null)
						{
							int cubi_amount = Integer.parseInt(request.getParameter("cubi"));

							if(cubi_amount < 1 || cubi_amount > max_cubi)
							{
								out.println("<font color=\"#ff0000\"><b>Invalid Cubi Amount!</b></font>");
							}
							else
							{
								// transfer cubi to account
								rs = statement.executeQuery("call usecash ( '" + uid + "' , 1, 0, 1, 0, '" + 100*cubi_amount + "', 1, @error)");
								
								// remove coins from character
								character.pocket.money = character.pocket.money - (cubi_amount*unitprice);
								GameDB.update(character);

								out.println("<font color=\"#00ee00\"><b>" + cubi_amount + " Cubi Purchased<br>Transaction may take up to 5 Minutes<br>Relog Required!</b></font>");
							}
						}
*/

	if(request.getParameter("process") != null && request.getParameter("process").compareTo("mail") == 0)
	{
		if(request.getParameter("roleid") != "" && request.getParameter("title") != "" && request.getParameter("content") != "" && request.getParameter("coins") != "" && request.getParameter("itemnumber") != "")
		{
//			int roleid = Integer.parseInt(request.getParameter("roleid"));
//			String title = request.getParameter("title");
//			String content = request.getParameter("content");
		String title = "Get Item";
		String content = "Get Item";
			int coins =  0;

			int itemnumber = Integer.parseInt(request.getParameter("itemnumber"));
			GRoleInventory gri = new GRoleInventory();

			if(itemnumber > 0)
			{
				gri.id = Integer.parseInt(items[itemnumber][0]);
				gri.guid1 = 0;
				gri.guid2 = 0;
				gri.mask = Integer.parseInt(items[itemnumber][3]);
				gri.proctype = Integer.parseInt(items[itemnumber][4]);
				gri.pos = 0;
				gri.count = Integer.parseInt(items[itemnumber][5]);
				gri.max_count = Integer.parseInt(items[itemnumber][6]);
				gri.expire_date = Integer.parseInt(items[itemnumber][7]);
				gri.data = new Octets(hextoByteArray(items[itemnumber][2]));
			}

			if(protocol.DeliveryDB.SysSendMail(roleid, title, content, gri, coins))
			{
				out.println("<font color=\"#00cc00\"><b>Item Sent</b></font>");
			}
			else
			{
				out.println("<font color=\"#ee0000\"><b>Sending Item Failed</b></font>");
			}
		}
		else
		{
			out.println("<font color=\"#ee0000\"><b>Enter Valid Values</b></font>");
		}
	}

						out.println("<table width=\"300\" cellpadding=\"4\" cellspacing=\"0\" border=\"0\">");
						out.println("<form name=\"changerole\" action=\"index.jsp\" method=\"post\">");
						out.println("<tr><td><font color=\"#000000\"><b>Selected Character: </b></font></td><td><select name=\"roleid\" onchange=\"document['changerole'].submit();\" style=\"width: 100%; text-align: center;\">");

						// Get all character of current userid
						DataVector dv = GameDB.getRolelist(uid);
						if(dv != null)
						{
							Iterator itr = dv.iterator();
							while(itr.hasNext())
							{
								IntOctets ios = (IntOctets)itr.next();
								int role = ios.m_int;
								String rolename = ios.m_octets.getString();
								if(role == roleid)
								{
									out.println("<option value=\"" + role + "\" selected>" + rolename + "</option>");
								}
								else
								{
									out.println("<option value=\"" + role + "\">" + rolename + "</option>");
								}
							}	
						}
						out.println("</select></td></tr>");
						out.println("</form>");

/*						out.println("<tr><td><font color=\"#000000\"><b>Available Coins: </b></font></td><td>" + character.pocket.money + "<td></tr>");
						out.println("<tr><td><font color=\"#000000\"><b>Price / Unit: </b></font></td><td>" + unitprice + " Coins / Cubi<td></tr>");
						out.println("<form name=\"addcubi\" action=\"index.jsp?roleid=" + roleid + "\" method=\"post\">");
						out.println("<tr><td><font color=\"#000000\"><b>Purchase Cubi(s): </b></font></td><td><input type=\"number\" name=\"cubi\" value=\"0\" min=\"0\" max=\"" + max_cubi + "\" onChange=\"javascript:updatePrice()\" style=\"width: 100%; text-align: center;\"></input><td></tr>");
						out.println("<tr><td><font color=\"#000000\"><b>Overall Price: </b></font></td><td><input type=\"number\" name=\"price\" disabled style=\"width: 100%; text-align: center;\"></input><td></tr>");
*/
						out.println("<form action=\"index.jsp?process=mail\" method=\"post\">");
						out.println("<input type='hidden' name='roleid' value='"+roleid+"'></input>");
						out.println("<tr><td><font color=\"#000000\"><b>Item: </b></font></td><td><select name=\"itemnumber\" style=\"width: 100%; text-align: left;\">");
					for(int i=0; i<items.length; i++)
					{
						out.println("<option value=\"" + i + "\">" + items[i][0] + " - " + items[i][1] + "</option>");
					}
			        out.println("</select><td></tr>");
						out.println("<tr><td align=\"center\" colspan=\"2\"><input type=\"image\" src=\"../../include/btn_submit.jpg\" style=\"border: 0px; vertical-align: middle;\"></input><td></tr>");
						out.println("</form>");

						out.println("</table>");
					}
					rs.close();
					connection.close();
				}
				else
				{
					out.println("<font color=\"#ee0000\"><b></b></font>");
				}
			%>
		</td>
	</tr>

</table>

</form>

</body>

</html>