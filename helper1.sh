apt-get update
apt install mitmf mitmflib

#Remove the new, broken Twisted app
cd /usr/lib/python2.7/dist-packages
rm -rf twisted/
rm -rf Twisted-16.3.0.egg-info/

cd /usr/share/mitmf
wget http://twistedmatrix.com/Releases/Twisted/15.5/Twisted-15.5.0.tar.bz2
pip install ./Twisted-15.5.0.tar.bz2
