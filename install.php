<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

function executeRemoteCommand($host, $user, $password, $port, $command, $suppress_errors = false) {
    $ssh_command = sprintf("sshpass -p '%s' ssh -p %d -o StrictHostKeyChecking=no '%s@%s' '%s' %s",
        $password, $port, $user, $host, $command, $suppress_errors ? '2>/dev/null' : '2>&1'
    );
   $process = popen($ssh_command, 'r');
    if (!is_resource($process)) {
        throw new Exception("Error: Could not execute command.");
    }
    while (!feof($process)) {
       $output = fread($process, 4096);
       if($output){
          echo  htmlspecialchars($output);
         if(ob_get_level() > 0){
            ob_flush();
          }
          flush();
        }
    }
     $return_value = pclose($process);
    if ($return_value != 0) {
          throw new Exception("Command failed with a return value of " . $return_value . " and output.");
   }
    return '';
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $selected_script = $_POST["install_selection"];
    $ssh_host = $_POST["ssh_host"];
    $ssh_user = $_POST["ssh_user"];
    $ssh_password = $_POST["ssh_password"];
    $ssh_port = $_POST["ssh_port"];

    $scripts = [
        "1" => "http://havenpwi.net/installs/all%20in%20one/151twoinone.sh",
        "2" => "http://havenpwi.net/installs/all%20in%20one/155twoinone.sh",
       "3" => "http://havenpwi.net/installs/all%20in%20one/paneltwoinone.sh"
    ];
    $script_names = [
        "1" => "Perfect World 151",
       "2" => "Perfect World 155",
      "3" => "Panel by Hrace"
    ];
    if(!isset($scripts[$selected_script])){
        $error_message = "Invalid selection, please try again";
        echo "<!DOCTYPE html><html><head><title>Error</title></head><body>";
       echo "<h2>Error:</h2>" . $error_message;
       echo "</body></html>";
        exit();
    }
    $install_script_url = $scripts[$selected_script];
    $script_name = $script_names[$selected_script];
   ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Installation Output</title>
          <style>
        body { font-family: sans-serif; }
      .terminal-container {
            width: 100%;
             border: 1px solid #ddd;
             height: 400px;
            margin: 10px 0;
           overflow-y: scroll; /* Make the terminal scrollable */
           background-color: black;
            color: white;
           font-family: monospace;
           padding: 10px;
        }
       .error { color: red; }
   </style>
    </head>
    <body>
    <div class="terminal-container" id="terminal-container">
     <?php
         try {
            echo "Output from whoami: <br>";
            executeRemoteCommand($ssh_host, $ssh_user, $ssh_password, $ssh_port, "whoami", true);

            // Download script to the server.
           $command = "wget -nc -o StrictHostKeyChecking=no " . escapeshellarg($install_script_url);
            echo "Output from wget: <br>";
            executeRemoteCommand($ssh_host, $ssh_user, $ssh_password, $ssh_port, $command, true);
            $file_name = basename($install_script_url);
             // Make the script executable
            $command = "chmod +x " . escapeshellarg($file_name);
           echo "Output from chmod: <br>";
            executeRemoteCommand($ssh_host, $ssh_user, $ssh_password, $ssh_port, $command, true);
           // Execute the script
            $command = "./" . escapeshellarg($file_name);
             echo "Output from script: <br>";
           $output = executeRemoteCommand($ssh_host, $ssh_user, $ssh_password, $ssh_port, $command);
            echo htmlspecialchars($output);
             if($selected_script == 3 ){
                  echo "<br>Panel setup completed, use the following credentials to log in to the panel:<br>";
                  $creds = explode("\n", $output);
                 foreach($creds as $cred){
                       echo htmlspecialchars($cred) . "<br>";
                  }
                  echo "<br>Panel Installation Completed Successfully.<br>";
          }
        else{
            echo "<br>Installation of " . $script_name . " completed successfully.";
        }

      } catch (Exception $e) {
          echo "<div class='error'>Error during installation: " . htmlspecialchars($e->getMessage()) . "</div>";
      }
    ?>
    </div>
   <script>
        var terminalDiv = document.getElementById('terminal-container');
        terminalDiv.scrollTop = terminalDiv.scrollHeight;

         setInterval(function() {
          terminalDiv.scrollTop = terminalDiv.scrollHeight;
         }, 500);
  </script>
 </body>
   </html>
 <?php
 exit();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Server Installation</title>
    <style>
        body {
            font-family: sans-serif;
            background-color: #1e1e1e; /* Dark background */
            color: #fff; /* Light text */
            margin: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #00bfff; /* Light blue heading */
        }

        form {
            background-color: #333; /* Darker form background */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(255,255,255,0.1); /* subtle shadow */
            max-width: 600px;
            margin: 0 auto;
            border: 1px solid #00bfff; /* Added border */
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
             color: #00bfff;
        }

       input[type="text"],
        input[type="password"],
        input[type="number"] {
            width: calc(100% - 12px);
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #555; /* Darker border */
            border-radius: 4px;
            box-sizing: border-box;
              background-color: #444; /* Darker input background */
              color: #fff; /* Light input text */
        }

        button[type="submit"] {
            background-color: #00bfff; /* Light blue button */
            color: #fff; /* Light button text */
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            display: block;
            margin: 15px auto;
            transition: background-color 0.3s ease;
            min-width: 150px;
        }

        button[type="submit"]:hover {
            background-color: #0080aa; /* Slightly darker hover color */
        }

        iframe {
            display: block;
             width: 100%;
            max-width: 1000px;
            height: 600px;
            margin: 20px auto;
             border: 1px solid #00bfff;
           border-radius: 8px;
             background-color: #333; /* Darker iframe background */
        }
         .option-group {
             margin-bottom: 15px;
       }
      select {
          width: 100%;
            padding: 8px;
            margin-bottom: 15px;
             border: 1px solid #555; /* Darker border */
             border-radius: 4px;
            box-sizing: border-box;
            background-color: #444; /* Darker input background */
           color: #fff; /* Light input text */
        }
    </style>
</head>
<body>
    <h2>Select Server to Install</h2>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>" target="terminal">
        <div class="option-group">
            <label>Installation Option:</label><br>
            <input type="radio" name="install_selection" id="server1" value="1" required>
            <label for="server1">Perfect World 151</label><br>
            <input type="radio" name="install_selection" id="server2" value="2">
            <label for="server2">Perfect World 155</label><br>
            <input type="radio" name="install_selection" id="panel" value="3">
            <label for="panel">Panel by Hrace</label>
        </div>

        <label for="ssh_host">SSH Host:</label>
        <input type="text" name="ssh_host" id="ssh_host" required><br>

        <label for="ssh_user">SSH User:</label>
        <input type="text" name="ssh_user" id="ssh_user" required><br>

        <label for="ssh_password">SSH Password:</label>
        <input type="password" name="ssh_password" id="ssh_password" required><br>

        <label for="ssh_port">SSH Port:</label>
        <input type="number" name="ssh_port" id="ssh_port" value="22" required><br>

        <button type="submit">Install</button>
    </form>

   <br>
    <iframe name="terminal" style="width: 100%; height: 600px;"></iframe>

</body>
</html>