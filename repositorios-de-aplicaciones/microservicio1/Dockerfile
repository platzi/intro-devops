FROM maven:3.8.5-jdk-11 AS builder
WORKDIR /app
copy . .
run mvn install

FROM openjdk:11.0.14.1-jdk-slim-buster as run
WORKDIR /app
ARG JAR_FILE=/app/target/*.jar
COPY --from=builder $JAR_FILE /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]
