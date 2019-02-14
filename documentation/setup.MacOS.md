## MacOS setup for Docker DSpace

### Install Docker Desktop

https://dspace-labs.github.io/DSpace-Docker-Images/documentation/tutorialSetup.html

### Open a terminal

Open terminal (in Applications/Utilities)

### Install Git
In your terminal, type the following command

```shell
git version
```
- If git is not yet installed, you will be prompted to install developer tools.  Proceed with the installation.


### Download DSpace Docker Compose Files

```shell
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

### Next Steps

- [Run DSpace 6](run.DSpace6.md)
- [Run DSpace 7](run.DSpace7.md)
