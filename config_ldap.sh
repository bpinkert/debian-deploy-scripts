#!/bin/bash
# Author: Benjamin Pinkert
# Website: https://www.savantdigital.net
# Github: https://github.com/bpinkert
# Date: 02/19/2016
# Purpose: This is a simple bash script to customize the PHP config file for your phpLDAPadmin server installation
# Input Var1: Server Display Name
# Input Var2: Server Domain Name or ip address
# Input Var3: DNS component entry
# Input Var4: Login bind ID 
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
# dispname=$1
# domip=$2
# domldap=$3
# admin=$4
# replace() {
# 	sudo sed -i -e "s/$1/$2/g" $configScrip
# }
# $dispdef="My LDAP Server"


echo -e "$COL_GREEN This script was written to help configure PHPLDAPAdmin $COL_RESET"
echo -e "$COL_RED Run as superUser $COL_RESET"
echo -e "$COL_YELLOW ======================================================$COL_RESET"
# continue or abort
read -p " Press enter to continue or CTRL-C to abort"
echo -e "$COL_YELLOW ======================================================$COL_RESET"
# prompt user to input display name
echo -e "$COL_GREEN Select a display name for the server $COL_RESET"
echo -en "$COL_YELLOW Input display name and press enter: $COL_RESET"
read dispname
while [ -z "$dispname" ]
do
echo -en "$COL_RED Server display name cannot be empty: $COL_RESET"
read dispname
done
sed -i -e "s/My LDAP Server/$dispname/g" /etc/phpldapadmin/config.php
echo -e "$COL_YELLOW ======================================================$COL_RESET"
# prompt user to input domain name or ip address
echo -e "$COL_GREEN Set the server$COL_GREEN domain name or IP address$COL_RESET"
echo -en "$COL_YELLOW Input and press enter: $COL_RESET"
read domip
while [ -z "$domip" ]
do
echo -en "$COL_RED Server domain/IP address cannot be empty: $COL_RESET"
read domip
done
sed -i -e "s/127.0.0.1/$domip/g" /etc/phpldapadmin/config.php
echo -e "$COL_YELLOW ======================================================$COL_RESET"
# prompt user to input domain entry in LDAP notation
echo -e "$COL_GREEN Set the domain name entry in$COL_YELLOW LDAP notation$COL_RESET"
echo -e "$COL_GREEN Example - example.com is$COL_GREEN dc=example,dc=com$COL_RESET"
echo -e "$COL_GREEN Example - ldap.example.com is $COL_GREEN dc=ldap,dc=example,dc=com$COL_RESET"
echo -e "$COL_RED Required: separate each dc with a comma$COL_RESET"
echo -en "$COL_YELLOW Input and press enter: $COL_RESET"
read domldap
while [ -z "$domldap" ]
do
echo -en "$COL_RED Server domain entry cannot be empty: $COL_RESET"
read domldap
done
sed -i -e "s/dc=example,dc=com/$domldap/g" /etc/phpldapadmin/config.php
echo -e "$COL_YELLOW ======================================================$COL_RESET"
# promt user to select custom user name or admin default
echo -e "$COL_GREEN Select the$COL_GREEN admin user name$COL_YELLOW [empty for admin]: $COL_RESET"
echo -en "$COL_YELLOW Input and press enter: $COL_RESET"
read admin
echo -e "$COL_CYAN ******************************************************$COL_RESET"
# if no custom user name is select, default to admin
if [ -z "$admin" ]
then 
:
else
cadmin="cn=$admin"
fi
sed -i -e "s/cn=admin/$cadmin/g" /etc/phpldapadmin/config.php
# echo user's selections
echo -e "$COL_GREEN Server display name is now $COL_YELLOW$dispname$COLRESET"
echo -e "$COL_GREEN Server domain/IP is now$COL_RESET $COL_YELLOW$domip$COL_RESET"
echo -e "$COL_GREEN Server domain entry is now$COL_RESET $COL_YELLOW$domldap$COL_RESET"
echo -e "$COL_GREEN admin user name is now$COL_YELLOW cn=$admin,$domldap$COL_RESET"
# echo login url
echo -e "$COL_CYAN ******************************************************$COL_RESET"
echo -e "$COL_CYAN Control click to browse to PHPLDAPAdmin login page: http://$domip $COL_RESET"
echo -e "$COL_GREEN ******************************************************$COL_RESET"
# self promotion!
echo -e "$COL_CYAN If you'd like to use our other shell scripts $COL_RESET"
echo -e "$COL_CYAN Follow Savant Digital on Twitter: http://goo.gl/6wWlCf $COL_RESET"
echo -e "$COL_CYAN Or visit our website https://www.savantdigital.net/scripts $COL_RESET"