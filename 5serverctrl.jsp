<%@page import="java.io.*"%>
<%@page import="java.text.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.Calendar.*"%>
<%@include file="WEB-INF/.pwadminconf.jsp"%>

<%
    String message = "<br>";
    boolean allowed = false;

    if(request.getSession().getAttribute("ssid") == null)
    {
        out.println("<p align=\"right\"><font color=\"#ee0000\"><b>Login for Server control...</b></font></p>");
    }
    else
    {
        allowed = true;
    }

    // Apply changes
    if(request.getParameter("process") != null && allowed)
    {
        Process p;
        String command;
        File working_directory;

        if(request.getParameter("process").compareTo("stopserver") == 0)
        {
            try
            {
                command = pw_server_path + "gamedbd/./gamedbd " + pw_server_path + "gamedbd/gamesys.conf exportclsconfig";
                working_directory = new File(pw_server_path + "gamedbd/");
                p = Runtime.getRuntime().exec(command, null, working_directory);
                p.waitFor();
                Thread.sleep(1000);

                Runtime.getRuntime().exec("pkill -9 gs");
                Runtime.getRuntime().exec("pkill -9 glinkd");
                Runtime.getRuntime().exec("pkill -9 gdeliveryd");
                Runtime.getRuntime().exec("pkill -9 gfactiond");
                Runtime.getRuntime().exec("pkill -9 gacd");
                Runtime.getRuntime().exec("pkill -9 gamedbd");
                Runtime.getRuntime().exec("pkill -9 uniquenamed");
                Runtime.getRuntime().exec("pkill -9 authd");
                Runtime.getRuntime().exec("pkill -9 logservice");
                Runtime.getRuntime().exec("sync");
// drop_caches -> permission denied
//                FileWriter fw = new FileWriter(new File("/proc/sys/vm/drop_caches"));
//                fw.write("3");
//                fw.close();

                Thread.sleep(6000);

                message = "<font color=\"#00cc00\"><b>Server Turned Off</font>";
            }
            catch(Exception e)
            {
                message = "<font color=\"#ee0000\"><b>Turning Off Server Failed</b></font>";
            }
        }

        if(request.getParameter("process").compareTo("startserver") == 0)
        {
            File f = new File(pw_server_path + "iweb_starter.sh");
            try
            {
                command = pw_server_path + "server start";
                working_directory = new File(pw_server_path);
                Runtime.getRuntime().exec("chmod 777 " + pw_server_path + "server");
                Runtime.getRuntime().exec(command, null, working_directory);

                // Start authd with specific path
                String authdCommand = "/home/authd/./authd";
                File authdWorkingDirectory = new File("/home/authd");
                Runtime.getRuntime().exec(authdCommand, null, authdWorkingDirectory);

                Thread.sleep(30000);

                message = "<font color=\"#00cc00\"><b>Server is Starting Up... it could take some minutes till server is fully up and //running</font>";
            }
            catch(Exception e)
            {
                f.delete();
                message = "<font color=\"#ee0000\"><b>Starting Up Server Failed </b></font>" + e.getMessage();
            }
        }

        if(request.getParameter("process").compareTo("stopallmaps") == 0)
        {
            try
            {
                int time = Integer.parseInt(request.getParameter("time"));
                if(protocol.DeliveryDB.GMRestartServer(-1, time))
                {
                    message = "<font color=\"#00cc00\"><b>All Maps will be stopped in " + time + " seconds</font>";
                }
                else
                {
                    message = "<font color=\"#ee0000\"><b>Setting Timer to stop Maps Failed</b></font>";
                }
            }
            catch(Exception e)
            {
                message = "<font color=\"#ee0000\"><b>Setting Timer to stop Maps Failed</b></font>";
            }
        }

        if(request.getParameter("process").compareTo("stopmap") == 0)
        {
            try
            {
                String[] maps = request.getParameterValues("map");
                for(int i=0; i<maps.length; i++)
                {
                    Runtime.getRuntime().exec("kill " +  maps[i]);
                    Thread.sleep(1000);
                }
                message = "<font color=\"#00cc00\"><b>Map(s) Stopped</b></font>";
            }
            catch(Exception e)
            {
                message = "<font color=\"#ee0000\"><b>Stopping Map(s) Failed</b></font>";
            }
        }

        if(request.getParameter("process").compareTo("startmap") == 0)
        {
            File f = new File(pw_server_path + "iweb_map.sh");
            try
            {
                String[] maps = request.getParameterValues("map");
                FileWriter fw = new FileWriter(f);
                for(int i = 0; i < maps.length; i++)
                {
                    fw.write("cd " + pw_server_path + "gamed; ./gs " + maps[i] + " > /dev/null 2>&1 &\n");
                    fw.write("sleep 1\n");
                }
                fw.write("rm foo\n");
                fw.write("sleep 1");
                fw.close();

                command = "sh " + pw_server_path + "./iweb_map.sh";
                working_directory = new File(pw_server_path);
                Runtime.getRuntime().exec("chmod 755 " + pw_server_path + "iweb_map.sh");
                Runtime.getRuntime().exec(command, null, working_directory);
                Thread.sleep(1000*maps.length+1);
                //f.delete();
                message = "<font color=\"#00cc00\"><b>Map(s) Started</b></font>";
            }
            catch(Exception e)
            {
                f.delete();
                message = "<font color=\"#ee0000\"><b>Starting Map(s) Failed</b></font>";
            }
        }

        if(request.getParameter("process").compareTo("backup") == 0)
        {
            // Check if another Backup is running

            String line;
            boolean backup_allowed = true;
            p = Runtime.getRuntime().exec("ps -A w");
            BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while((line = input.readLine()) != null)
            {
                if(line.substring(27).indexOf("/./pw_backup.sh") != -1)
                {
                    backup_allowed = false;
                }
            }
            input.close();

            if(backup_allowed)
            {
                File f = new File(pw_server_path + "pw_backup.sh");
                try
                {
                    String time = (new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss")).format(new java.util.Date());
                    FileWriter fw = new FileWriter(f);
                    fw.write("cd " + pw_server_path + "\n");
                    fw.write("mysqldump -u" + db_user + " -p" + db_password + " " + db_database + " --routines > " + pw_server_path + "pw_backup_" + time + ".sql\n");
                    fw.write("sleep 1\n");
                    fw.write("tar -zcf " + pw_server_path + "pw_backup_" + time + ".tar.gz " + pw_server_path + " --exclude=pw_backup*\n");
                    fw.write("sleep 1\n");
// drop_caches -> permission denied
//                    fw.write("sync; echo 3 > /proc/sys/vm/drop_caches");
fw.write("sync");
                    fw.close();

                    command = "sh " + pw_server_path + "./pw_backup.sh";
                    working_directory = new File(pw_server_path);
                    Runtime.getRuntime().exec("chmod 755 " + pw_server_path + "pw_backup.sh");
                    Runtime.getRuntime().exec(command, null, working_directory);

                    Thread.sleep(3000);

                    f.delete();
                    message = "<font color=\"#00cc00\"><b>Backup Started -> " + pw_server_path + "pw_backup_" + time + "</b></font>";
                }
                catch(Exception e)
                {
                    f.delete();
                    message = "<font color=\"#ee0000\"><b>Backup Failed</b></font>";
                }
            }
        }
    }


    // Load

    // maps[*][0] -> process ID / pid
    // maps[*][1] -> map id
    // maps[*][2] -> map name
    String[][] maps;
    if(item_labels.compareTo("pwi") == 0)
    {
        String[][] m =
        {
            {"0", "gs01", "World"},
            {"0", "is01", "City of Abominations"},
            {"0", "is02", "Secret Passage"},
            {"0", "is05", "Firecrag Grotto"},
            {"0", "is06", "Den of Rabid Wolves"},
            {"0", "is07", "Cave of the Vicious"},
            {"0", "is08", "Hall of Deception"},
            {"0", "is09", "Gate of Delirium"},
            {"0", "is10", "Secret Frostcover Grounds"},
            {"0", "is11", "Valley of Disaster"},
            {"0", "is12", "Forest Ruins"},
            {"0", "is13", "Cave of Sadistic Glee"},
            {"0", "is14", "Wraithgate"},
            {"0", "is15", "Hallucinatory Trench"},
            {"0", "is16", "Eden"},
            {"0", "is17", "Brimstone Pit"},
            {"0", "is18", "Temple of the Dragon"},
            {"0", "is19", "Nightscream Island"},
            {"0", "is20", "Snake Isle"},
            {"0", "is21", "Lothranis"},
            {"0", "is22", "Momaganon"},
            {"0", "is23", "Seat of Torment"},
            {"0", "is24", "Abaddon"},
            {"0", "is25", "Warsong City"},
            {"0", "is26", "Palace of Nirvana"},
            {"0", "is27", "Lunar Glade"},
            {"0", "is28", "Valley of Reciprocity"},
            {"0", "is29", "Frostcover City"},
            {"0", "is31", "Twilight Temple"},
            {"0", "is32", "Cube of Fate"},
            {"0", "is33", "Chrono City"},
            {"0", "is34", "Perfect Chapel"},
            {"0", "is35", "Guild Base"},
            {"0", "is37", "Morai"},
            {"0", "is38", "Phoenix Valley"},
            {"0", "is39", "Endless Universe"},
            {"0", "is40", "Blighted Chamer"},
            {"0", "is41", "Endless Universe"},
            {"0", "is42", "Wargod Gulch"},
            {"0", "is43", "Five Emperors"},
            {"0", "is44", "Nation War 2"},
            {"0", "is45", "Nation Wa TOWER"},
            {"0", "is46", "Nation War CRYSTAL"},
            {"0", "is47", "Sunset Valley"},
            {"0", "is48", "Shutter Palace"},
            {"0", "is49", "Dragon Hidden Den"},
            {"0", "is50", "Realm of Reflection"},
            {"0", "is61", "startpoint"},
            {"0", "is62", "Origination"},
            {"0", "is63", "Primal World"},
            {"0", "is66", "Flowsilver Palace"},
            {"0", "is67", "Undercurrent Hall"},
            {"0", "is68", "Mortal Realm"},
            {"0", "is69", "LightSail Cave"},
            {"0", "is70", "Cube of Fate (2)"},
            {"0", "is71", "dragon counqest"},
            {"0", "is72", "heavenfall temple"},
            {"0", "is73", "heavenfall temple"},
            {"0", "is74", "heavenfall temple"},
            {"0", "is75", "heavenfall temple"},
            {"0", "is76", "Uncharted Paradise"},
            {"0", "is77", "Thurs Fights Cross"},
            {"0", "is78", "Western Steppes"},
            {"0", "is80", "Homestead"},
            {"0", "is81", "Homestead"},
            {"0", "is82", "Homestead"},
            {"0", "is83", "Homestead"},
            {"0", "rand03", "quicksand maze"},
            {"0", "rand04", "quicksand maze"},
            {"0", "bg01", "Territory War T-3 PvP"},
            {"0", "bg02", "Territory War T-3 PvE"},
            {"0", "bg03", "Territory War T-2 PvP"},
            {"0", "bg04", "Territory War T-2 PvE"},
            {"0", "bg05", "Territory War T-1 PvP"},
            {"0", "bg06", "Territory War T-1 PvE"},
            {"0", "arena01", "Etherblade Arena"},
            {"0", "arena02", "Lost Arena"},
            {"0", "arena03", "Plume Arena"},
            {"0", "arena04", "Archosaur Arenas"}
        };
        maps = m;
    }
    else
    {
        String[][] m =
        {
            {"0", "gs01", "World"},
            {"0", "is01", "City of Abominations"},
            {"0", "is02", "Secret Passage"},
            {"0", "is05", "Firecrag Grotto"},
            {"0", "is06", "Den of Rabid Wolves"},
            {"0", "is07", "Cave of the Vicious"},
            {"0", "is08", "Hall of Deception"},
            {"0", "is09", "Gate of Delirium"},
            {"0", "is10", "Secret Frostcover Grounds"},
            {"0", "is11", "Valley of Disaster"},
            {"0", "is12", "Forest Ruins"},
            {"0", "is13", "Cave of Sadistic Glee"},
            {"0", "is14", "Wraithgate"},
            {"0", "is15", "Hallucinatory Trench"},
            {"0", "is16", "Eden"},
            {"0", "is17", "Brimstone Pit"},
            {"0", "is18", "Temple of the Dragon"},
            {"0", "is19", "Nightscream Island"},
            {"0", "is20", "Snake Isle"},
            {"0", "is21", "Lothranis"},
            {"0", "is22", "Momaganon"},
            {"0", "is23", "Seat of Torment"},
            {"0", "is24", "Abaddon"},
            {"0", "is25", "Warsong City"},
            {"0", "is26", "Palace of Nirvana"},
            {"0", "is27", "Lunar Glade"},
            {"0", "is28", "Valley of Reciprocity"},
            {"0", "is29", "Frostcover City"},
            {"0", "is31", "Twilight Temple"},
            {"0", "is32", "Cube of Fate"},
            {"0", "is33", "Chrono City"},
            {"0", "is34", "Perfect Chapel"},
            {"0", "is35", "Guild Base"},
            {"0", "is37", "Morai"},
            {"0", "is38", "Phoenix Valley"},
            {"0", "is39", "Endless Universe"},
            {"0", "is40", "Blighted Chamer"},
            {"0", "is41", "Endless Universe"},
            {"0", "is42", "Wargod Gulch"},
            {"0", "is43", "Five Emperors"},
            {"0", "is44", "Nation War 2"},
            {"0", "is45", "Nation Wa TOWER"},
            {"0", "is46", "Nation War CRYSTAL"},
            {"0", "is47", "Sunset Valley"},
            {"0", "is48", "Shutter Palace"},
            {"0", "is49", "Dragon Hidden Den"},
            {"0", "is50", "Realm of Reflection"},
            {"0", "is61", "startpoint"},
            {"0", "is62", "Origination"},
            {"0", "is63", "Primal World"},
            {"0", "is66", "Flowsilver Palace"},
            {"0", "is67", "Undercurrent Hall"},
            {"0", "is68", "Mortal Realm"},
            {"0", "is69", "LightSail Cave"},
            {"0", "is70", "??????? ??? ????? ?????????"},
            {"0", "is71", "dragon counqest"},
            {"0", "is72", "heavenfall temple"},
            {"0", "is73", "heavenfall temple"},
            {"0", "is74", "heavenfall temple"},
            {"0", "is75", "heavenfall temple"},
            {"0", "random03", "quicksand maze"},
            {"0", "random04", "quicksand maze (?) (instance)"},
            {"0", "bg01", "Territory War T-3 PvP"},
            {"0", "bg02", "Territory War T-3 PvE"},
            {"0", "bg03", "Territory War T-2 PvP"},
            {"0", "bg04", "Territory War T-2 PvE"},
            {"0", "bg05", "Territory War T-1 PvP"},
            {"0", "bg06", "Territory War T-1 PvE"},
            {"0", "arena01", "Etherblade Arena"},
            {"0", "arena02", "Lost Arena"},
            {"0", "arena03", "Plume Arena"},
            {"0", "arena04", "Archosaur Arenas"}
        };
        maps = m;
    }

    boolean server_running = false;
    boolean backup_running = false;
    int log_count = 0;
    int auth_count = 0;
    int unique_count = 0;
    int gac_count = 0;
    int gfaction_count = 0;
    int gdelivery_count = 0;
    int glink_count = 0;
    int gamedb_count = 0;
    int map_count = 0;
    String[] mem;
    String[] swp;
    String line;
    String process;
    Process p;
    BufferedReader input;

    p = Runtime.getRuntime().exec("free -m");
    input = new BufferedReader(new InputStreamReader(p.getInputStream()));
    input.readLine();
    mem = input.readLine().split("\\s+");
    //input.readLine();
    swp = input.readLine().split("\\s+");
    input.close();

    p = Runtime.getRuntime().exec("ps -A w");
    input = new BufferedReader(new InputStreamReader(p.getInputStream()));
    while((line = input.readLine()) != null)
    {
        process = line.substring(27);

        if(process.indexOf("./pw_backup.sh") != -1)
        {
            message += "<br><font color=\"#ee0000\"><b>A Server Backup is Running please wait until Backup is finished!<br>Click <a href=\"index.jsp?page=serverctrl\"><font color=\"#0000cc\">here</font></a> from Time to Time until this Message disappears...</b></font>";
        }

        if(process.indexOf("./logservice") != -1)
        {
            log_count++;
            server_running = true;
        }
        if(process.indexOf("./authd") != -1) // Changed check to authd
        {
            auth_count++;
            server_running = true;
        }
        if(process.indexOf("./uniquenamed") != -1)
        {
            unique_count++;
            server_running = true;
        }
        if(process.indexOf("./gacd") != -1)
        {
            gac_count++;
            server_running = true;
        }
        if(process.indexOf("./gfactiond") != -1)
        {
            gfaction_count++;
            server_running = true;
        }
        if(process.indexOf("./gdeliveryd") != -1)
        {
            gdelivery_count++;
            server_running = true;
        }
        if(process.indexOf("./glinkd") != -1)
        {
            glink_count++;
        }
        if(process.indexOf("./gamedb") != -1)
        {
            gamedb_count++;
            server_running = true;
        }

        // Check running maps
        for(int i=0; i<maps.length; i++)
        {
            if (process.indexOf("./gs " + maps[i][1]) != -1)
            {
                // set the process id
                maps[i][0] = line.substring(0, 5).replace(" ", "");
                map_count++;
                server_running = true;
            }
        }
    }
    input.close();
%>

<table width="800" cellpadding="0" cellspacing="0" border="0">

<tr>
    <td align="center" colspan="2">
        <%= message %>
    </td>
</tr>

<tr>
    <td colspan="2">
        <br>
    </td>
</tr>

<tr>
<td align="center" valign="top">

    <table width="380" cellpadding="2" cellspacing="0" style="border: 1px solid #cccccc;">
        <tr>
            <th colspan="4" style="padding: 5;">
                <b>SERVICES</b>
            </th>
        </tr>
        <tr bgcolor="#f0f0f0">
            <td>
                <b>Memory Usage (MB)</b>
            </td>
            <td align="center">
                <b>Total<b>
            </td>
            <td align="center">
                <b>Used<b>
            </td>
            <td align="center">
                <b>Free<b>
            </td>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                RAM:
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
            <%
                out.println(mem[1]);
            %>
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
            <%
                out.println(mem[2]);
            %>
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
            <%
                out.println(mem[3]);
            %>
            </td>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Swap:
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
            <%
                out.println(swp[1]);
            %>
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
            <%
                out.println(swp[2]);
            %>
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
            <%
                out.println(swp[3]);
            %>
            </td>
        </tr>
        <tr bgcolor="#f0f0f0">
            <td style="border-top: 1px solid #cccccc;">
                <b>Service Description</b>
            </td>
            <td style="border-top: 1px solid #cccccc;">
                <b>Process</b>
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
                <b>#</b>
            </td>
            <td align="center" style="border-top: 1px solid #cccccc;">
                <b>Status</b>
            </td>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Logservice
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./logservice
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + log_count + "</td>");
                if(log_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Auth Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./authd
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + auth_count + "</td>");
                if(auth_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Unique Name Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./uniquenamed
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + unique_count + "</td>");
                if(unique_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Game Anti-Cheat Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./gacd
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + gac_count + "</td>");
                if(gac_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Faction Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./gfactiond
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + gfaction_count + "</td>");
                if(gfaction_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Game Delivery Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./gdeliveryd
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + gdelivery_count + "</td>");
                if(gdelivery_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Game Link Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./glinkd
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + glink_count + "</td>");
                if(glink_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Game Database Daemon
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./gamedbd
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + gamedb_count + "</td>");
                if(gamedb_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td style="border-top: 1px solid #cccccc;">
                Map Service
            </td>
            <td style="border-top: 1px solid #cccccc;">
                ./gs
            </td>
            <%
                out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\">" + map_count + "</td>");
                if(map_count > 0)
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#00cc00\">Online</font></td>");
                }
                else
                {
                    out.println("<td align=\"center\" style=\"border-top: 1px solid #cccccc;\"><font color=\"#ee0000\">Offline</font></td>");
                }
            %>
        </tr>
        <tr>
            <td colspan=4" align="center" style="border-top: 1px solid #cccccc;">
            <form action="index.jsp?page=serverctrl" method="post" style="margin: 0px;">
            <table cellpadding="0" cellspacing="0" border="0">
            <tr>
            <%
                if(allowed)
                {
                    if(server_running)
                    {
                        out.print("<td style=\"padding-right: 2px;\"><input type=\"hidden\" name=\"process\" value=\"stopserver\"></input>");
                        out.print("<input type=\"image\" src=\"include/btn_stop.jpg\"  style=\"border: 0px;\"></input>");
                    }
                    else
                    {
                        out.print("<td><input type=\"hidden\" name=\"process\" value=\"startserver\"></input>");
                        out.print("<input type=\"image\" src=\"include/btn_start.jpg\"  style=\"border: 0px;\"></input></td>");
                    }
                   					out.print("<td style=\"padding-left: 2px;\"><a href=\"index.jsp?page=serverctrl&process=backup\"><img src=\"include/btn_backup.jpg\" border=\"0\"></img></a></td>");
				}
			%>
			</tr>
			</table>
			</form>
			</td>
		</tr>
	</table>
