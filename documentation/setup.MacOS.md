## MacOS setup for Docker DSpace

### Install Docker Desktop

https://docs.docker.com/docker-for-mac/install/

### Open a terminal

Open terminal (in Applications/Utilities)

### Install Git
In your terminal, type the following command. If git is not yet installed, you will be prompted to install developer tools.  Proceed with the installation.

```shell
git version
```

### Download DSpace Docker Compose Files

```shell
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

### Start using DSpace-Docker

- [Run DSpace 6](run.DSpace6.md)
- [Run DSpace 7](run.DSpace7.md)
