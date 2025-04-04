# Build stage
FROM gradle:8.5-jdk17 AS build
WORKDIR /app
COPY . .
RUN gradle build -x test

# Run stage
FROM openjdk:17-slim
WORKDIR /app

# Copy jar file từ build stage
COPY --from=build /app/build/libs/*.jar app.jar

# Expose port cho Eureka Server
EXPOSE 8761

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=prod
ENV EUREKA_SERVER_PORT=8761

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"] 