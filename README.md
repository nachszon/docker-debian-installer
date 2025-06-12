# docker-debian-installer

Installation script for Docker Engine and its dependencies on Debian.

##  What it does

This script performs the following steps:

- Updates the system package index
- Installs required packages (`ca-certificates`, `curl`, `gnupg`)
- Adds Docker’s official GPG key
- Adds the Docker APT repository
- Installs the latest version of Docker Engine and CLI

##  How to use

1. Clone the repository or download the script:

    ```bash
    curl -O https://raw.githubusercontent.com/nachszon/docker-debian-installer/main/install_docker.sh
    ```

2. Make the script executable:

    ```bash
    chmod +x install_docker.sh
    ```

3. Run the script:

    ```bash
    ./install_docker.sh
    ```

##  Supported systems

- Debian 11 or newer
- Debian-based distributions (e.g., Ubuntu – with minor adjustments)

##  Licence

MIT – see the [LICENSE](LICENSE) file for details.
