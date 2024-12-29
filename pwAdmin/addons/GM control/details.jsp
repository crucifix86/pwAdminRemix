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
<script language="JavaScript">
  function showhidefield()
  {
    if (document.frm.chkbox.checked)
  { 
  document.getElementById("hide0").style.display = '';
  document.getElementById("hide1").style.display = '';
  document.getElementById("hide2").style.display = '';
  document.getElementById("hide3").style.display = '';
  document.getElementById("hide4").style.display = '';
  document.getElementById("hide5").style.display = '';
  document.getElementById("hide6").style.display = '';
  document.getElementById("hide7").style.display = '';
  document.getElementById("hide8").style.display = '';
  document.getElementById("hide9").style.display = '';
  document.getElementById("hide10").style.display = '';
  document.getElementById("hide11").style.display = '';
  document.getElementById("hide12").style.display = '';
  document.getElementById("hide13").style.display = '';
  document.getElementById("hide14").style.display = '';
  document.getElementById("hide15").style.display = '';
  document.getElementById("hide16").style.display = '';
  document.getElementById("hide17").style.display = '';
  document.getElementById("hide18").style.display = '';
  document.getElementById("hide19").style.display = '';
  document.getElementById("hide20").style.display = '';
  document.getElementById("hide21").style.display = '';
  document.getElementById("hide22").style.display = '';
  document.getElementById("hide23").style.display = '';
  document.getElementById("hide24").style.display = '';
  document.getElementById("hide25").style.display = '';
  document.getElementById("hide26").style.display = '';
  document.getElementById("hide27").style.display = '';
  document.getElementById("hide28").style.display = '';
  document.getElementById("hide29").style.display = '';
  document.getElementById("hide30").style.display = '';
  document.getElementById("hide31").style.display = '';
  document.getElementById("hide32").style.display = '';
  document.getElementById("hide33").style.display = '';
  }
  else
  {
  document.getElementById("hide0").style.display = 'none';
  document.getElementById("hide1").style.display = 'none';
  document.getElementById("hide2").style.display = 'none';
  document.getElementById("hide3").style.display = 'none';
  document.getElementById("hide4").style.display = 'none';
  document.getElementById("hide5").style.display = 'none';
  document.getElementById("hide6").style.display = 'none';
  document.getElementById("hide7").style.display = 'none';
  document.getElementById("hide8").style.display = 'none';
  document.getElementById("hide9").style.display = 'none';
  document.getElementById("hide10").style.display = 'none';
  document.getElementById("hide11").style.display = 'none';
  document.getElementById("hide12").style.display = 'none';
  document.getElementById("hide13").style.display = 'none';
  document.getElementById("hide14").style.display = 'none';
  document.getElementById("hide15").style.display = 'none';
  document.getElementById("hide16").style.display = 'none';
  document.getElementById("hide17").style.display = 'none';
  document.getElementById("hide18").style.display = 'none';
  document.getElementById("hide19").style.display = 'none';
  document.getElementById("hide20").style.display = 'none';
  document.getElementById("hide21").style.display = 'none';
  document.getElementById("hide22").style.display = 'none';
  document.getElementById("hide23").style.display = 'none';
  document.getElementById("hide24").style.display = 'none';
  document.getElementById("hide25").style.display = 'none';
  document.getElementById("hide26").style.display = 'none';
  document.getElementById("hide27").style.display = 'none';
  document.getElementById("hide28").style.display = 'none';
  document.getElementById("hide29").style.display = 'none';
  document.getElementById("hide30").style.display = 'none';
  document.getElementById("hide31").style.display = 'none';
  document.getElementById("hide32").style.display = 'none';
  document.getElementById("hide33").style.display = 'none';
  }
}
function checkAll()
{
	document.getElementById("rid0").checked = true ;
	document.getElementById("rid1").checked = true ;
	document.getElementById("rid2").checked = true ;
	document.getElementById("rid3").checked = true ;
	document.getElementById("rid4").checked = true ;
	document.getElementById("rid5").checked = true ;
	document.getElementById("rid6").checked = true ;
	document.getElementById("rid11").checked = true ;
	document.getElementById("rid100").checked = true ;
	document.getElementById("rid101").checked = true ;
	document.getElementById("rid102").checked = true ;
	document.getElementById("rid103").checked = true ;
	document.getElementById("rid104").checked = true ;
	document.getElementById("rid105").checked = true ;
	document.getElementById("rid200").checked = true ;
	document.getElementById("rid206").checked = true ;
}

