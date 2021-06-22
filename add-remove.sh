#!/bin/bash

[ $UID != 0 ] && { echo "please try again with root privalages 'sudo bash $(basename $0)'" ; exit 1 ; }

definebase-beta() {
    if [ -e /etc/fedora-release ] ; then
        set_rpmbase="/etc/yum.repos.d"
    elif [ -e /etc/zypp/zypp.conf ] ; then
        set_rpmbase="/etc/zypp/repos.d"
    else
        echo "unknow rpm based distro please add or remove the metadata of repository with manually."
        cat - <<EOF 
[bych4n-repo]
name=bych4n-repository
enabled=1
baseurl=https://bych4n-group.github.io/bych4n_rpm
type=rpm-md
gpgcheck=1
gpgkey=https://bych4n-group.github.io/bych4n_rpm/repodata/KEY.pub
EOF
        exit 1
    fi
}

case ${1} in
    [aA][dD][dD]|--[aA][dD][dD]|-[aA])
        definebase-beta
        cat - > ${set_rpmbase}/bych4n-rpm.repo <<EOF 
[bych4n-repo]
name=bych4n-repository
enabled=1
baseurl=https://bych4n-group.github.io/bych4n_rpm
type=rpm-md
gpgcheck=1
gpgkey=https://bych4n-group.github.io/bych4n_rpm/repodata/KEY.pub
EOF
    ;;
    [rR][eE][mM][oO][vV][eE]|--[rR][eE][mM][oO][vV][eE]|-[aA])
        definebase-beta
        [ -e ${set_rpmbase}/bych4n-rpm.repo ] && rm ${set_rpmbase}/bych4n-rpm.repo 
    ;;
    *)
        echo "wrong usage there are two (2) flags: --add, --remove"
    ;;
esac