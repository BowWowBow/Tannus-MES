FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean bootJar -x test

EXPOSE 8080

ENTRYPOINT ["sh","-c","java -jar build/libs/*.jar"]