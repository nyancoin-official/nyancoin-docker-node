# Quick rebuild script

docker stop nyannode
docker rm nyannode
docker rmi nyanimage
docker build -t='nyanimage' .
docker run -p 33700:33700 --name nyannode nyanimage
