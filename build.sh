docker build -f Dockerfile.ci -t simple-docker-demo:latest .
cache_container=`docker run -d -v /tmp/mydummycache:/root/.gradle simple-cache-docker-demo:latest /bin/true`
container=`docker run --volumes-from=${cache_container} -itd simple-docker-demo:latest ./gradlew build`
docker logs -f $container
exit_status=`docker wait ${container}`
#docker cp $container:/root/.gradle /tmp/d8/
#new_cache_container=`docker run -v /tmp/mydummycache:/root/.gradle -itd simple-cache-docker-demo:latest /bin/sh`
#docker cp /tmp/d8/.gradle/ $new_cache_container:/root/
#docker commit $new_cache_container simple-cache-docker-demo:latest
#docker rm -f $new_cache_container
docker rm -f $cache_container
echo "Exit code is: ${exit_status}"
#exit $(exit_status)