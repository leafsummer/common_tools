#!/bin/bash
PIP_INSTALL_URL='https://bootstrap.pypa.io/get-pip.py'
# SVN_USERNAME="builder"
# SVN_PASSWORD="snq]sjly"
# CELERY_SVN=''
# CODE_WORKDIR=/tmp/choi_wan
# WORKER_WORKDIR=/opt/disk2/var/www/choi-wan/workers/

if which pip 2>/dev/null; then
    echo "pip exists"
    pip install -U pip
else
    echo "nope, no pip be installed, start to downloading and install"
    wget -c -P '/tmp/' $PIP_INSTALL_URL
    if [ $? -eq 0 ]; then
        echo 'start to install the pip'
        python /tmp/get-pip.py
        pip install -U pip
    else
        echo 'downloading the pip source package is failed, exists'
        exit $?
    fi
fi

if which virtualenv 2>/dev/null; then
    echo "virtualenv exists"
    source /usr/local/bin/virtualenvwrapper.sh
    isexists=`lsvirtualenv -b | grep 'choi_wan'`
    if [ -z $isexists ]; then
        mkvirtualenv choi_wan
    fi
else
    echo "nope, no virtualenv be installed, start to install"
    pip install virtualenvwrapper
    echo 'export VIRTUALENV_SYSTEM_SITE_PACKAGES=false' >> /text.text
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> /text.text
    
    source /etc/profile
    mkvirtualenv choi_wan
fi
workon choi_wan
pip install -U pip

# echo "checkout the choi_wan egg codes"
# if [ -d "$CODE_WORKDIR" ]; then
#     echo "rm the $CODE_WORKDIR"
#     rm -rf $CODE_WORKDIR
# fi
# mkdir -p $CODE_WORKDIR
# svn co $CELERY_SVN $CODE_WORKDIR --username $SVN_USERNAME --password $SVN_PASSWORD -q --no-auth-cache --non-interactive --trust-server-cert
# python $CODE_WORKDIR/setup.py install

echo "installed python package list:"
pip list

# mkdir -p $WORKER_WORKDIR

# workon choi_wan
# rmvirtualenv choi_wan

