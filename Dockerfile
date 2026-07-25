# Use official Tomcat image with JDK 11
FROM tomcat:9.0-jdk11-openjdk-slim

# Remove default Tomcat sample apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your built WAR file into Tomcat's webapps directory as ROOT.war
# (Naming it ROOT.war makes it serve from the main domain / directly)
COPY target/HospitalManagementSystem.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat's default port
EXPOSE 8080

CMD ["catalina.sh", "run"]