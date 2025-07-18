FROM gradle:8.10.2-jdk21 as builder

WORKDIR /fineract

COPY . .

# Compila el .jar sin ejecutar pruebas
RUN gradle -x test bootJar && \
    mv fineract-provider/build/libs/fineract-provider-*.jar fineract-provider/build/libs/fineract-provider.jar

# Segunda etapa para una imagen más ligera
FROM openjdk:21-jdk-slim

WORKDIR /fineract

# Copia el JAR generado desde la etapa anterior
COPY --from=builder /fineract/fineract-provider/build/libs/fineract-provider.jar fineract-provider/build/libs/fineract-provider.jar

EXPOSE 8443

CMD ["java", "-jar", "fineract-provider/build/libs/fineract-provider.jar"]
