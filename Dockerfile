# Step 1: Build application using Maven and JDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Deploy to Tomcat 10
FROM tomcat:10.1-jdk17-temurin

# Remove default root app
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war

# Copy compiled WAR file as ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Configure Tomcat to listen to Render's $PORT (defaulting to 8080 if not set)
ENV PORT=8080
RUN sed -i 's/port="8080"/port="${env.PORT}"/g' /usr/local/tomcat/conf/server.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]