#!/bin/sh
if cd "`dirname \"$0\"`"; then
    absdirpath=`pwd`
    cd "$OLDPWD" || exit 1
else
    exit 1
fi
SCRIPTDIR=$absdirpath
BASEDIR=$(dirname $SCRIPTDIR)
SCRIPTNAME=$(basename $0 .sh)

echo ""
echo "===== $SCRIPTNAME ====="
echo ""

# execute system update (if needed)
#yum update -y

echo "disable selinux .."
setenforce 0
sed -i 's/SELINUX=\(enforcing\|permissive\)/SELINUX=disabled/g' /etc/selinux/config

echo "install epel release .."
yum install -y epel-release

echo "install misc dependencies .."
yum install -y ntp lynx nano wget telnet sudo git-core subversion git-svn

echo "set timezone .."
timedatectl set-timezone Europe/Vienna

echo "install 'http' .."
yum install -y httpd

echo "configure 'http' .."
mkdir  /etc/httpd/conf.d/vhost.conf.d
echo "Include conf.d/vhost.conf.d/*.conf" > /etc/httpd/conf.d/vhost.conf
echo "" > /etc/httpd/conf.d/vhost.conf.d/empty.conf
systemctl enable httpd
systemctl start  httpd

echo "install 'php-fpm 7.2' .."
cd /tmp
wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
yum-config-manager --enable remi-php72
yum install -y php-fpm
yum install -y php-cli php-pgsql php-xml php-gd php-curl php-ldap php-soap php-mbstring php-pear php-pdo php-imap

echo "configure 'php-fpm' .."
groupadd phpsession
mkdir -p /var/lib/php-fpm/session
chown root:phpsession /var/lib/php-fpm/session/
chmod 770 /var/lib/php-fpm/session/
sed -i "s/;date.timezone =.*/date.timezone = Europe\/Vienna/" /etc/php.ini
sed -i "s/short_open_tag =.*/short_open_tag = On/" /etc/php.ini
cp /vagrant_config/files/php-fpm/pool_vagrant.conf /etc/php-fpm.d/vagrant.conf
usermod -a -G phpsession vagrant
systemctl enable php-fpm
systemctl start php-fpm

echo "install postgres .."
yum install -y postgresql-server postgresql-contrib
postgresql-setup initdb
systemctl start postgresql
systemctl enable postgresql


echo "install 'java' .."
#yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
cd /tmp
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm"
yum localinstall -y jdk-8u191-linux-x64.rpm

echo "init dirs .."
mkdir -p /home/vagrant/logs
chown -R vagrant:vagrant /home/vagrant/logs

chmod 750 /home/vagrant
chown vagrant:apache /home/vagrant

echo "restart services .."
systemctl restart php-fpm
systemctl restart httpd


