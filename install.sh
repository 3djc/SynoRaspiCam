# Run raspi-config, enable camera
sudo raspi-config
# go to menu option 5 - Interfacing Options
# press enter on P1 Camera
# select yes to enable the camera and press enter
# press enter again to confirm
# press the tab key and press enter on finish
# accept to reboot the raspberry pi
# log back in to your raspberry pi

########################################################################################
# Update Firmware - Making sure that your Raspbian firmware is the latest version.
########################################################################################
# update raspbian
sudo apt-get update && sudo apt-get -y dist-upgrade

########################################################################################
# Install official camera drivers
########################################################################################
sudo modprobe bcm2835-v4l2

########################################################################################
# Install live555 lib
########################################################################################
sudo apt-get install cmake liblog4cpp5-dev libv4l-dev
wget http://www.live555.com/liveMedia/public/live555-latest.tar.gz -O - | tar xvzf -
cd live
./genMakefiles linux
sudo make CPPFLAGS=-DALLOW_RTSP_SERVER_PORT_REUSE=1 install
cd ..

########################################################################################
# Install rtsp server
########################################################################################
sudo apt-get install git
git clone https://github.com/mpromonet/v4l2rtspserver.git
cd v4l2rtspserver/
cmake .
make
sudo make install

########################################################################################
# Test rtsp server
########################################################################################
# starts rtsp server
# you should be able to connect using a PC with vlc at :
# rtsp://raspberrypi_ip:8555/unicast
 /home/pi/v4l2rtspserver/armv6l/bin/v4l2rtspserver -F15 -H 1232 -W1640 -P 8555 /dev/video0
