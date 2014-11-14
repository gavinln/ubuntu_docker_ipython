#!/bin/bash

# script to install Microsoft ODBC driver
# cp /vagrant/odbc_driver/install_odbc_driver.sh .

# strict mode
set -euo pipefail

INSTALL_DIR=~/msodbc

mkdir $INSTALL_DIR
cd $INSTALL_DIR
cp /vagrant/odbc_driver/msodbcsql-11.0.2270.0.tar.gz .
tar xvzf msodbcsql-11.0.2270.0.tar.gz -C $INSTALL_DIR
cd $INSTALL_DIR/msodbcsql-11.0.2270.0


cp /vagrant/odbc_driver/unixODBC-2.3.0.tar.gz .
cp /vagrant/odbc_driver/ubuntu_build_dm.sh .

chmod +x ubuntu_build_dm.sh
./ubuntu_build_dm.sh --accept-warning --download-url=file://unixODBC-2.3.0.tar.gz

UNIX_ODBC_DIR=`sudo find /tmp -name unixODBC-2.3.0`
cd $UNIX_ODBC_DIR
sudo make install

cd $INSTALL_DIR/msodbcsql-11.0.2270.0
cp /vagrant/odbc_driver/ubuntu_install.sh .
chmod +x ubuntu_install.sh
sudo ./ubuntu_install.sh install --accept-license

sudo apt-get install -y python-dev

sudo pip install --allow-external pyodbc --allow-unverified pyodbc pyodbc

LD_LIBRARY_PATH=/usr/lib64
export LD_LIBRARY_PATH

sudo ln -s /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib64/libcrypto.so.10
sudo ln -s /lib/x86_64-linux-gnu/libssl.so.1.0.0 /usr/lib64/libssl.so.10
