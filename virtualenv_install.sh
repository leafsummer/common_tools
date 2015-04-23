#!/bin/sh
pip install virtualenvwrapper==3.7
cat << EOF >>/etc/profile
export WORKON_HOME=/opt/ENV
export VIRTUALENV_SYSTEM_SITE_PACKAGES=true
source /usr/local/bin/virtualenvwrapper.sh
EOF

