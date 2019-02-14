## Linux Desktop setup for Docker DSpace

_These instructions are under construction._
_apt-get equivalents need to be documented._

### Install Git

```shell
sudo yum install git
```

### Install Docker


```shell
sudo yum install docker
```

###  Docker Compose

- [Install Docker compose](https://docs.docker.com/compose/install/#install-compose)

### Download DSpace Docker Compose Files

```shell
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

### Next Steps

- [Run DSpace 6](run.DSpace6.md)
- [Run DSpace 7](run.DSpace7.md)
