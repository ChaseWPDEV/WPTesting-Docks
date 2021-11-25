
## Installation
1. This package requires docker to work. For installation instructions for your specific OS visit https://docs.docker.com/engine/install/.

    * For those using package managers, I recommend going though the additional step to install the docker-ce packages. It is generally better.

2. This package build images from repositories hosted at docker hub -- you will need a account with Docker Hub to run builds.

3. **Linux Only** In order to easily mount your wp-content directory as volumes in your container it is highly recommended that you use docker-compose (comes automattically with Docker Desktop). This is available as a pip package installation instructions are available at: https://docs.docker.com/compose/install/

4. To automaticcaly build the images for testing on your system run the `buildAll.sh` or the `buildAll.ps1`(windows) script from your command prompt.

## Use
