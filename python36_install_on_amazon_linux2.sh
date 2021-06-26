# The steps in this script are:
# - install pre-reqs
# - install Python 3.6
# - create virtualenv

#!/bin/bash

# install pre-requisites
sudo yum -y groupinstall development
sudo yum -y install zlib-devel
sudo yum -y install tk-devel

sudo yum -y install openssl-devel

# Installing openssl-devel alone seems to result in SSL errors in pip (see https://medium.com/@moreless/pip-complains-there-is-no-ssl-support-in-python-edbdce548852)
# Need to install OpenSSL also to avoid these errors
wget https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz
tar -zxvf OpenSSL_1_0_2l.tar.gz 
cd openssl-OpenSSL_1_0_2l/

./config shared
make
sudo make install
export LD_LIBRARY_PATH=/usr/local/ssl/lib/

cd ..
rm OpenSSL_1_0_2l.tar.gz
rm -rf openssl-OpenSSL_1_0_2l/

# Install Python 3.6
wget https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz
tar xJf Python-3.6.0.tar.xz
cd Python-3.6.0

./configure
make
sudo make install

cd ..
rm Python-3.6.0.tar.xz
sudo rm -rf Python-3.6.0


# Create virtualenv running Python 3.6
sudo yum install -y python2-pip
sudo pip install --upgrade virtualenv
virtualenv -p python3 py3env
source py3env/bin/activate