</td>

<td align="center" valign="top">

	<table width="380" cellpadding="2" cellspacing="0"  style="border: 1px solid #cccccc;">
		<tr>
			<th colspan="2" style="padding: 5;">
				<b>MAPS</b>
			</th>
		</tr>
		<tr bgcolor="#f0f0f0">
			<td align="center" colspan="2" style="border-top: 1px solid #cccccc;">
				<b>Stop all Maps softly<b>
			</td>
		</tr>
		<tr>
			<td align="left">
				Delay (seconds):
			</td>
			<td align="right">
				<form action="index.jsp?page=serverctrl&process=stopallmaps" method="post" style="margin: 0px;">
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
				<td><input type="text" name="time" value="300" style="width: 50px; text-align: center;"></input></td>
				<td style="padding-left: 2px;"><input type="image" src="include/btn_stop.jpg"  style="border: 0px;"></input></td>
				</tr>
				</table>
				</form>
			</td>
		</tr>
		<tr bgcolor="#f0f0f0">
			<td width="50%" align="center">
				<b>Online Maps</b>
			</td>
			<td width="50%" align="center">
				<b>Available Maps</b>
			</td>
		</tr>
		<tr>
			<td align="center">
				<form action="index.jsp?page=serverctrl&process=stopmap" method="post" style="margin: 0px;">
				<select name="map" size="11" multiple="multiple" style="width: 100%;">
				<%
					for(int i=0; i<maps.length; i++)
					{
						if(maps[i][0].compareTo("0") != 0)
						{
							out.println("<option value=\"" + maps[i][0] + "\">" + maps[i][1] + " : " + maps[i][2] + "</option>");
						}
					}
				%>
				</select>
				<%
					if(allowed)
					{
						out.print("<input type=\"image\" title=\"Stop the selected Maps\" src=\"include/btn_stop.jpg\" style=\"border: 0px; padding: 2px;\"></input>");
					}
				%>
				</form>
			</td>
			<td align="center">
				<form action="index.jsp?page=serverctrl&process=startmap" method="post" style="margin: 0px;">
				<select name="map" size="11" multiple="multiple" style="width: 100%;">
				<%
					for(int i=0; i<maps.length; i++)
					{
						if(maps[i][0].compareTo("0") == 0)
						{
							out.println("<option value=\"" + maps[i][1] + "\">" + maps[i][1] + " : " + maps[i][2] + "</option>");
						}
					}
				%>
				</select>
				<%
					if(allowed)
					{
						out.print("<input type=\"image\" title=\"Start the selected Maps\" src=\"include/btn_start.jpg\" style=\"border: 0px; padding: 2px;\"></input>");
					}
				%>
				</form>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>