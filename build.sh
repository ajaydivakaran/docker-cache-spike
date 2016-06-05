docker build -f Dockerfile.ci -t simple-docker-demo:latest .
container=`docker run -itd simple-docker-demo:latest ./gradlew build`
docker logs -f $container
exit_status=`docker wait ${container}`
rm -rf /tmp/d8
docker cp $container:/root/.gradle /tmp/d8/
cache_container=`docker run -itd simple-docker-demo:latest /bin/sh`
docker cp /tmp/d8/ $cache_container:/root/.gradle/
docker commit $cache_container simple-cache-docker-demo:latest
docker rm -f $cache_container
docker rm -f $container
echo "Exit code is: ${exit_status}"
#exit $(exit_status)