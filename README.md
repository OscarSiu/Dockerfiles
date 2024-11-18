# Docker User Guide
Initiated by Oscar Siu

 **Last update: 23 SEP 2022**
 
![docker in windows：叡揚部落格](https://i.imgur.com/rQvkvnM.png)

## Installing Docker

Install updates
```
sudo apt update
sudo apt dist-upgrade
```
Install docker
```
sudo apt install docker.io
systemctl status docker #check status
sudo systemctl enable docker
sudo systemctl start docker
```
 Add user to docker group
 
`sudo usermod -aG docker username>`

Reboot

Run docker

`sudo docker run hello-world`


## Docker commands
Check if docker is correctly installed and its version

`docker version`

`docker info`

Search for available container images

`docker search`

Show locally downloaded images

`docker images`

Download image on docker

`docker pull ubuntu`

Show all containers

`docker ps -a`

Run container

`docker run -it -d ubuntu bash#interactive terminal & demon mode`

Disconnect from container without stopping it
__Ctrl + p & q__ 

`docker run -it -d -p 8080:80 nginx`

Stop the container

`docker stop [container ID]`

## Create images
Make changes inside container
```
#example
apt install apache2 
/etc/init.d/apache2 start
```

Create image from still-running container

`docker commit [container id] [image name]`

Alter entry point of container

`docker commit --change='ENTRYPOINT ["apachectl", "-DFOREGROUND"]' [container ID] [image name]`

Launch container from new image

`docker run -d -it -p --rm 8080:80 [image name]`


## Create container image from Dockerfile

Save following code into a textfile, named __Dockerfile__
```
 FROM ubuntu
 MAINTAINER Oscar <email>
 
 # Skip prompts
 ARG DEBIAN_FRONTEND=noninteractive
 
 # Update packages
 RUN apt update; apt dist-upgrade -y
 
 # Install packages
 RUN apt install -y apache2 vim-nox
 
 # Set entrypoint
 ENTRYPOINT apache2ctl -D FOREGROUND
```

Build container image from Dockerfile, by running the command from the same repository containing the Dockerfile.

`docker build -t [image name] .`

## Useful links

[Dockerhub](https://hub.docker.com/search?q=)

[Docker run reference](https://docs.docker.com/engine/reference/run/)

[Dockerfile guide](https://www.jinnsblog.com/2018/12/docker-dockerfile-guide.html)



