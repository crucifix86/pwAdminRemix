<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@include file="../../WEB-INF/.pwadminconf.jsp"%>

<%
	String message = "<br>";
	boolean allowed = false;

	if(request.getSession().getAttribute("ssid") == null)
	{
		message = "<span style=\"color: #ffcccc; font-weight: bold;\">Login to use Live Chat...</span>";
	}
	else
	{
		allowed = true;
	}
%>

<%
	if(request.getParameter("process") != null && allowed)
	{
		if(request.getParameter("process").compareTo("delete") == 0)
		{
			try
			{
				FileWriter fw = new FileWriter(pw_server_path + "/logservice/logs/world2.chat");
				fw.close();
				message = "<span style=\"color: #aaffaa; font-weight: bold;\">Chat Log File Cleared</span>";
			}
			catch(Exception e)
			{
				message = "<span style=\"color: #ffcccc; font-weight: bold;\">Clearing Chat Log File Failed</span>";
			}
		}

		if(request.getParameter("broadcast") != null)
		{
			String broadcast = request.getParameter("broadcast");

			if(protocol.DeliveryDB.broadcast((byte)9,-1,broadcast))
			{
				message = "<span style=\"color: #aaffaa; font-weight: bold;\">Message Sent</span>";
				try
				{
					BufferedWriter bw = new BufferedWriter(new FileWriter(pw_server_path + "/logs/world2.chat", true));
					bw.write((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())) + " pwserver glinkd-0: chat : Chat: src=-1 chl=9 msg=" + Base64.encode(broadcast.getBytes("UTF-16LE")) + "\n") ;
					bw.close() ;
				}
				catch(Exception e)
				{
					message += "<br><span style=\"color: #ffcccc; font-weight: bold;\">Appending Message to Log File Failed</span>";
				}
			}
			else
			{
				message = "<span style=\"color: #ffcccc; font-weight: bold;\">Sending Message Failed</span>";
			}
		}
	}
%>

<html>

<head>
    <link rel="shortcut icon" href="../../include/fav.ico">
    <link rel="stylesheet" type="text/css" href="../../include/style.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #2c3e50;
            color: #ecf0f1;
            margin: 0;
            padding: 0;
        }

        table {
            width: 95%;
            max-width: 800px;
            margin: 20px auto;
            border-collapse: collapse;
            border: 1px solid #34495e;
            background-color: #34495e;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        th {
           background-color: #3498db;
            color: white;
            padding: 12px;
            font-size: 1.2em;
            text-align: center;
            border-bottom: 1px solid #2980b9;
        }

        td {
            padding: 10px;
            text-align: left;
            vertical-align: top; /* Align items to the top */
        }

        tr:nth-child(even) {
            background-color: #405871;
        }


        input[type="text"] {
             padding: 10px;
            width: 90%;
            margin-right: 5px;
            border: 1px solid #526a86;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #34495e;
            color: #ecf0f1;
        }
         input[type="text"]:focus {
              outline: none;
              border-color: #3498db;
        }
        input[type="image"] {
           cursor: pointer;
           transition: transform 0.3s;
        }
         input[type="image"]:hover {
           transform: scale(1.1);
        }

        a img {
             cursor: pointer;
             transition: transform 0.3s;
        }
         a img:hover {
           transform: scale(1.1);
        }
         #message-container {
            padding: 15px;
            text-align: center;
            color: #ecf0f1;
            margin-top: 10px;
            background-color: #34495e;
            border-radius: 4px;
        }
        #chat-container {
             display: flex;
             flex-direction: column;
             max-height: 300px; /* Reduced max-height */
             overflow-y: auto;
            padding: 10px;
            margin: 10px;
            border: 1px solid #526a86;
             background-color: #34495e;
            border-radius: 4px;
            box-sizing: border-box;
         }
        #chat-log {
            flex-grow: 1;
             overflow-y: auto;
          overflow-x: hidden;
           padding: 0px;
        }
         .chat-message {
            margin-bottom: 10px;
            padding: 8px;
            border-radius: 5px;
            background-color: #3a5268;
             white-space: pre-wrap;
            word-wrap: break-word;
         }
        .chat-message span.timestamp {
             font-size: 0.8em;
            color: #95a5a6;
            display: block;
           margin-bottom: 3px;
         }
        .chat-message span.message {
            color: #ecf0f1;
        }

        /* Flexbox tweaks for the form row */
        tr.form-row td{
            display: flex;
            align-items: center;
        }
         tr.form-row td:first-child {
           flex-grow: 1;
           padding-right: 5px;
        }
    </style>
</head>

<body>

    <table cellpadding="0" cellspacing="0">
        <tr>
            <th colspan="2">
                <b>LIVE CHAT</b>
            </th>
        </tr>
       <tr>
            <td colspan="2" align="center" height="1" width="100%" id="message-container">
                <% out.print(message); %>
            </td>
        </tr>
         <tr class="form-row">
            <form action="index.jsp?process=broadcast" method="post">
                 <td height="1" width="100%">
                    <input type="text" name="broadcast" value="System Message: " />
                </td>
                <td height="1" align="right" style="white-space: nowrap;">
                    <input type="image" src="../../include/btn_submit.jpg" style="border: 0;" alt="Send"></input>
                </td>
            </form>
        </tr>
        <tr>
            <td colspan="2">
                <div id="chat-container">
                    <div id="chat-log">
                    <%
                        String chatLogPath = pw_server_path + "/logs/world2.chat";
                        File chatLogFile = new File(chatLogPath);
                        if (chatLogFile.exists()) {
                             try (BufferedReader br = new BufferedReader(new FileReader(chatLogFile))) {
                               String line;
                                while ((line = br.readLine()) != null) {
                                    String[] parts = line.split(" pwserver glinkd-0: chat : Chat: src=-1 chl=9 msg=",2);
                                    if (parts.length == 2) {
                                        String timeStamp = parts[0].trim();
                                        String base64EncodedMessage = parts[1];
                                        String decodedMessage="";
                                        try {
                                          byte[] decodedBytes = Base64.decode(base64EncodedMessage);
                                          decodedMessage = new String(decodedBytes, StandardCharsets.UTF_16LE);
                                        }
                                        catch (Exception e)
                                        {
                                            decodedMessage=base64EncodedMessage;
                                        }
                                        out.println("<div class=\"chat-message\">");
                                        out.println("<span class=\"timestamp\">" + timeStamp + "</span>");
                                        out.println("<span class=\"message\">" + decodedMessage + "</span>");
                                        out.println("</div>");

                                     }else
                                    {
                                        out.println("<div class=\"chat-message\">" + line + "</div>");
                                    }
                               }
                            } catch (IOException e) {
                                out.println("<p style=\"color:red;\">Error reading chat log: " + e.getMessage() + "</p>");
                            }
                        }else {
                            out.println("<p>Chat log file not found.</p>");
                        }
                    %>
                     </div>
                </div>
            </td>
        </tr>
        <tr>
             <td colspan="2" align="center" height="1">
                <a href="index.jsp?process=delete" title="Clear The Entire Chat Log File"><img src="../../include/btn_delete.jpg" style="border: 0;" alt="Clear Chat Log"></img></a>
            </td>
        </tr>
    </table>

</body>

</html>