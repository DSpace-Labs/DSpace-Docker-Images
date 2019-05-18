{% include nav.html %}
## Linux Desktop setup for Docker DSpace


### Install Git

_Instructions will vary based on your Linux distribution._
_These instructions have not been tested.  Please report your results with these instructions._

#### CentOS

```shell
sudo yum install git
```

#### Debian, Ubuntu

```shell
sudo apt-get install git
```

#### Fedora

```shell
sudo dnf install git
```

### Install Docker CE for your Linux distribution
- [CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
- [Debian](https://docs.docker.com/install/linux/docker-ce/debian/)
- [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- [Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)
  - Note: current docker-compose file are not compatible with selinux. Consider disabling selinux for testing.

### Verify Running Docker from your Terminal

```shell
winpty docker run -it --rm ubuntu /bin/bash
```

Enter `echo hello` then enter `exit`

```
root@653eeaeb274b:/# echo hello
hello
root@653eeaeb274b:/# exit
exit
```

### Download DSpace Docker Compose Files

```shell
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

### Verify Docker Compose


### Start Using DSpace-Docker

- [Run DSpace 6](run.DSpace6.md)
- [Run DSpace 7](run.DSpace7.md)
- [Run DSpace 7 with Configurable Entities Data](run.DSpace7Entities.md)
