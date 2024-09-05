
# Docker Launcher Script Documentation

## Overview

This `docker_launcher.sh` script is designed to automate the process of launching Docker containers using the parameters specified in an input file. Each line in the file contains details about the Docker image, container name, parameters, command, and local directory where the container is executed.

# Version

1.7

# Release date

2024-09-03

# DOI

[https://doi.org/10.5281/zenodo.13688395](https://doi.org/10.5281/zenodo.13688395)    

# Cite as

Varona, Humberto L., & Herold-Garcia, Silena (2024). Docker image launcher (docker_launcher). (1.0). Zenodo. https://doi.org/https://doi.org/10.5281/zenodo.13688395

## Usage

### Prerequisites

Before running the script, make sure you have the following installed on your system:
- Docker
- Bash (for executing shell scripts)

### How the Script Works

The script reads lines from a file, where each line contains information about a Docker container you want to launch. The fields in each line are separated by an ampersand (`&`), and they contain the following details:

1. **Docker Image**: The name of the Docker image to pull and run.
2. **Container Name**: The name to assign to the container.
3. **Docker Parameters**: Any additional parameters you want to pass to Docker, such as volume mounts or port mappings.
4. **Command**: The command to execute inside the Docker container.
5. **Local Directory**: The local directory from which the container should be run.

### Example Input File (`sample_docker_info.tab`)

The input file should contain lines where fields are separated by `&`. Here's an example line from `sample_docker_info.tab`:

```
humbertovarona/alpcrontasks:v1&d-cron&-v "$(pwd)/shared/data:/usr/src/app/shared/data" -v "$(pwd)/crontasks:/usr/src/app/crontasks" -v "$(pwd)/scripts:/usr/src/app/scripts"&&/home/user/getdata
```

In this example:

- Docker Image: `humbertovarona/alpcrontasks:v1`
- Container Name: `d-cron`
- Docker Parameters: 
    - `-v "$(pwd)/shared/data:/usr/src/app/shared/data"`
    - `-v "$(pwd)/crontasks:/usr/src/app/crontasks"`
    - `-v "$(pwd)/scripts:/usr/src/app/scripts"`
- Command: No command specified (empty string)
- Local Directory: `/home/user/getdata`

### Running the Script

1. Create a file (e.g., `sample_docker_info.tab`) containing the information for your Docker containers, formatted as shown in the example above.
2. Execute the `docker_launcher.sh` script, passing the path to the input file as an argument:

```bash
./docker_launcher.sh sample_docker_info.tab
```

### File Permissions

Ensure the script has executable permissions:

```bash
chmod +x docker_launcher.sh
```

### Notes

- You can pass multiple volume mounts and other parameters to Docker in the `params` field.
- If you want to include a command to be executed inside the container, provide it in the `command` field.
- If no command is required, leave the `command` field empty.

### Troubleshooting

- **Issue**: The Docker container fails to run.
    - **Solution**: Check the Docker logs using `docker logs <container_name>` to identify any issues with the container startup.

- **Issue**: File permissions error.
    - **Solution**: Ensure the script has executable permissions (`chmod +x docker_launcher.sh`), and verify that the directories and files being mounted have appropriate permissions.

### License

This script is distributed under the MIT License.

