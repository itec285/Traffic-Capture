#! /usr/bin/env bash -

# ML 2019
# Original source at https://unix.stackexchange.com/questions/414361/creating-users-from-a-csv-file
# Create a .csv file called users.csv with format: Surname,Name,Username,Department,Password

#Uncomment the below to view output
set -x

MY_INPUT='users.csv'

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
    useradd -g "${A_DEPARTMENT[$index]}" -d "/home/${A_USERNAME[$index]}" -s /bin/bash -p "$(echo "${A_PASSWORD[$index]}" | openssl passwd -1 -stdin)" "${A_USERNAME[$index]}"
done
