# Stage 1: Build application WAR file
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run Tomcat 10
FROM tomcat:10.1-jdk17-temurin

# Clean default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

# Copy compiled WAR file
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

ENV PORT=8080
EXPOSE 8080

# Configure Tomcat to bind directly to $PORT without touching server.xml
CMD ["sh", "-c", "export CATALINA_OPTS=\"-Dport.http=${PORT:-8080}\" && exec catalina.sh run"]