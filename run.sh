docker build -t java_otel_test .
docker stop java_otel_test
docker rm java_otel_test
docker run -d --name=java_otel_test --env-file .env -v $PWD/diag:/tmp/profiler -p 8080:8080 java_otel_test
sleep 10

for i in {1..10}
do
    curl 127.0.0.1:8080/items
    sleep 1
done

sleep 5
docker stop java_otel_test
docker logs java_otel_test >& diag/otel.log
tar czf otel_logs.tar.gz diag
