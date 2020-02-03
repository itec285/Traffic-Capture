#!/usr/bin/bash

# ML 2019
# Original source at https://unix.stackexchange.com/questions/414361/creating-users-from-a-csv-file
# Create a .csv file called users.csv with format: Surname,Name,Username,Department,Password

#Uncomment the below to view output
#set -x

MY_INPUT='users.csv'

#Install and start the FTP server first
apt-get update
apt install vsftpd

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

for index in "${!A_USERNAME[@]}"; do
	#echo ${A_PASSWORD[$index]}    
	useradd -g "${A_DEPARTMENT[$index]}" -m -d "/home/${A_USERNAME[$index]}" -s /bin/bash "${A_USERNAME[$index]}"
	echo ${A_USERNAME[$index]}:${A_PASSWORD[$index]} | chpasswd
done
cp vsftpd.conf /etc/

systemctl start vsftpd
systemctl enable vsftpd
