#!/bin/sh

# Copyright 2012  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Copyright 2013 Chess Griffin <chess.griffin@gmail.com> Raleigh, NC
# Copyright 2013-2014 Willy Sudiarto Raharjo <willysr@slackware-id.org>
# All rights reserved.
#
# Based on the xfce-build-all.sh script by Patrick J. Volkerding
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Modified again by Eric Fernandes Ferreira <candelabrus@gmail.com> for my personal Cinnamon Project

# Set to 1 if you'd like to install/upgrade package as they are built.
# This is recommended.
INST=1

# This is where all the compilation and final results will be placed
TMP=${TMP:-/tmp}

# This is the original directory where you started this script
CSBROOT=$(pwd)

# Loop for all packages
for dir in \
  pytz \
  xapp-symbolic-icons \
  gnome-common \
  libtimezonemap \
  python3-pyinotify \
  python3-libsass \
  tinycss2 \
  setproctitle \
  ptyprocess \
  gnome-desktop \
  gtksourceview5 \
  exempi \
  dmz-cursor-theme \
  mozjs128 \
  cjs \
  python-pam \
  cinnamon-desktop \
  libgnomekbd \
  libcroco \
  xapp \
  cinnamon-session \
  gsound \
  cinnamon-settings-daemon \
  gnome-menus \
  cinnamon-menus \
  cinnamon-control-center \
  libstemmer \
  libadwaita \
  zenity \
  cogl \
  clutter \
  clutter-gtk \
  muffin \
  caribou \
  pexpect \
  metacity \
  polib \
  cinnamon-translations \
  libxmlb \
  libportal \
  file-roller \
  gnome-disk-utility \
  meld \
  diffuse \
  nemo \
  nemo-python \
  nemo-pastebin \
  nemo-fileroller \
  nemo-image-converter \
  nemo-compare \
  python3-xapp \
  xdotool \
  cinnamon-screensaver \
  cinnamon-themes \
  mint-l-icons \
  mint-y-icons \
  mint-themes \
  gnome-icon-theme \
  cinnamon \
  gnome-terminal \
  libpeas \
  gcab \
  uchardet \
  amtk \
  libgedit-amtk \
  libgedit-gtksourceview \
  libgedit-gfls \
  libgedit-tepl \
  gedit \
  libgxps \
  evince \
  gthumb \
  gnome-calculator \
  gnome-screenshot \
  catch2 \
  gnome-system-monitor \
  eog \
  ; do
  # Get the package name
  package=$(echo $dir | cut -f2- -d /)

  # Change to package directory
  cd $CSBROOT/$dir || exit 1

  # Get the version
  version=$(cat ${package}.SlackBuild | grep "VERSION:" | head -n1 | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # Get the build
  build=$(cat ${package}.SlackBuild | grep "BUILD:" | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # The real build starts here
  sh ${package}.SlackBuild || exit 1
  if [ "$INST" = "1" ]; then
    PACKAGE=`ls $TMP/${package}-${version}-*-${build}*.txz`
    if [ -f "$PACKAGE" ]; then
      upgradepkg --install-new --reinstall "$PACKAGE"
    else
      echo "Error:  package to upgrade "$PACKAGE" not found in $TMP"
      exit 1
    fi
  fi
  # back to original directory
  cd $CSBROOT
done
