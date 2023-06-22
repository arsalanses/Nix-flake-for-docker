# Nix Flake for Docker

## Description

This project is a simple example of how to use Nix flake to create a Docker image. 

## Prerequisites

You will need the following software installed on your machine before running this project:

- Nix (version 2.4 or higher)
- Docker (version 19+)

## Getting Started

To get started, clone the repository by running the following command:

```bash
git clone https://github.com/arsalanses/nix-flake-for-docker.git
```

Then, navigate to the project directory:

```bash
cd <project-name>
```

## Usage

To build the Docker image, run the following command:

```bash
nix build .#
docker load < result
```

This will create a Docker image named `mycurl` in the project directory.

To run the Docker image, use the following command:

```bash
docker run --rm -it mycurl:0.1.0
```

This will start a container running the `mycurl` image.

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request. 

## License

This project is licensed under the MIT License.
