# Stage 1: Build WAR file using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat 10
FROM tomcat:10.1-jdk17-temurin

# Remove default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

# Copy compiled WAR file
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Disable shutdown port (set to -1) and set HTTP connector port to Render's dynamic PORT variable
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/g' /usr/local/tomcat/conf/server.xml \
    && sed -i 's/port="8080"/port="${env.PORT}"/g' /usr/local/tomcat/conf/server.xml

ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]