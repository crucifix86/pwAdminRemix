<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.security.*"%>
<%@include file="WEB-INF/.pwadminconf.jsp"%>

<%!
    String encode(String salt, MessageDigest alg)
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
        return hashedpasswd.toString();
    }
%>

<style>
    body {
        background-color: #333; /* Dark background */
        color: #eee; /* Light text */
    }
    .login-container {
        width: 350px;
        margin: 100px auto;
        padding: 20px;
        border: 1px solid #555; /* Darker border */
        border-radius: 5px;
        background-color: #444; /* Darker container */
    }
    .login-container h2 {
        text-align: center;
        margin-bottom: 20px;
    }
    .login-form label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .login-form input[type="text"],
    .login-form input[type="password"] {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #777; /* Darker input border */
        border-radius: 3px;
        background-color: #555; /* Darker input background */
        color: #eee; /* Light text for inputs */
    }
    .login-form input[type="image"] {
        display: block;
        margin: 10px auto;
        border: 0px;
    }
	.logout-button {
		display: block;
        margin: 10px auto;
	}
	.error-message {
        color: #ff0000;
        text-align: center;
        margin-bottom: 10px;
    }
    .return-button {
       display: block;
       margin: 10px auto;
       text-align: center;
       padding: 10px 15px;
       background-color: #666; /* a light gray, can adjust to your taste */
       color: white;
       border: none;
       border-radius: 5px;
       text-decoration: none;
       cursor: pointer;
    }
    .return-button:hover {
       background-color: #888; /* darken on hover*/
    }
</style>

<div class="login-container">
    <h2>Admin Login</h2>
    <%
        String errorMessage = "";
		String loginPageUrl = request.getContextPath() + "/index.jsp?page=login";

        if(request.getParameter("logout") != null && request.getParameter("logout").compareTo("true") == 0)
        {
            request.getSession().removeAttribute("ssid");
            request.getSession().removeAttribute("items");
        }

         if(request.getMethod().equalsIgnoreCase("POST"))
       {
           if(request.getParameter("username") != null && request.getParameter("password") != null)
            {
                 String enteredUsername = request.getParameter("username");
                String enteredPassword = request.getParameter("password");

               // initial change of username "admin" in configuration file
               if("21232f297a57a5a743894a0e4a801fc3".compareTo(iweb_username) == 0 || "21232f297a57a5a743894a0e4a801fc3".compareTo(iweb_password) == 0)
                {
                     iweb_username = encode(enteredUsername, MessageDigest.getInstance("MD5"));

                     Vector<String> lines = new Vector<String>();
                     String line;
                     BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(request.getRealPath("/") + "/WEB-INF/.pwadminconf.jsp")));
                     while((line = br.readLine()) != null)
                     {
                         if(line.contains("iweb_username") && line.contains("21232f297a57a5a743894a0e4a801fc3"))
                         {
                             line = line.replaceAll("21232f297a57a5a743894a0e4a801fc3", iweb_username);
                         }
                          if(line.contains("iweb_password") && line.contains("21232f297a57a5a743894a0e4a801fc3"))
                         {
                            line = line.replaceAll("21232f297a57a5a743894a0e4a801fc3", iweb_password);
                         }
                         lines.add(line);
                     }
                    br.close();

                    BufferedWriter bw = new BufferedWriter(new FileWriter(request.getRealPath("/") + "/WEB-INF/.pwadminconf.jsp"));
                    for(int i=0; i<lines.size(); i++)
                    {
                        bw.write(lines.get(i) + "\n");
                    }
                    bw.close();
                }


                 if (encode(enteredUsername, MessageDigest.getInstance("MD5")).compareTo(iweb_username) == 0 &&
                     encode(enteredPassword, MessageDigest.getInstance("MD5")).compareTo(iweb_password) == 0)
                   {
                        request.getSession().setAttribute("ssid", request.getRemoteAddr());
						out.println("<a href=\"" + request.getContextPath() + "/index.jsp\" class=\"return-button\">Return to Panel</a>");
                   }else
                  {
                    errorMessage = "<p class=\"error-message\">Invalid username or password.</p>";
                }
            }
        }


         if(request.getSession().getAttribute("ssid") == null)
        {
             out.println("<form action=\"" + loginPageUrl + "\" method=\"post\" class=\"login-form\">");
             out.println(errorMessage);
             out.println("<label for=\"username\">Username:</label>");
             out.println("<input type=\"text\" id=\"username\" name=\"username\" required>");
             out.println("<label for=\"password\">Password:</label>");
             out.println("<input type=\"password\" id=\"password\" name=\"password\" required>");
             out.println("<input type=\"image\" src=\"include/btn_login.jpg\"  style=\"border: 0px;\"></input>");
             out.println("</form>");
        }
        else
        {
            out.println("<a href=\"index.jsp?page=login&logout=true\" class=\"logout-button\"><img src=\"include/btn_logout.jpg\" border=\"0\"></img></a>");
        }
    %>
</div>