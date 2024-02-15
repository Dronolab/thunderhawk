# Thunderhawk

Thunderhawk is a drone developed by the Dronolab team at ÉTS. Utilizing ROS2 Humble, Thunderhawk is designed for advanced applications such as passenger transport and package delivery.

## Work in a docker container (Preferred)

Working in a dev container will allow you to have the same environnement as the CI and make sure that your code will work on another computer. It will also allow you to easily switch package version and test things without breaking your computer.

### Windows installation

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. Install [Visual Studio Code](https://code.visualstudio.com/)
3. Install Xserver (We recommend [VcXsrv](https://sourceforge.net/projects/vcxsrv/))
4. Install the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VSCode
5. Clone and open the repository
6. Click on the green button in the bottom left corner of VSCode and select "Remote-Containers: Reopen in Container" or use the command palette to do it.
7. Wait for the container to build
8. Start Xserver with the ```-nowgl``` option (double click on the shortcut to open it if you use VcXsrv)

### Linux installation

Same as the windows installation, step 3 and 8 can be skipped.

Replace the DISPLAY environment variable in the .env file
```bash
echo DISPLAY=$DISPLAY
```

**Suggestion:** Configure docker to be able to run as non-root user https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user

## Native installation (Ubuntu 22.04 LTS, other distros not supported)

```bash
git clone https://github.com/dronolab/thunderhawk.git
vcs import src < thunderhawk.repos
colcon build --symlink-install
source install/setup.bash
```

## Running Thunderhawk in simulation

```bash
colcon build --packages-skip px4_msgs --symlink-install
source install/setup.bash
ros2 launch _______
```

## Adding New Packages

To add a package for Thunderhawk, create it using the ROS2 command ([Creating Your First ROS2 Package](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html)). Name it starting with `thunderhawk_` to ensure Git tracking. For non-Rove specific packages, create a separate repository and add it to `thunderhawk.repos`.

## Updating Packages

Update Thunderhawk-specific packages directly in this repository. For Dronolab-related or external packages, update their references in `thunderhawk.repos`. Change the Git branch in `thunderhawk.repos` as needed and apply updates with `vcs import src < rove.repos`.

## Potential package structure

**Bringup:**
This essential package is responsible for initializing the drone in real-world settings. It activates all necessary subsidiary packages tailored for specific operational scenarios.

**Description:**
This package is specifically designed for detailing the drone's structure in URDF (Unified Robot Description Format).

**Gazebo:**
This package facilitates the simulation of the drone within the Gazebo environment, providing a virtual testing ground.

**Hardware:**
Dedicated to initializing all sensors and actuators on the drone, this package is pivotal for operational readiness. It is specifically designed for use with the actual hardware and is not suitable for development machines.

**Navigation:**
This is a wrapper package that integrates navigation functionalities, primarily based on the nav2 framework.

**SLAM (Simultaneous Localization and Mapping):**
This package serves as a comprehensive wrapper for SLAM operations, incorporating tools like slam_toolbox, rtab map, and sensor filters for effective environment mapping and drone localization.
