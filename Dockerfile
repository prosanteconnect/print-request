FROM maven:3-jdk-11 AS build
COPY settings-docker.xml /usr/share/maven/ref/
COPY pom.xml /usr/src/app/pom.xml
COPY src /usr/src/app/src
RUN mvn -f /usr/src/app/pom.xml -DskipTests clean package

FROM openjdk:11-slim-buster
COPY --from=build /usr/src/app/target/print-request-*.jar /usr/app/print-request.jar
USER daemon
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "exec java -jar /usr/app/print-request.jar"]
