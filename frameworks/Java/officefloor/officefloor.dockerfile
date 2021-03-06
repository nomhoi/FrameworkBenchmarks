FROM maven:3.6.3 as maven
WORKDIR /officefloor
COPY src src
WORKDIR /officefloor/src/woof_benchmark
RUN mvn -B clean package

FROM openjdk:15
WORKDIR /officefloor
COPY --from=maven /officefloor/src/woof_benchmark/target/woof_benchmark-1.0.0.jar server.jar
CMD ["java", "-server", "-Xms2g", "-Xmx2g", "-XX:+UseNUMA", "-XX:+UseParallelGC", "-Dhttp.port=8080", "-Dhttp.server.name=OF", "-Dhttp.date.header=true", "-jar", "server.jar"]
