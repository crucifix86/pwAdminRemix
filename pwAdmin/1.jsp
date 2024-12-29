<%@page import="java.io.*"%>
<%@include file="WEB-INF/.pwadminconf.jsp"%>
<%
	String message = "<br>";
	boolean allowed = false;

	if(request.getSession().getAttribute("ssid") == null)
	{
        response.sendRedirect("index.jsp");
		return;
	}
	else
	{
		allowed = true;
	}
    if(!allowed)
    {
         response.sendRedirect("index.jsp");
        return;
    }
    Process p = null;
    int exitCode = -1;
	String command;
    File working_directory;

try{
    // 1. Start logservice
	message += "<br><b>Starting logservice...</b>";
    command = "/home/logservice/./logservice /home/logservice/logservice.conf";
    working_directory = new File("/home/logservice/");
    p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>logservice started successfully</b></font>";
	} else {
		message += "<br><font color=\"#ee0000\"><b>Failed to start logservice, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">logservice Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);


    // 2. Start authd
	message += "<br><b>Starting authd...</b>";
    command = "/home/authd/authd";
    working_directory = new File("/home/authd/");
	p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0){
		message += "<br><font color=\"#00cc00\"><b>authd started successfully</b></font>";
	} else {
		message += "<br><font color=\"#ee0000\"><b>Failed to start authd, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">authd Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);



    // 3. Start uniquenamed
	message += "<br><b>Starting uniquenamed...</b>";
    command = "/home/uniquenamed/./uniquenamed /home/uniquenamed/uniquenamed.conf";
	working_directory = new File("/home/uniquenamed/");
    p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>uniquenamed started successfully</b></font>";
	} else {
		message += "<br><font color=\"#ee0000\"><b>Failed to start uniquenamed, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">uniquenamed Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);


    // 4. Start gacd
	message += "<br><b>Starting gacd...</b>";
    command = "/home/gacd/./gacd /home/gacd/gacd.conf";
    working_directory = new File("/home/gacd/");
    p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>gacd started successfully</b></font>";
	} else {
		message += "<br><font color=\"#ee0000\"><b>Failed to start gacd, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">gacd Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);



    // 5. Start gfactiond
	message += "<br><b>Starting gfactiond...</b>";
    command = "/home/gfactiond/./gfactiond /home/gfactiond/gfactiond.conf";
	working_directory = new File("/home/gfactiond/");
	p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>gfactiond started successfully</b></font>";
	}
    else
    {
		message += "<br><font color=\"#ee0000\"><b>Failed to start gfactiond, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">gfactiond Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);

    // 6. Start gdeliveryd
	message += "<br><b>Starting gdeliveryd...</b>";
    command = "/home/gdeliveryd/./gdeliveryd /home/gdeliveryd/gdeliveryd.conf";
    working_directory = new File("/home/gdeliveryd/");
	p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>gdeliveryd started successfully</b></font>";
	}
    else
    {
		message += "<br><font color=\"#ee0000\"><b>Failed to start gdeliveryd, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">gdeliveryd Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);


    // 7. Start glinkd
	message += "<br><b>Starting glinkd...</b>";
    command = "/home/glinkd/./glinkd /home/glinkd/glinkd.conf";
	working_directory = new File("/home/glinkd/");
	p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>glinkd started successfully</b></font>";
	} else {
		message += "<br><font color=\"#ee0000\"><b>Failed to start glinkd, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">glinkd Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);


	// 8. Start gamedbd
	message += "<br><b>Starting gamedbd...</b>";
    command = "/home/gamedbd/./gamedbd /home/gamedbd/gamesys.conf exportclsconfig";
	working_directory = new File("/home/gamedbd/");
    p = Runtime.getRuntime().exec(command, null, working_directory);
	p.waitFor();
	exitCode = p.exitValue();
	if(exitCode == 0)
	{
		message += "<br><font color=\"#00cc00\"><b>gamedbd started successfully</b></font>";
	} else {
		message += "<br><font color=\"#ee0000\"><b>Failed to start gamedbd, Exit code: " + exitCode + "</b></font>";
		BufferedReader errorReader = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		String errorLine;
		while ((errorLine = errorReader.readLine()) != null) {
			message += "<br><font color=\"#ee0000\">gamedbd Error: " + errorLine + "</font>";
		}
		errorReader.close();
	}
    if(p != null)
    {
        p.destroy();
        p = null;
    }
	Thread.sleep(1000);



	message += "<br><font color=\"#00cc00\"><b>All Processes Started</b></font>";

} catch (Exception e) {
    message = "<font color=\"#ee0000\"><b>Starting Server Processes Failed</b></font>";
    message += "<br><font color=\"#ee0000\"><b>Error:</b></font> " + e.getMessage();
}
finally {
		if(p != null)
			p.destroy();
}


%>
<html>
<head>
    <title>Starting Server Processes</title>
     <link rel="stylesheet" type="text/css" href="include/style.css">
</head>
<body>
    <center>
        <h2>Server Process Startup</h2>
        <%= message %>
        <br>
        <a href="index.jsp">Go Back</a>
    </center>
</body>
</html>