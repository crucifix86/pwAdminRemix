<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <link rel="shortcut icon" href="include/fav.ico">
    <link rel="stylesheet" type="text/css" href="include/style.css">
    <link rel="stylesheet" type="text/css" href="include/menu.css">
      <style>
        body {
            background-color: #1a1a1a;
            color: #eee;
            margin: 10px;
            font-family: sans-serif;
        }

        .nav-button {
            display: inline-block;
            padding: 10px 16px;
            text-decoration: none;
            color: #ddd;
            font-weight: 500;
            border: 1px solid transparent;
            border-radius: 6px;
            transition: background-color 0.3s, color 0.3s;
        }

        .nav-button:hover,
        .nav-button:focus {
            background-color: #333;
            color: #fff;
            border-color: #555;
            outline: none;
        }

        .nav-button.active {
            background-color: #555;
            color: #fff;
        }

        #header {
            background-color: #2a2a2a;
            padding: 15px 0;
            border-bottom: 1px solid #555;
            margin-bottom: 10px;
             display: flex;
             flex-direction: column; /* Stack the banner and nav */
             align-items: center; /* Center horizontally */
        }

        #banner {
            max-width: 100%; /* Adjust as needed */
            height: auto;
            margin-bottom: 10px;
        }


        #logo {
            font-size: 2em;
            font-weight: bold;
            color: #eee;
            text-decoration: none;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .menu-container {
            display: flex;
            align-items: center;
        }

        .menu-container li {
            list-style-type: none;
            margin-right: 10px;
        }

        .menu-container>li:last-child {
            margin-right: 0px;
        }

        #sub_plugins {
            display: none;
            position: absolute;
            background-color: #3498db;
            border: 1px solid #54a0d2;
            padding: 5px 0;
            min-width: 200px;
            z-index: 1000;
            margin-top: 5px;
            border-radius: 4px;
        }

        #sub_plugins li {
            list-style-type: none;
        }

        #sub_plugins li a {
            display: block;
            padding: 8px 15px;
            text-decoration: none;
            color: #fff;
        }

        #sub_plugins li a:hover {
            background-color: #2980b9;
        }

        #menu {
            padding: 0;
            margin: 0;
        }

        .menu-container li:hover>#sub_plugins {
            display: block;
        }

        .menu-container li a {
             opacity: 0.7;
        }

        .nav-button+td {
            padding-left: 8px;
        }

        .nav-button+td+td {
            padding-left: 0;
        }

        #content {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 20px;
        }

        #content iframe {
            pointer-events: auto;
        }

        /* New styles for the login overlay */
        #loginOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            /* Semi-transparent black background */
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            /* Ensure it's on top */
         }

        #loginBox {
            background-color: #333;
            padding: 30px;
            border-radius: 8px;
            max-width: 400px;
            text-align: center;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.75);
        }

        #loginBox input[type="text"],
        #loginBox input[type="password"],
        #loginBox input[type="submit"] {
            display: block;
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #555;
            border-radius: 4px;
            background-color: #444;
            color: #eee;
            transition: border-color 0.3s;
            box-sizing: border-box;
            outline: none;
        }

        #loginBox input[type="submit"] {
            background-color: #3498db;
            color: white;
            cursor: pointer;
        }

        #loginBox input[type="submit"]:hover {
            background-color: #2980b9;
        }

        #loginBox input:focus {
            border-color: #2980b9;
        }
        /* General Styles */
       #mainContent {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #2a2a2a;
            border: 1px solid #555;
            border-radius: 8px;
             box-sizing: border-box;
        }

         /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th,
        td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #555;
        }

        th {
            background-color: #333;
            color: #ddd;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #333;
        }

        tr:hover {
            background-color: #383838;
        }
        /* Button styles */
        input[type="button"],
        input[type="submit"],
        button {
          padding: 10px 16px;
          text-decoration: none;
           color: #ddd;
          background-color: #3498db;
          font-weight: 500;
          border: 1px solid transparent;
          border-radius: 6px;
          transition: background-color 0.3s, color 0.3s;
          cursor: pointer;
        }
        input[type="button"]:hover,
        input[type="submit"]:hover,
        button:hover{
            background-color: #2980b9;
              color: #fff;
        }
         input[type="button"]:focus,
        input[type="submit"]:focus,
        button:focus{
            outline: none;
        }

        /* Input Styles */
        input[type="text"],
        input[type="number"],
        input[type="password"],
        select
         {
            display: block;
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #555;
            border-radius: 4px;
            background-color: #444;
            color: #eee;
            transition: border-color 0.3s;
            box-sizing: border-box;
            outline: none;
        }
         input:focus{
             border-color: #2980b9;
        }
         textarea {
            display: block;
            width: calc(100% - 22px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #555;
            border-radius: 4px;
            background-color: #444;
            color: #eee;
            transition: border-color 0.3s;
            box-sizing: border-box;
            outline: none;
            resize: vertical;
        }
        textarea:focus {
            border-color: #2980b9;
        }
    </style>
</head>

<body>
        <%
         boolean isLoggedIn = session.getAttribute("ssid") != null;
     %>
    <header id="header">
        <img id="banner" src="include/banner.jpg" alt="Banner">
        <div class="container">

            <a href="index.jsp" id="logo">PWADMIN</a>
            <nav class="menu-container" id="mainNav">
                <a href="index.jsp?page=account"
                    class="nav-button <%=(request.getParameter("page") != null && request.getParameter("page").equals("account")) ? "active" : "" %>"
                    <% if(!isLoggedIn){ %>style="pointer-events:none;opacity:0.7;"<%}%>>ACCOUNTS</a>
                <a href="index.jsp?page=role"
                    class="nav-button <%=(request.getParameter("page") != null && (request.getParameter("page").equals("role") || request.getParameter("page").equals("rolexml"))) ? "active" : "" %>"
                    <% if(!isLoggedIn){ %>style="pointer-events:none;opacity:0.7;"<%}%>>CHARACTERS</a>
                <a href="index.jsp?page=server"
                    class="nav-button <%=(request.getParameter("page") != null && request.getParameter("page").equals("server")) ? "active" : "" %>"
                    <% if(!isLoggedIn){ %>style="pointer-events:none;opacity:0.7;"<%}%>>SERVER
                    CONFIGURATION</a>
                <a href="index.jsp?page=serverctrl"
                    class="nav-button <%=(request.getParameter("page") != null && request.getParameter("page").equals("serverctrl")) ? "active" : "" %>"
                    <% if(!isLoggedIn){ %>style="pointer-events:none;opacity:0.7;"<%}%>>SERVER
                    CONTROL</a>
                <ul id="menu" class="menu-container">
                    <li>
                        <a href="index.jsp?plugin=" class="nav-button"
                            <% if(!isLoggedIn){ %>style="pointer-events:none;opacity:0.7;"<%}%>>ADDONS ?</a>

                        <ul id="sub_plugins">
                            <%
                                File addonsDir = new File(request.getRealPath("addons"));
                                String[] addonFolders = addonsDir.list((current, name) -> new File(current, name).isDirectory()); // filter for directories only
                                java.util.Arrays.sort(addonFolders);

                                if (addonFolders != null && addonFolders.length > 0) {
                                    for (String addonFolder : addonFolders) {
                                        // Generate links with "plugin" parameter.
                                        out.print("<li><a href=\"index.jsp?plugin=" + addonFolder + "\"><b>?</b> " + addonFolder + "</a></li>");
                                    }
                                }
                            %>
                            <li style="border-top: 1px solid #cccccc;"><a
                                    href="http://pwadmin.codeplex.com/Thread/List.aspx">Search
                                    Plugins...</a></li>
                        </ul>
                    </li>
                </ul>

            </nav>
            <div style="padding-left: 20px;">
                <% if(isLoggedIn){ %>
                   <a href="index.jsp?logout=true"><img src="include/btn_logout.jpg" border="0" style="padding-left: 8px; padding-top: 8px;"/></a>
                <% } %>
            </div>
        </div>
    </header>
    <main id="content" <% if(!isLoggedIn){ %>style="pointer-events:none;"<%}%>>