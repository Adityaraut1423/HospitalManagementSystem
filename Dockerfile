# Stage 1: Build using JDK 17
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run on Tomcat 10
FROM tomcat:10.1-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Disable Tomcat shutdown port (fixes 502 Bad Gateway / invalid shutdown command issue)
RUN sed -i 's/port="8005"/port="-1"/g' /usr/local/tomcat/conf/server.xml

# Skip unnecessary TLD JAR scanning to make Tomcat boot in seconds
ENV CATALINA_OPTS="-Dorg.apache.catalina.startup.TldConfig.jarsToSkip=*.jar"

EXPOSE 8080
CMD ["catalina.sh", "run"]