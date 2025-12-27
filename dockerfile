# Stage 1: Build stage
FROM maven:3.9.9-eclipse-temurin-11 AS build-stage
# Set the working directory inside the container
WORKDIR /app
# Copy the Maven project definition files
COPY pom.xml /app/pom.xml
# Download the dependencies needed for the build (cache them in a separate layer)
RUN mvn dependency:go-offline
# Copy the application source code
copy ./src /app/src

# Build the WAR file
RUN mvn package

# Stage 2: Production stage
FROM tomcat:8.5-jdk11-temurin
# Copy the built WAR file from the build stage to the Tomcat webapps directory
COPY --from=build-stage /app/target/*.war /usr/local/tomcat/webapps/
# Expose the port on which Tomcat will listen (usually port 8080)
EXPOSE 8080
# Start Tomcat
CMD ["catalina.sh", "run"]
