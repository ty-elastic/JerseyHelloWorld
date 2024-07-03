FROM maven:3.9.7-eclipse-temurin-21 AS builder

RUN mkdir /prj
WORKDIR /prj

COPY hello-world-example /prj/hello-world-example
COPY pom.xml /prj/

RUN mvn package

FROM eclipse-temurin:21

RUN mkdir /opt/app
WORKDIR /opt/app

COPY elastic-otel-javaagent-0.4.0.jar /opt/app/elastic-otel-javaagent-0.4.0.jar
COPY --from=builder /prj/hello-world-example/target/hello-world-example-0.1-SNAPSHOT.jar /opt/app/hello-world-example-0.1-SNAPSHOT.jar
COPY --from=builder /prj/target/lib/*.jar /opt/app/lib/

# RUN sysctl kernel.perf_event_paranoid=1
# RUN sysctl kernel.kptr_restrict=0

CMD ["java", "-javaagent:/opt/app/elastic-otel-javaagent-0.4.0.jar", \
    "-Dotel.service.name=java_test", \
    "-Dotel.javaagent.debug=true", \
    "-Delastic.otel.inferred.spans.enabled=true", \
    "-Delastic.otel.inferred.spans.sampling.interval=1ms", \
    "-Delastic.otel.inferred.spans.min.duration=0ms", \
    "-classpath", "/opt/app/lib/*.jar", \
    "-jar", "/opt/app/hello-world-example-0.1-SNAPSHOT.jar", \
    "com.howtodoinjava.demo.Main"]
