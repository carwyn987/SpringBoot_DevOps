docker run -it --user $(id -u):$(id -g) -v "$(pwd)":/home/myuser/app -p 8080:8080 my_springapp

