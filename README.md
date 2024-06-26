# ENV

create a `.env` file like
```
OTEL_EXPORTER_OTLP_ENDPOINT=https://abc123.apm.region.provider.cloud.es.io:443
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Bearer xyz456
```

# BUILD

`docker build -t test .`

# RUN

`docker run --env-file .env -p 8080:8080 test`
