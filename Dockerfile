# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set the timezone environment variable
ENV TZ=Asia/Kolkata

# Install necessary packages
RUN apt-get update && apt-get install -y \
    tzdata \
    xrdp \
    xfce4 \
    xfce4-terminal \
    dbus-x11 \
    x11-xserver-utils \
    && apt-get clean

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add a non-root user
RUN useradd -m -s /bin/bash xrdpuser

# Switch to the non-root user
USER xrdpuser

# Configure xrdp for the non-root user
RUN echo xfce4-session > /home/xrdpuser/.xsession

# Switch back to root to expose the port and start the service
USER root

# Expose the RDP port
EXPOSE 3389

# Expose an additional HTTP port (if needed)
EXPOSE 8000

# Start xrdp
CMD ["/usr/sbin/xrdp", "-nodaemon"]
