FROM resin/raspberrypi3-python:3.5

RUN apt-get update -y -qq && \
    apt-get install -y python3-dev qt5-default libfreetype6-dev pkg-config libpng12-dev pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SIP
RUN mkdir -p /opt/sip && \
    cd /opt/sip && \
    curl -L -o sip.tar.gz http://sourceforge.net/projects/pyqt/files/sip/sip-4.19.2/sip-4.19.2.tar.gz && \
    tar -xf sip.tar.gz && \
    cd /opt/sip/sip-* && \
    python configure.py && \
    make && \
    make install && \
    cd /opt && \
    rm -rf /opt/sip

# Install PyQt5
RUN mkdir -p /opt/pyqt && \
    cd /opt/pyqt && \
    curl -L -o pyqt5.tar.gz https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.8.2/PyQt5_gpl-5.8.2.tar.gz && \
    tar -xf pyqt5.tar.gz && \
    cd /opt/pyqt/PyQt* && \
    python configure.py -c --confirm-license --no-designer-plugin -e QtCore -e QtGui -e QtWidgets && \
    make && \
    make install && \
    cd /opt && \
    rm -rf /opt/pyqt

RUN python -c "import sys"

# Install adafruit-ads1x15
RUN pip install adafruit-ads1x15 numpy

RUN python -c "import numpy as np"

# Install matplotlib
RUN python -mpip install matplotlib

RUN python -c "from matplotlib.figure import Figure"

# Define working directory
# Check & Go to Workspace
RUN python -c "import PyQt5" && \
    mkdir -p /opt/app

# Decouple from program
#ADD . /app

#WORKDIR /opt/app

# Define default command
# Decouple from program
# CMD [ "python", "./app/UI.py" ]




