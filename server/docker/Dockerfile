# Use a lightweight OpenJDK image
FROM openjdk:21

# Set the working directory
WORKDIR /app

# Copy the JAR file
COPY Server-1.0-SNAPSHOT.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Start the app with env vars support
ENTRYPOINT ["java", "-jar", "app.jar"]