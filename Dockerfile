# Stage 1: Build application WAR file using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat 10
FROM tomcat:10.1-jdk17-temurin

# Clean default webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

# Copy compiled WAR file as ROOT.war
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# 1. Disable Tomcat shutdown port
# 2. Map Tomcat HTTP Connector to Java System Property ${port} with default 8080 fallback
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/g' /usr/local/tomcat/conf/server.xml \
    && sed -i 's/port="8080"/port="${port:8080}"/g' /usr/local/tomcat/conf/server.xml

ENV PORT=8080
ENV CATALINA_OPTS="-Dport=${PORT}"

EXPOSE 8080

CMD ["catalina.sh", "run"]