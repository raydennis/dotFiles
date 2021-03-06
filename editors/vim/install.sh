sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
  libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
  libcairo2-dev libx11-dev libxpm-dev libxt-dev

cd vim
cd src
make distclean
./configure --with-features=huge --enable-gui=gnome2
make
sudo make install
