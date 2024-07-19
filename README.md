# only1window
Continuous Window Minimizer: Bash Script for Tidying X11 Desktops

The following script is a Bash script designed to continuously minimize all visible windows except the currently active one.

### Could be beneficial for several reasons:

- Improved Focus: By minimizing all windows except the active one, it helps users maintain focus on their current task without distractions from other open applications or windows.
- Enhanced Organization: It automatically keeps the desktop tidy by minimizing unnecessary windows, reducing clutter and making it easier to find and access important information.
- Increased Efficiency: Users can quickly switch between applications without manually minimizing or closing windows, saving time and effort.
- Customizable: The script allows users to adjust the frequency of window minimization by modifying the sleep duration, providing flexibility to tailor the behavior according to individual preferences.
- Accessibility: It can be particularly useful for individuals who frequently work with multiple windows or have limited screen space, as it streamlines the desktop environment for improved accessibility and usability.

### To run it automatically in the background:

- Using a Startup Application: Most operating systems provide a way to set up applications or scripts to run automatically when you log in. You can add your script to the list of startup applications in your system settings.
- Cron Job: You can schedule the script to run at regular intervals using cron. You can edit your crontab file (crontab -e) and add a line to specify when and how often the script should run.For example, to run the script every time the system starts, you can add the following line to your crontab:

```
@reboot /usr/local/bin/windowmngt &
```

-  Systemd Service: You can create a systemd service to manage the execution of your script. This method provides more control and flexibility over how the script is started and managed.

### Here's a basic example of a systemd service file (windowmng.service):

```
[Unit]
Description=Your Script Description
After=network.target

[Service]
Type=simple 
ExecStart=/bin/bash /usr/local/bin/windowmngt

[Install]
WantedBy=multi-user.target
```

- After creating the service file, you need to reload systemd (sudo systemctl daemon-reload), enable the service (sudo systemctl enable windowmngt.service), and start it (sudo systemctl start windowmngt.service).

Regardless of the method you choose, make sure your script has executable permissions (chmod +x yourscript.sh) and specify the full path to your script in any configuration files or commands you use to run it automatically.

> To ensure it will work correctly, it necessitates the X11 windowing system to manage window operations, meaning it's indispensable that your desktop environment operates within the X11 framework.

This script essentially creates a continuous loop that keeps all windows minimized except for the currently active one, effectively maintaining a tidy desktop environment. Adjusting the sleep duration can change how frequently the script checks and minimizes windows.
