FROM ghcr.io/dronolab/px4-ros2-humble:latest

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Add vscode user with same UID and GID as your host system
# (copied from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)
ARG USERNAME=thunderhawk
ARG USER_UID=1000
ARG USER_GID=$USER_UID

WORKDIR /workspace/$USERNAME

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID -g $USER_GID -G 107 -m $USERNAME \
    && apt-get update \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Update all packages
RUN apt update && apt upgrade -y

# Install Git
RUN apt install -y git

# Give user access to workdir
RUN chown -R $USERNAME:$USERNAME ./

# Copy to preload the ros packages
COPY ./ /workspace/$USERNAME/

# Copy gazebo models and worlds
COPY ./models /PX4-Autopilot/Tools/gz/models
COPY ./worlds /PX4-Autopilot/Tools/gz/worlds

# Change user
USER $USERNAME

# Rosdep update
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro humble -y

# Source the ROS setup file
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc