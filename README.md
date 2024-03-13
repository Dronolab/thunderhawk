# Thunderhawk

Thunderhawk is a drone developed by the Dronolab team at ÉTS. Utilizing ROS2 Humble, Thunderhawk is designed for advanced applications such as passenger transport and package delivery.

## Work in a docker container (Preferred)

Working in a dev container will allow you to have the same environnement as the CI and make sure that your code will work on another computer. It will also allow you to easily switch package version and test things without breaking your computer.

### Installation

0. (Only for Windows Users) Install WSL2
```bash
wsl --install
wsl --install -d Ubuntu
wsl --set-default Ubuntu 22.04
```
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
2. (Only for Nvidia GPU Users) Install [Nivida Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) and set nvidia as the default runtime by modifying the ```/etc/docker/daemon.json``` file and adding the default runtime line like so:
```json
{
    "default-runtime": "nvidia",
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    }
}
```

Restart docker with this command:

```bash
systemctl --user restart docker
```

2. Install [Visual Studio Code](https://code.visualstudio.com/)
3. Install the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) and [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) extension in VSCode
4. Clone and open the repository (Do on WSL2 if on Windows)
```bash
git clone git@github.com:Dronolab/thunderhawk.git
cd thunderhawk
code .
```
5. Import repos from thunderhawk.repos file
```bash
vcs import src < thunderhawk.repos
```
6. Run the setup script before first use
```bash
sh setup.sh
```
7. Click on the green button in the bottom left corner of VSCode and select "Dev Containers: Reopen in Container" or use the command palette to do it.
8. Wait for the container to build

**Suggestion:** Configure docker to be able to run as non-root user https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user

## Running Thunderhawk in simulation

```bash
colcon build --symlink-install
source install/setup.bash
ros2 launch _______
```

## Adding New Packages

To add a package for Thunderhawk, create it using the ROS2 command ([Creating Your First ROS2 Package](https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Creating-Your-First-ROS2-Package.html)). Name it starting with `thunderhawk_` to ensure Git tracking. For non-Thunderhawk specific packages, create a separate repository and add it to `thunderhawk.repos`.

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
