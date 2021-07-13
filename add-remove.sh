#!/bin/bash

#    add remove script for bych4n-opensus(e) :D. 
#    Copyright (C) 2021  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


[ $UID != 0 ] && { echo "please try again with root privalages 'sudo bash $(basename $0)'" ; exit 1 ; }

checkopensus() {
    source /etc/os-release || source /usr/lib/os-release
    if [[ $(echo "$NAME" | awk '{print $1}') != "openSUSE" ]] ; then
        echo "please use this script on openSUSE based distro(s)"
        exit 1
    fi
}

case ${1} in
    [aA][dD][dD]|--[aA][dD][dD]|-[aA])
        checkopensus
        rpm --import https://bych4n-group.github.io/bych4n_opensuse/repodata/KEY.pub
        cat - > /etc/zypp/repos.d/bych4n-opensus.repo <<EOF 
[bych4n-repo]
name=bych4n-repository
enabled=1
baseurl=https://bych4n-group.github.io/bych4n_opensuse
type=rpm-md
gpgcheck=1
gpgkey=https://bych4n-group.github.io/bych4n_opensuse/repodata/KEY.pub
EOF
        echo "metadata created."
    ;;
    [rR][eE][mM][oO][vV][eE]|--[rR][eE][mM][oO][vV][eE]|-[aA])
        [ -e /etc/zypp/repos.d/bych4n-opensus.repo ] && rm /etc/zypp/repos.d/bych4n-opensus.repo 
    ;;
    *)
        echo "wrong usage there are two (2) flags: --add, --remove"
        exit 1
    ;;
esac
