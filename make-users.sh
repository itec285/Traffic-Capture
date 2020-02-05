#!/usr/bin/env bash

# ML 2019
# Some original source at https://unix.stackexchange.com/questions/414361/creating-users-from-a-csv-file
# Create a .csv file called users.csv with format: Surname,Name,Username,Department,Password
#    Make sure the department is just users, as that will be the group that is used

#Uncomment the below to view output
#set -x

MY_INPUT='users.csv'

#Install and start the FTP server first
apt-get update
apt install -y vsftpd

declare -a A_SURNAME
declare -a A_NAME
declare -a A_USERNAME
declare -a A_DEPARTMENT
declare -a A_PASSWORD
while IFS=, read -r COL1 COL2 COL3 COL4 COL5 TRASH; do
    A_SURNAME+=("$COL1")
    A_NAME+=("$COL2")
    A_USERNAME+=("$COL3")
    A_DEPARTMENT+=("$COL4")
    A_PASSWORD+=("$COL5")
done <"$MY_INPUT"

#Create each user.  For each, set a password, and setup a ftp folder in their home directory.
for index in "${!A_USERNAME[@]}"; do
	#Create the user account
	#echo ${A_PASSWORD[$index]}    
	useradd -g "${A_DEPARTMENT[$index]}" -m -d "/home/${A_USERNAME[$index]}" -s /bin/bash "${A_USERNAME[$index]}"

	#Set the password
	echo ${A_USERNAME[$index]}:${A_PASSWORD[$index]} | chpasswd

	#Create the subdirectory files for ftp
	mkdir /home/${A_USERNAME[$index]}/ftp

	#Set the permissions and ownership.  If in a chroot jail the user must NOT be able to write to it for vsftp to work.
	chown nobody:nogroup /home/${A_USERNAME[$index]}/ftp
	chmod a-w /home/${A_USERNAME[$index]}/ftp

	#Make the subdirectory, and give the user access to that directory.  Create a file there when done.
	mkdir /home/${A_USERNAME[$index]}/ftp/files
	chown ${A_USERNAME[$index]}:${A_DEPARTMENT[$index]} /home/${A_USERNAME[$index]}/ftp/files
	echo "vsftp test file" | tee /home/${A_USERNAME[$index]}/ftp/files/test.txt

	#Add this user to the list at /etc/vsftpd.userlist so they can login
	echo ${A_USERNAME[$index]} | tee -a /etc/vsftpd.userlist

done
cp vsftpd.conf /etc/

#Start the vsftp server and enable it on future startups
systemctl start vsftpd
systemctl enable vsftpd
systemctl restart vsftpd

#Configure the ufw firewall to allow ssh, ports 20 and 21 for ftp, port 990 for TLS-FTP, 
#   and the passive ports configured in the file.  Start it when done.
ufw allow ssh
ufw allow 20/tcp
ufw allow 21/tcp
ufw allow 990/tcp 
ufw allow 40000:50000/tcp
ufw --force enable
ufw status


