
# Server Setup Script

This repository contains a script for setting up servers with specific configurations and installations. The current version of the script provides an interactive setup process, including the installation of Portainer, a powerful tool to manage your Docker environments, Webmin, Netdata as a Container and so on.

#### Requirements

- Bash shell (the script might not run correctly in shells other than Bash like sh or zsh).

### Usage

**1. First, clone the repository to your server:**

```bash
git clone https://github.com/anthony2611/server-setup.git  
```
Or
```bash
git clone https://setup.aperture-science.dev  
```
    

**2. Ensure the script is executable by running:**

```bash
chmod +x Server_Setup.sh
```

**3. Run the script:**

```bash
./Server_Setup.sh
```


**4. The script will interactively ask if you want to install f.Ex. Portainer or Webmin. If you wish to install it, respond with 'y' or 'Y' and press Enter. If you do not want to install, you can respond with 'n' or 'N'.**

```bash
Do you want to install (Software Name)? (y/n)
```

**5. If you agree to install , the script will proceed with the installation and provide feedback in the terminal.**

**Note:** If the script is interrupted or if it encounters an error, you may need to address the issue before rerunning the script.

## Features

- update and upgrade your system
- install nala as package manager
- installing Nano (Text Editor), Neofetch, Net-Tools, Curl, Git, Htop and all ther dependencies
- seting a banner for ssh and PS1 for the user
- install Portainer (if you want)
- install Webmin (if you want)
- install Netdata as a Container (if you want)
- install Docker and Docker-Compose (if you want)
- install ROS-noetic (if you want)



## Troubleshooting

- Ensure you are running the script with sufficient permissions. If necessary, use `sudo` before the script execution command.
- If you encounter errors related to the `read` command or conditional syntax, ensure that your environment is running a compatible version of Bash.
- if you run the script and it exited unexpectedly, you can not run it again. You have to delete the pid file first. You can do this with the following command:

```bash
rm /var/run/aperture.pid
```

**Note:** if you find any bugs or errors, please open an issue on GitHub. Thank you! :)

## Contributing

If you would like to contribute to the script's development or suggest improvements, please follow the standard fork, branch, and pull request workflow.

## License

This program is free software: you can redistribute and/or modify it under the terms of the GNU General Public License. 
Please give credit to the original author (Me) when you use it elsewhere. Thank you! :)
