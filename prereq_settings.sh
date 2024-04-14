echo "Starting with kernel settings setup
"

echo "fs.file-max = 6815744
kernel.sem = 250 32000 100 128
kernel.shmmni = 4096
kernel.shmall = 1073741824
kernel.shmmax = 4398046511104
kernel.panic_on_oops = 1
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
net.ipv4.conf.all.rp_filter = 2
net.ipv4.conf.default.rp_filter = 2
fs.aio-max-nr = 1048576
net.ipv4.ip_local_port_range = 9000 65500" >> /etc/sysctl.conf

/sbin/sysctl -p

echo "Finished kernel settings setup
"

echo "Starting with limits for oracle user setup
"

touch /etc/security/limits.d/oracle-database-preinstall-19c.conf

echo "oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    16384
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728" >> /etc/security/limits.d/oracle-database-preinstall-19c.conf

echo "Finished with limits setup
"

echo "Starting with packages required install
"

yum install -y bc
yum install -y binutils
yum install -y compat-libstdc++-33
yum install -y elfutils-libelf
yum install -y elfutils-libelf-devel
yum install -y fontconfig-devel
yum install -y glibc
yum install -y glibc-devel
yum install -y ksh
yum install -y libaio
yum install -y libaio-devel
yum install -y libXrender
yum install -y libXrender-devel
yum install -y libX11
yum install -y libXau
yum install -y libXi
yum install -y libXtst
yum install -y libgcc
yum install -y librdmacm-devel
yum install -y libstdc++
yum install -y libstdc++-devel
yum install -y libxcb
yum install -y make
yum install -y net-tools # Clusterware
yum install -y nfs-utils # ACFS
yum install -y python # ACFS
yum install -y python-configshell # ACFS
yum install -y python-rtslib # ACFS
yum install -y python-six # ACFS
yum install -y targetcli # ACFS
yum install -y smartmontools
yum install -y sysstat
yum install -y gcc
yum install -y unixODBC
yum install -y libnsl
yum install -y libnsl.i686
yum install -y libnsl2
yum install -y libnsl2.i686

echo "Finished with packages install
"
echo "Starting with groups creation
"

groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper

usermod -u 54321 -g oinstall -G dba,oper,wheel oracle

echo "Finished with groups creation
"
