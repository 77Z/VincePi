# Copyright 77Z (c) 2020

intro()
{

	clear

	echo -e '\033[32;|  ___      ___ ___  ________   ________  _______   ________  ___     \033[0m'
	echo -e '\033[32;| |\\  \\    /  /|\\  \\|\\   ___  \\|\\   ____\\|\\  ___ \\ |\\   __  \\|\\  \\    \033[0m'
	echo -e '\033[32;| \\ \\  \\  /  / | \\  \\ \\  \\\\ \\  \\ \\  \\___|\\ \\   __/|\\ \\  \\|\\  \\ \\  \\   \033[0m'
	echo -e '\033[32;|  \\ \\  \\/  / / \\ \\  \\ \\  \\\\ \\  \\ \\  \\    \\ \\  \\_|/_\\ \\   ____\\ \\  \\  \033[0m'
	echo -e '\033[32;|   \\ \\    / /   \\ \\  \\ \\  \\\\ \\  \\ \\  \\____\\ \\  \\_|\\ \\ \\  \\___|\\ \\  \\ \033[0m'
	echo -e '\033[32;|    \\ \\__/ /     \\ \\__\\ \\__\\\\ \\__\\ \\_______\\ \\_______\\ \\__\\    \\ \\__\\\033[0m'
	echo -e '\033[32;|     \\|__|/       \\|__|\\|__| \\|__|\\|_______|\\|_______|\\|__|     \\|__|\033[0m'
	echo  
	echo  
	echo '|   Welcome human to the VincePi installer tool,'
	echo '|   VincePi is a platform that you can install'
	echo '|   on your system to play video games, not just'
	echo '|   emulated games either, though, those are'
	echo '|   supported. Just plug in a controller, and it'
	echo '|   works, it can be a standalone application,'
	echo '|   or replace your entire operating system'
	echo '|'
	echo '|   Now you must customize your installation,'
	echo '|   Type FULL to replace your current OS with'
	echo '|   VincePi, or type SEMI to install it as an'
	echo '|   application on raspbian'
	echo '|              '$@
	read -p "|        Selection: " sel

	if [ $sel == FULL ]; then
		full_install_warn
	elif [ $sel == SEMI ]; then
		semi_install
	else
		intro INVALID # Shows invalid selection warning
	fi
}

full_install_warn()
{
	clear
	echo '|        ------ FULL INSTALL -----'
	echo '|           WAAAAAAAAARRRRNING    '
	echo "| The full install will delete any files "
	echo "| at will, it doesn't care about anything"
	echo "|"
	echo "| RUN THIS IN ONE OF THE TTY'S!!!"
	echo "| CTRL + ALT + F1 for TTY1"
	echo "|"
	echo '|'
	echo '| Ctrl-C to save yourself while you still'
	echo '| can. To confirm, type:'
	echo '| I_DONT_CARE_ABOUT_ANY_FILES_ON_THIS_PI'
	echo '| '$@
	read -p '|   : ' confirm
	
	#if [ $confirm == I_DONT_CARE_ABOUT_ANY_FILES_ON_THIS_PI ]; then
	if [ $confirm == a ]; then # Code for rapid debugging
		full_install
	else
		full_install_warn The only thing saving you now is that typo
	fi
}

full_install()
{
	echo "|"
	echo "| You have 5 SECONDS until it installs,"
	echo "| last last chance to press Ctrl-C"
	sleep 5
	clear
	echo -n "I'm not responsible"
	sleep 1.5
	echo -n .
	sleep 0.5
	echo -n .
	sleep 0.5
	echo .
	sleep 3
	echo If prompted, enter your sudo password.
	echo "Installing VincePI OS (FULL)"

	# Display OS Version
	echo -n "OS VERSION: "
	uname -o

	# Display Linux Kernel Version
	echo -n "Linux Kernel: "
	uname -r

	# Arch
	echo -n "CPU Arch: "
	uname -m

	# Pinout Info
	echo "---------------------"
	echo "|       Pinout      |"
	echo "---------------------"
	pinout

	echo Creating Backup Directory...
	sudo mkdir /etc/vincepi-backup

	echo "Installing Python and it's dependencies..."
	sudo apt install -y python3 # Needed for UI
	python3 -m pip install pillow # Used for image rendering

	echo "Installing unclutter and it's dependencies..."
	sudo apt install unclutter

	echo "Backing up X11 init config (xinitrc)"
	sudo cp /etc/X11/xinit/xinitrc /etc/vincepi-backup/xinitrc-backup

	echo "Configuring unclutter..."
	echo -e "\n\nunclutter &" >> /etc/X11/xinit/xinitrc

	echo Downloading Resources...
	# Download images
	sudo wget -O /etc/splash.png https://raw.githubusercontent.com/77Z/VincePi/master/splash.png
	sudo wget -O /etc/Background.png https://raw.githubusercontent.com/77Z/VincePi/master/Background.png
	sudo wget -O "/etc/VincePi Starting.png" "https://raw.githubusercontent.com/77Z/VincePi/master/VincePi Starting.png"

	echo Backing up splash screen...
	sudo cp /usr/share/plymouth/themes/pix/splash.png etc/vincepi-backup/splash-backup.png
	echo Replacing splash screen...
	sudo cp /etc/splash.png /usr/share/plymouth/themes/pix/splash.png
	
	echo Backing up boot config...
	sudo cp /boot/config.txt /etc/vincepi-backup/boot-backup.txt
	echo "Configuring boot (Remove Rainbow Splash, Disable Overscan, Set Screen Resoltion, Enables Audio, Enables HDMI hotplug)"
	sudo echo -e "# http://rpf.io/configtxt\n\ndisable_overscan=1\n\nhdmi_force_hotplug=1\n\nhdmi_group=1\nhdmi_mode=4\n\ndtparam=audio=on\n\ndisable_splash=1"
	#sudo echo "\n\ndisable_splash=1" >> /boot/config.txt
	echo Backing up boot cmdline config...
	sudo cp /boot/cmdline.txt /etc/vincepi-backup/boot-cmdline-backup.txt
	echo Configuring boot...
	echo " console=tty3 splash quiet plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0" >> /boot/cmdline.txt
	echo Boot operations configured!

	#echo Setting screen resolution...

	



	# echo "Setting up logon config a.k.a. ~/.profile"
}

semi_install()
{
	clear
	echo SEMI INSTALL
}

intro
