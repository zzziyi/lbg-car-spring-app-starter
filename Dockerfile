# Use Maven base image to build the project
FROM maven:3.6.3-jdk-11 as build
WORKDIR /app
COPY pom.xml .
# Copy the source code
COPY src ./src
# Build the application
RUN mvn clean package

# Use OpenJDK for the application image
FROM openjdk:11-jre-slim
WORKDIR /app
# Copy the built artifact from the build stage
COPY --from=build /app/target/*.jar app.jar
# Expose the port the app runs on
EXPOSE 8000
# Run the application
CMD ["java", "-jar", "app.jar"]
