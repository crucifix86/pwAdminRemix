<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.File"%>
<%@ page import="com.goldhuman.xml.DomParser"%>
<%@ page import="com.goldhuman.auth.AuthFilter"%>
<%@ page import="org.apache.commons.logging.LogFactory"%>
<%@ page import="com.goldhuman.util.LocaleUtil" %>
<%LogFactory.getLog("parser.jsp").info(
					"operator=" + AuthFilter.getRemoteUser(session));
%>
<%//

			request.setCharacterEncoding("GBK");

			String flag2 = request.getParameter("flag");
			if (flag2 != null && flag2.equalsIgnoreCase("save")) {
				String fname = request.getParameter("f");
				DomParser parser = new DomParser(fname);
				parser.save(request, fname);
			}

			%>



<html>
	<head>
		<title><%= LocaleUtil.getMessage(request,"include_parser_title") %></title>
		<link href="../include/style.css" rel="stylesheet" type="text/css">

	</head>
	<body>
		<%@include file="../include/header.jsp"%>
		<table border="0" width="100%" height="30" cellpadding="0" cellspacing="0" bgcolor="#6699CC">
			<tr>
				<TH colspan="2">
					<font color="white"><%= LocaleUtil.getMessage(request,"include_parser_select") %></font>
				</TH>
			</tr>
			<%File files = new File("/etc");
			String[] filelist = files.list();
			String path = files.getAbsolutePath();
			int j = 0;
			for (int i = 0; i < filelist.length; i++) {
				if (filelist[i].toLowerCase().endsWith(".xml")) {
					j++;
					String url = "parser.jsp?fname="
							+ (path + System.getProperty("file.separator") + filelist[i]);

					%>
			<tr>
				<td align="right" width="45%">
					<font color=red><%=j%>.</font>
				</td>
				<td>
					&nbsp;&nbsp;<a href="<%=url%>"><font color="yellow"><%=filelist[i]%></font></a>
				</td>
			</tr>
			<%}
			}%>
		</table>
		<form action="parser.jsp" name="form1" method="post">
			<table width="100%" height="514" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">

				<tr>
					<td>

					</td>
				</tr>


				<tr>
					<td>

						<%try {
				boolean flag = false;
				String fname = request.getParameter("fname");

				if (fname != null && fname.trim().length() > 0) {
					fname = new String(fname.getBytes("ISO-8859-1"), "GB2312");

					flag = fname.endsWith(".xml") || fname.endsWith(".XML")
							|| fname.endsWith(".Xml") || fname.endsWith(".XMl")
							|| fname.endsWith(".xMl") || fname.endsWith(".xML")
							|| fname.endsWith(".xmL");
				}
				if (flag) {

					DomParser parser = new DomParser(fname);

					out.println("<center><font color='#660000'>File:" + fname
							+ "</font><p/>");
					out.println("<input type=hidden name=f value=" + fname
							+ "/>");
					out.println(parser.getSb());

				}
			} catch (Exception e) {
				out.println("<font color=\"red\" size=\"3\">" + e.getMessage()
						+ "</font>");
			}

		%>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="submit" value="<%= LocaleUtil.getMessage(request,"include_parser_modify") %>" >
						&nbsp;
						<input type="hidden" name="flag" value="save" />
					</td>
				</tr>
			</table>
		</form>
		<%@include file="../include/foot.jsp"%>
	</body>
</html>
