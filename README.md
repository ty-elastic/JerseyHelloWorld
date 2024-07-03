# ENV

create a `.env` file like
```
OTEL_EXPORTER_OTLP_ENDPOINT=https://abc123.apm.region.provider.cloud.es.io:443
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Bearer xyz456
```

# BUILD and RUN

`./run.sh`

After running, a file `otel_logs.tar.gz` will be created with diags.
