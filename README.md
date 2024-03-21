# Dockerized ResourceSpace

This repository contains a Docker setup for [ResourceSpace](https://www.resourcespace.com/), an open-source Digital Asset Management system. It is designed to simplify the deployment and management of ResourceSpace with Docker, including PHP configurations dynamically adjusted through environment variables.

## Features

- **PHP 8.3**: Uses the latest compatible PHP version for optimal performance and security.
- **Dynamic PHP Configuration**: Leverages environment variables for flexible PHP settings management.
- **Multi-Stage Build**: Ensures a minimal Docker image size by separating the build environment from the production environment.
- **Recommended PHP Extensions**: Includes all PHP extensions recommended by ResourceSpace for full functionality.

## Prerequisites

Before you start, ensure you have Docker and Docker Compose installed on your system. For installation instructions, refer to the official documentation:
- [Install Docker](https://docs.docker.com/get-docker/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

## Quick Start

1. **Clone the Repository**

    ```bash
    git clone https://github.com/greerso/dockerized-resourcespace.git
    cd dockerized-resourcespace
    ```

2. **Environment Configuration**

    Copy the `.env.example` to `.env` and adjust the environment variables according to your needs.

    ```bash
    cp .env.example .env
    ```

3. **Build and Run the Containers**

    Use Docker Compose to build and start the services:

    ```bash
    docker-compose up --build
    ```

4. **Access ResourceSpace**

    Once the containers are up and running, access ResourceSpace through your web browser:

    ```
    http://localhost:8080
    ```

    Adjust the port as per your `docker-compose.yml` configuration if needed.

## Configuration

- **PHP Settings**: Customize PHP settings such as `memory_limit` and `upload_max_filesize` by editing the `.env` file and restarting the containers.
- **ResourceSpace Settings**: Modify the ResourceSpace configuration by editing the `include/config.php` file as required.

## Advanced Usage

For advanced configurations, including setting up SSL, integrating with external services, or performing backups, refer to the `docs` directory.

## Contributing

Contributions to this project are welcome! Please fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the ResourceSpace community for the comprehensive digital asset management system.
- Thanks to Docker for simplifying the deployment and management of applications.
