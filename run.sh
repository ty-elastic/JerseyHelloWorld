docker build -t test .
docker run --env-file .env -v $PWD/diag:/tmp/profiler -p 8080:8080 test