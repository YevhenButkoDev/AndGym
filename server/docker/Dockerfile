# Stage 1: Build the application with Maven
FROM maven:3.9-eclipse-temurin-21 as builder

# Set working directory
WORKDIR /app

# Copy Maven project files
COPY server/pom.xml .
COPY server/src ./src

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# Stage 2: Use a lightweight JRE base image to run the app
FROM eclipse-temurin:21-jre-alpine

# Set working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/Server-1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]