
FROM maven:3.9.7-eclipse-temurin-21 AS builder

RUN mkdir /prj
WORKDIR /prj

COPY hello-world-example /prj/hello-world-example
COPY pom.xml /prj/

RUN mvn package

FROM eclipse-temurin:21

RUN mkdir /opt/app
WORKDIR /opt/app

ARG ELASTIC_OTEL_JAVAAGENT_VERSION=0.4.1-SNAPSHOT
ARG APP_VERSION=0.2
ARG APP_NAME="otel_inferred_spans_test"

COPY elastic-otel-javaagent-${ELASTIC_OTEL_JAVAAGENT_VERSION}.jar /opt/app/elastic-otel-javaagent.jar
COPY --from=builder /prj/hello-world-example/target/hello-world-example-0.1-SNAPSHOT.jar /opt/app/hello-world-example-0.1-SNAPSHOT.jar
COPY --from=builder /prj/target/lib/*.jar /opt/app/lib/

ENV OTEL_RESOURCE_ATTRIBUTES="service.name=${APP_NAME},service.version=${APP_VERSION}"

CMD ["java", "-javaagent:/opt/app/elastic-otel-javaagent.jar", \
    "-Dotel.javaagent.debug=true", \
    "-Djava.io.tmpdir=/tmp/profiler", \
    "-Delastic.otel.inferred.spans.backup.diagnostic.files=true", \
    "-Delastic.otel.inferred.spans.enabled=true", \
    "-Delastic.otel.inferred.spans.sampling.interval=1ms", \
    "-Delastic.otel.inferred.spans.min.duration=0ms", \
    "-classpath", "/opt/app/lib/*.jar", \
    "-jar", "/opt/app/hello-world-example-0.1-SNAPSHOT.jar", \
    "com.howtodoinjava.demo.Main"]
