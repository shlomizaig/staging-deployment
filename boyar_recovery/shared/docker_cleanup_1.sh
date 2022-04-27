# NOT WORKING 
# Delete "Dead" or "Exited" containers.
# docker rm $(docker ps -a | grep "Dead\|Exited" | awk '{print $1}')
# #Delete dangling docker images.
# docker rmi -f $(docker images -qf dangling=true)
# #Delete or clean up unused docker volumes.
# docker rmi -f $(docker volume ls -qf dangling=true)