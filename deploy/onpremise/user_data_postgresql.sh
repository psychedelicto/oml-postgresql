#!/bin/bash

#you should invocate: ./postgresql.sh 10.10.10.0/24 password
# with your network addr and prefered password

# $1 is the Subnet NETADDR X.X.X.X/XX
# $2 is the PGSQL Pass for OMLApp connection
OMLPGSQLNETADDR=$1
OMLPGSQLOMLAPPPASS=$2

echo "******************** prereq selinux and firewalld ***************************"
echo "******************** prereq selinux and firewalld ***************************"
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
systemctl disable firewalld

echo "******************** yum tasks ***************************"
echo "******************** yum tasks ***************************"
rpm -Uvh https://yum.postgresql.org/11/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum install -y postgresql11-server postgresql11 postgresql11-plperl postgresql11-contrib postgresql11-odbc vim

echo "******************** DB initialization ***************************"
echo "******************** DB initialization ***************************"
/usr/pgsql-11/bin/postgresql-11-setup initdb

echo "******************** edit postgresql.conf ***************************"
echo "******************** edit postgresql.conf ***************************"
sed -i "s/^#listen_addresses =.*/listen_addresses = \'*\'/" /var/lib/pgsql/11/data/postgresql.conf
sed -i "s/^timezone =.*/timezone = \'UTC\'/" /var/lib/pgsql/11/data/postgresql.conf

echo "******************** edit pg_hba.conf ***************************"
echo "******************** edit pg_hba.conf ***************************"
echo "host    all             all             $OMLPGSQLNETADDR            md5" >> /var/lib/pgsql/11/data/pg_hba.conf

echo "******************** enable and start postgres ***************************"
echo "******************** enable and start postgres ***************************"
systemctl enable postgresql-11 && systemctl start postgresql-11

echo "******************** postgres user password ***************************"
echo "******************** postgres user password ***************************"
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$OMLPGSQLOMLAPPPASS';"

echo "******************** reboot now ***************************"
echo "******************** reboot now ***************************"
reboot
