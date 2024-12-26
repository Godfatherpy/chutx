# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    xrdp \
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    x11-xserver-utils \
    && apt-get clean

# Configure xrdp
RUN echo xfce4-session >~/.xsession

# Expose the RDP port
EXPOSE 3389

# Start xrdp
CMD ["/usr/sbin/xrdp", "-nodaemon"]

