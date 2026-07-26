# Stage 1: Build the WAR file using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy pom.xml first to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source files and package
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run Tomcat 10
FROM tomcat:10.1-jdk17-temurin

# Remove default ROOT application
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

# Copy compiled WAR file from builder
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Dynamically map Render PORT to Tomcat
ENV PORT=8080
RUN sed -i 's/port="8080"/port="${env.PORT}"/g' /usr/local/tomcat/conf/server.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]