function uncheckAll()
{
	document.getElementById("rid0").checked = false ;
	document.getElementById("rid1").checked = false ;
	document.getElementById("rid2").checked = false ;
	document.getElementById("rid3").checked = false ;
	document.getElementById("rid4").checked = false ;
	document.getElementById("rid5").checked = false ;
	document.getElementById("rid6").checked = false ;
	document.getElementById("rid11").checked = false ;
	document.getElementById("rid100").checked = false ;
	document.getElementById("rid101").checked = false ;
	document.getElementById("rid102").checked = false ;
	document.getElementById("rid103").checked = false ;
	document.getElementById("rid104").checked = false ;
	document.getElementById("rid105").checked = false ;
	document.getElementById("rid200").checked = false ;
	document.getElementById("rid206").checked = false ;
}
</script>
</script>
<style type="text/css">
a.whitetext
{
font-size: 13.5pt;
font-weight: bold;
color: #ffffff;
}
</style>
</head>
<body>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td colspan="3">
			<br>
		</td>
	</tr>
	<tr>
		<th height="1" align="left" valign="middle" style="padding: 5px;">
			<font size="+1"><b>
				<a class ="whitetext" href="index.jsp">GameMaster Control</a> > Permissions Editor:
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
			if(request.getParameter("process").compareTo("view") == 0)
			{
				int id = Integer.parseInt(request.getParameter("userid"));
				String restrict0 = "";
				String restrict1 = "";
				String restrict2 = "";
				String restrict3 = "";
				String restrict4 = "";
				String restrict5 = "";
				String restrict6 = "";
				String restrict7 = "";
				String restrict8 = "";
				String restrict9 = "";
				String restrict10 = "";
				String restrict11 = "";

				String restrict100 = "";
				String restrict101 = "";
				String restrict102 = "";
				String restrict103 = "";
				String restrict104 = "";
				String restrict105 = "";

				String restrict200 = "";
				String restrict201 = "";
				String restrict202 = "";
				String restrict203 = "";
				String restrict204 = "";
				String restrict205 = "";
				String restrict206 = "";
				String restrict207 = "";
				String restrict208 = "";
				String restrict209 = "";
				String restrict210 = "";
				String restrict211 = "";
				String restrict212 = "";
				String restrict213 = "";
				String restrict214 = "";

				String restrict501 = "";
				String restrict502 = "";
				String restrict503 = "";
				String restrict504 = "";
				String restrict505 = "";
				String restrict506 = "";
				String restrict507 = "";
				String restrict508 = "";
				String restrict509 = "";
				String restrict510 = "";
				String restrict511 = "";
				String restrict512 = "";
				String restrict513 = "";
				String restrict514 = "";
				String restrict515 = "";
				String restrict516 = "";
				String restrict517 = "";
				String restrict518 = "";

				try
				{
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					Connection connection = DriverManager.getConnection("jdbc:mysql://" + db_host + ":" + db_port + "/" + db_database, db_user, db_password);
					Statement statement = connection.createStatement();
					ResultSet rs;
					rs = (statement.executeQuery("SELECT * FROM auth WHERE userid = '" + id + "' and zoneid='1';"));
					while(rs.next())
					{
						if(rs.getInt("rid") == 0) { restrict0 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 1) { restrict1 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 2) { restrict2 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 3) { restrict3 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 4) { restrict4 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 5) { restrict5 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 6) { restrict6 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 7) { restrict7 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 8) { restrict8 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 9) { restrict9 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 10) { restrict10 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 11) { restrict11 = "checked=\"checked\""; }

						else if(rs.getInt("rid") == 100) { restrict100 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 101) { restrict101 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 102) { restrict102 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 103) { restrict103 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 104) { restrict104 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 105) { restrict105 = "checked=\"checked\""; }

						else if(rs.getInt("rid") == 200) { restrict200 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 201) { restrict201 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 202) { restrict202 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 203) { restrict203 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 204) { restrict204 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 205) { restrict205 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 206) { restrict206 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 207) { restrict207 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 208) { restrict208 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 209) { restrict209 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 210) { restrict210 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 211) { restrict211 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 212) { restrict212 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 213) { restrict213 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 214) { restrict214 = "checked=\"checked\""; }

						else if(rs.getInt("rid") == 501) { restrict501 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 502) { restrict502 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 503) { restrict503 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 504) { restrict504 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 505) { restrict505 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 506) { restrict506 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 507) { restrict507 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 508) { restrict508 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 509) { restrict509 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 510) { restrict510 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 511) { restrict511 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 512) { restrict512 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 513) { restrict513 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 514) { restrict514 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 515) { restrict515 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 516) { restrict516 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 517) { restrict517 = "checked=\"checked\""; }
						else if(rs.getInt("rid") == 518) { restrict518 = "checked=\"checked\""; }
					}
					log("PwAdmin: GmControl ViewPermissions uid=" + id + " by " + request.getRemoteHost() + " successfully.");
				}
				catch(Exception e)
				{
					out.println("<tr><td align=\"center\" colspan=\"3\" style=\"border-top: 1px solid #cccccc\"><font color=\"#ee0000\"><b>Connection to MySQL Database Failed</b></font></td></tr>");
					log("PwAdmin: GmControl ViewPermissions uid=" + id + " by " + request.getRemoteHost() + " failed.");
				}
				out.println("<tr><td colspan=\"3\" align=\"center\" valign=\"top\">");
				out.println("<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" valign=\"top\">");
				out.println("<table width=\"350\" cellpadding=\"2\" cellspacing=\"0\" style=\"border: 1px solid #cccccc;\">");
				out.println("<tr><th align=\"center\" colspan=\"3\" style=\"padding: 5;\">Permissions for Account: " + id + " &nbsp;&nbsp;&nbsp;( <a href=\"#\" onclick=\"checkAll()\">Enable All</a> | <a href=\"#\"  onclick=\"uncheckAll()\">Disable All</a> )</th></tr>");
				out.println("<tr bgcolor=\"#f0f0f0\"><td><b>Description</b></td><td><b>cmd ID</b></td><td align=\"center\"><b>Allowed</b></td></tr>");
				out.println("<form name=\"frm\" id=\"frm\" action=\"details.jsp?process=save&userid=" + id + "\" method=\"post\" style=\"margin: 0px;\">");

				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">GM tag</td><td style=\"border-top: 1px solid #cccccc\">-</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\">always</td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Create object</td><td style=\"border-top: 1px solid #cccccc\">-</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\">always</td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Switch player's name and ID</td><td style=\"border-top: 1px solid #cccccc\">0</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid0\" id=\"rid0\" type=\"checkbox\" value=\"true\" " + restrict0 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Turn into hidden or invincible status</td><td style=\"border-top: 1px solid #cccccc\">1</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid1\" id=\"rid1\" type=\"checkbox\" value=\"true\" " + restrict1 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Switch online status</td><td style=\"border-top: 1px solid #cccccc\">2</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid2\" id=\"rid2\" type=\"checkbox\" value=\"true\" " + restrict2 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Hide online status in wisper</td><td style=\"border-top: 1px solid #cccccc\">3</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid3\" id=\"rid3\" type=\"checkbox\" value=\"true\" " + restrict3 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Teleport to player</td><td style=\"border-top: 1px solid #cccccc\">4</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid4\" id=\"rid4\" type=\"checkbox\" value=\"true\" " + restrict4 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Teleport player to GM</td><td style=\"border-top: 1px solid #cccccc\">5</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid5\" id=\"rid5\" type=\"checkbox\" value=\"true\" " + restrict5 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Teleport by ctrl+clicking map</td><td style=\"border-top: 1px solid #cccccc\">6</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid6\" id=\"rid6\" type=\"checkbox\" value=\"true\" " + restrict6 + "></td></tr>");
				out.println("<tr id=\"hide0\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Move to NPC (useless)</td><td style=\"border-top: 1px solid #cccccc\">7</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid7\" type=\"checkbox\" value=\"true\" " + restrict7 + "></td></tr>");
				out.println("<tr id=\"hide1\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Move to Map (useless)</td><td style=\"border-top: 1px solid #cccccc\">8</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid8\" type=\"checkbox\" value=\"true\" " + restrict8 + "></td></tr>");
				out.println("<tr id=\"hide2\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Increase Speed (useless)</td><td style=\"border-top: 1px solid #cccccc\">9</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid9\" type=\"checkbox\" value=\"true\" " + restrict9 + "></td></tr>");
				out.println("<tr id=\"hide3\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Follow Player (useless)</td><td style=\"border-top: 1px solid #cccccc\">10</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid10\" type=\"checkbox\" value=\"true\" " + restrict10 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Show online number</td><td style=\"border-top: 1px solid #cccccc\">11</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid11\" id=\"rid11\" type=\"checkbox\" value=\"true\" " + restrict11 + "></td></tr>");

				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Ban player account/character</td><td style=\"border-top: 1px solid #cccccc\">100</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid100\" id=\"rid100\" type=\"checkbox\" value=\"true\" " + restrict100 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Mute player account/character</td><td style=\"border-top: 1px solid #cccccc\">101</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid101\" id=\"rid101\" type=\"checkbox\" value=\"true\" " + restrict101 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Ban trading for a player</td><td style=\"border-top: 1px solid #cccccc\">102</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid102\" id=\"rid102\" type=\"checkbox\" value=\"true\" " + restrict102 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Ban selling for a player</td><td style=\"border-top: 1px solid #cccccc\">103</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid103\" id=\"rid103\" type=\"checkbox\" value=\"true\" " + restrict103 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">GM announcement broadcast</td><td style=\"border-top: 1px solid #cccccc\">104</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid104\" id=\"rid104\" type=\"checkbox\" value=\"true\" " + restrict104 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Restart gameserver</td><td style=\"border-top: 1px solid #cccccc\">105</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid105\" id=\"rid105\" type=\"checkbox\" value=\"true\" " + restrict105 + "></td></tr>");

				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Create Monster</td><td style=\"border-top: 1px solid #cccccc\">200</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid200\" id=\"rid200\" type=\"checkbox\" value=\"true\" " + restrict200 + "></td></tr>");
				out.println("<tr id=\"hide4\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Delete Monster (useless)</td><td style=\"border-top: 1px solid #cccccc\">201</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid201\" type=\"checkbox\" value=\"true\" " + restrict201 + "></td></tr>");
				out.println("<tr id=\"hide5\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Morph into Monster (useless)</td><td style=\"border-top: 1px solid #cccccc\">202</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid202\" type=\"checkbox\" value=\"true\" " + restrict202 + "></td></tr>");
				out.println("<tr id=\"hide6\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">GM Administrator (useless)</td><td style=\"border-top: 1px solid #cccccc\">203</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid203\" type=\"checkbox\" value=\"true\" " + restrict203 + "></td></tr>");
				out.println("<tr id=\"hide7\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Set double exp (useless)</td><td style=\"border-top: 1px solid #cccccc\">204</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid204\" type=\"checkbox\" value=\"true\" " + restrict204 + "></td></tr>");
				out.println("<tr id=\"hide8\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Set same-ip connection limit (useless)</td><td style=\"border-top: 1px solid #cccccc\">205</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid205\" type=\"checkbox\" value=\"true\" " + restrict205 + "></td></tr>");
				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Activate Monster Creator</td><td style=\"border-top: 1px solid #cccccc\">206</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid206\" id=\"rid206\" type=\"checkbox\" value=\"true\" " + restrict206 + "></td></tr>");
				out.println("<tr id=\"hide9\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forbid trade for all players (useless)</td><td style=\"border-top: 1px solid #cccccc\">207</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid207\" type=\"checkbox\" value=\"true\" " + restrict207 + "></td></tr>");
				out.println("<tr id=\"hide10\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forbid auction for all players (useless)</td><td style=\"border-top: 1px solid #cccccc\">208</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid208\" type=\"checkbox\" value=\"true\" " + restrict208 + "></td></tr>");
				out.println("<tr id=\"hide11\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forbid ingame mail for all players (useless)</td><td style=\"border-top: 1px solid #cccccc\">209</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid209\" type=\"checkbox\" value=\"true\" " + restrict209 + "></td></tr>");
				out.println("<tr id=\"hide12\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forbid all Faction activity (useless)</td><td style=\"border-top: 1px solid #cccccc\">210</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid210\" type=\"checkbox\" value=\"true\" " + restrict210 + "></td></tr>");
				out.println("<tr id=\"hide13\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Set double money drop (useless)</td><td style=\"border-top: 1px solid #cccccc\">211</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid211\" type=\"checkbox\" value=\"true\" " + restrict211 + "></td></tr>");
				out.println("<tr id=\"hide14\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Set double item drop (useless)</td><td style=\"border-top: 1px solid #cccccc\">212</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid212\" type=\"checkbox\" value=\"true\" " + restrict212 + "></td></tr>");
				out.println("<tr id=\"hide15\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Set double SP reward (useless)</td><td style=\"border-top: 1px solid #cccccc\">213</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid213\" type=\"checkbox\" value=\"true\" " + restrict213 + "></td></tr>");
				out.println("<tr id=\"hide16\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forbid point card selling (useless)</td><td style=\"border-top: 1px solid #cccccc\">214</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid214\" type=\"checkbox\" value=\"true\" " + restrict214 + "></td></tr>");

				out.println("<tr id=\"hide16\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Edit character data (useless)</td><td style=\"border-top: 1px solid #cccccc\">501</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid501\" type=\"checkbox\" value=\"true\" " + restrict501 + "></td></tr>");
				out.println("<tr id=\"hide17\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">check status of server (useless)</td><td style=\"border-top: 1px solid #cccccc\">502</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid502\" type=\"checkbox\" value=\"true\" " + restrict502 + "></td></tr>");
				out.println("<tr id=\"hide18\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">check log (useless)</td><td style=\"border-top: 1px solid #cccccc\">503</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid503\" type=\"checkbox\" value=\"true\" " + restrict503 + "></td></tr>");
				out.println("<tr id=\"hide19\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forcefully reboot game server (useless)</td><td style=\"border-top: 1px solid #cccccc\">504</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid504\" type=\"checkbox\" value=\"true\" " + restrict504 + "></td></tr>");
				out.println("<tr id=\"hide20\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Forcefully reboot database server (useless)</td><td style=\"border-top: 1px solid #cccccc\">505</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid505\" type=\"checkbox\" value=\"true\" " + restrict505 + "></td></tr>");
				out.println("<tr id=\"hide21\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Find ID of char name (useless)</td><td style=\"border-top: 1px solid #cccccc\">506</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid506\" type=\"checkbox\" value=\"true\" " + restrict506 + "></td></tr>");
				out.println("<tr id=\"hide22\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Character data view (useless)</td><td style=\"border-top: 1px solid #cccccc\">507</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid507\" type=\"checkbox\" value=\"true\" " + restrict507 + "></td></tr>");
				out.println("<tr id=\"hide23\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Character online status (useless)</td><td style=\"border-top: 1px solid #cccccc\">508</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid508\" type=\"checkbox\" value=\"true\" " + restrict508 + "></td></tr>");
				out.println("<tr id=\"hide24\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Send mail with item to user (useless)</td><td style=\"border-top: 1px solid #cccccc\">509</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid509\" type=\"checkbox\" value=\"true\" " + restrict509 + "></td></tr>");
				out.println("<tr id=\"hide25\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">See ban history (useless)</td><td style=\"border-top: 1px solid #cccccc\">510</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid510\" type=\"checkbox\" value=\"true\" " + restrict510 + "></td></tr>");
				out.println("<tr id=\"hide26\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">See cubigold payments (useless)</td><td style=\"border-top: 1px solid #cccccc\">511</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid511\" type=\"checkbox\" value=\"true\" " + restrict511 + "></td></tr>");
				out.println("<tr id=\"hide27\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">See cubigold amount (useless)</td><td style=\"border-top: 1px solid #cccccc\">512</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid512\" type=\"checkbox\" value=\"true\" " + restrict512 + "></td></tr>");
				out.println("<tr id=\"hide28\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Add cubigold (useless)</td><td style=\"border-top: 1px solid #cccccc\">513</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid513\" type=\"checkbox\" value=\"true\" " + restrict513 + "></td></tr>");
				out.println("<tr id=\"hide29\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">View by Account username (useless)</td><td style=\"border-top: 1px solid #cccccc\">514</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid514\" type=\"checkbox\" value=\"true\" " + restrict514 + "></td></tr>");
				out.println("<tr id=\"hide30\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Edit account username (useless)</td><td style=\"border-top: 1px solid #cccccc\">515</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid515\" type=\"checkbox\" value=\"true\" " + restrict515 + "></td></tr>");
				out.println("<tr id=\"hide31\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Remove ban (useless)</td><td style=\"border-top: 1px solid #cccccc\">516</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid516\" type=\"checkbox\" value=\"true\" " + restrict516 + "></td></tr>");
				out.println("<tr id=\"hide32\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Get Role list (useless)</td><td style=\"border-top: 1px solid #cccccc\">517</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid517\" type=\"checkbox\" value=\"true\" " + restrict517 + "></td></tr>");
				out.println("<tr id=\"hide33\" style=\"display:none\"><td style=\"border-top: 1px solid #cccccc\">Change Account password (useless)</td><td style=\"border-top: 1px solid #cccccc\">518</td><td align=\"center\" style=\"border-top: 1px solid #cccccc\"><input name=\"rid518\" type=\"checkbox\" value=\"true\" " + restrict518 + "></td></tr>");

				out.println("<tr><td style=\"border-top: 1px solid #cccccc\">Show Non-Implemented Features</td><td style=\"border-top: 1px solid #cccccc\"><input type=\"checkbox\" name=\"chkbox\" onclick=\"showhidefield()\"></td><td align=\"center\" style=\"border-top: 1px solid #cccccc\">-</td></tr>");

				out.println("<tr><td colspan=\"3\" align=\"center\" style=\"border-top: 1px solid #cccccc;\"><input type=\"image\" src=\"../../include/btn_save.jpg\" style=\"border: 0px;\"></td></tr></table></form>");
			} else if(request.getParameter("process").compareTo("save") == 0)
			{
				int id = Integer.parseInt(request.getParameter("userid"));
				boolean mysqlsuccessful = true;
				try
				{
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					Connection connection = DriverManager.getConnection("jdbc:mysql://" + db_host + ":" + db_port + "/" + db_database, db_user, db_password);
					Statement statement = connection.createStatement();
					statement.executeUpdate("DELETE FROM auth WHERE userid='" + id + "' AND rid != 500 AND zoneid='1'");

					if(request.getParameter("rid0") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '0')"); }
					if(request.getParameter("rid1") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '1')"); }
					if(request.getParameter("rid2") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '2')"); }
					if(request.getParameter("rid3") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '3')"); }
					if(request.getParameter("rid4") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '4')"); }
					if(request.getParameter("rid5") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '5')"); }
					if(request.getParameter("rid6") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '6')"); }
					if(request.getParameter("rid7") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '7')"); }
					if(request.getParameter("rid8") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '8')"); }
					if(request.getParameter("rid9") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '9')"); }
					if(request.getParameter("rid10") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '10')"); }
					if(request.getParameter("rid11") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '11')"); }

					if(request.getParameter("rid100") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '100')"); }
					if(request.getParameter("rid101") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '101')"); }
					if(request.getParameter("rid102") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '102')"); }
					if(request.getParameter("rid103") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '103')"); }
					if(request.getParameter("rid104") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '104')"); }
					if(request.getParameter("rid105") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '105')"); }

					if(request.getParameter("rid200") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '200')"); }
					if(request.getParameter("rid201") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '201')"); }
					if(request.getParameter("rid202") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '202')"); }
					if(request.getParameter("rid203") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '203')"); }
					if(request.getParameter("rid204") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '204')"); }
					if(request.getParameter("rid205") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '205')"); }
					if(request.getParameter("rid206") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '206')"); }
					if(request.getParameter("rid207") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '207')"); }
					if(request.getParameter("rid208") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '208')"); }
					if(request.getParameter("rid209") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '209')"); }
					if(request.getParameter("rid210") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '210')"); }
					if(request.getParameter("rid211") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '211')"); }
					if(request.getParameter("rid212") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '212')"); }
					if(request.getParameter("rid213") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '213')"); }
					if(request.getParameter("rid214") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '214')"); }

					if(request.getParameter("rid501") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '501')"); }
					if(request.getParameter("rid502") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '502')"); }
					if(request.getParameter("rid503") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '503')"); }
					if(request.getParameter("rid504") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '504')"); }
					if(request.getParameter("rid505") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '505')"); }
					if(request.getParameter("rid506") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '506')"); }
					if(request.getParameter("rid507") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '507')"); }
					if(request.getParameter("rid508") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '508')"); }
					if(request.getParameter("rid509") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '509')"); }
					if(request.getParameter("rid510") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '510')"); }
					if(request.getParameter("rid511") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '511')"); }
					if(request.getParameter("rid512") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '512')"); }
					if(request.getParameter("rid513") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '513')"); }
					if(request.getParameter("rid514") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '514')"); }
					if(request.getParameter("rid515") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '515')"); }
					if(request.getParameter("rid516") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '516')"); }
					if(request.getParameter("rid517") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '517')"); }
					if(request.getParameter("rid518") != null) { statement.executeUpdate("INSERT INTO auth (userid, zoneid, rid) VALUES ('" + id + "', 1, '518')"); }
					log("PwAdmin: GmControl SavePermissions uid=" + id + " by " + request.getRemoteHost() + " successfully.");
				}
				catch(Exception e)
				{
					out.println("<tr><td align=\"center\" colspan=\"3\" style=\"border-top: 1px solid #cccccc\"><font color=\"#ee0000\"><b>Connection to MySQL Database Failed</b></font></td></tr>");
					out.println("<tr><td colspan=\"3\" align=\"center\" style=\"border-top: 1px solid #cccccc;\"><a href=\"index.jsp\"><img src=\"btn_back.PNG\" border=\"0\" alt=\"Back\"/></a></td></tr></table>");
					log("PwAdmin: GmControl SavePermissions uid=" + id + " by " + request.getRemoteHost() + " failed.");
					mysqlsuccessful = false;
				}
				if(mysqlsuccessful)
				{
					out.println("<tr><td align=\"center\" colspan=\"3\" style=\"border-top: 1px solid #cccccc\">Permissions applied, you may need to restart your authd for the changes to take effect.</td></tr>");
					out.println("<tr><td colspan=\"3\" align=\"center\" style=\"border-top: 1px solid #cccccc;\"><a href=\"index.jsp\"><img src=\"btn_back.PNG\" border=\"0\" alt=\"Back\"/></a></td></tr></table>");
				}
			} else
			{
				out.println("<p align=\"right\"><font color=\"#ee0000\"><b>No search terms...</b></font></p>");
			}
		}
	%>
</td></tr></table>
</td></tr>
</table>
</body>
</html>