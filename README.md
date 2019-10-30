# Vue-Symfony-MariaDB-in-Docker
Complete stack for an web API based application.

## 1) Installation

### Pre-requisites

Before installing, you need to install :
- [docker](https://docs.docker.com/install/) and set [rights for non-root users](https://docs.docker.com/install/linux/linux-postinstall/) if you are on a linux platform.
- [docker-compose](https://docs.docker.com/compose/install/). This is shipped with Docker for mac. Therefore, you only need to install it on linux plateforms.

### Setup & run

1. Clone the repository
```shell script
$> git clone git@github.com:Kodmit/Vue-Symfony-Postgres-in-Docker.git
```

2. Go to the root of the directory and init the project
```shell script
$> cd golem_symfony
$> make init
```

3. Then run the local environment
```shell script
$> make up
```

Type `make help` to get a list of available commands.

## 2) How to use

### Web paths

**Symfony App**: http://localhost:80  
**VueJS App**: http://localhost:3000  
**PhpMyAdmin**: http://localhost:8080  
**MailDev**: http://localhost:8001  

### Database
**MariaDB**  
HOST: localhost  
PORT: 3306   
DATABASE: docker  
USER: user  
PASSWORD: password  

## 3) Conventions

### Commits
**Never ever commit on master**  
All commits must be on this convention : _\[feature\] description_  
(eg: _\[register\] Change validation button text_)  

New features must be developed on a new branch, when the feature is done, please do a merge request on the target branch
and wait for a code review before merging and delete the source branch.

### Coding
#### Javascript
**variables**: camelCase  
**preset**: Airbnb with es-lint  
**Please follow and read these standards**  
https://github.com/airbnb/javascript

#### PHP
**Please follow the PSR standards**  
https://www.php-fig.org/psr/psr-1/  
https://www.php-fig.org/psr/psr-7/

## 4) Maintainer
