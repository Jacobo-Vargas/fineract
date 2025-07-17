FROM openjdk:21-jdk-slim

# Instala herramientas necesarias
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    build-essential \
    findutils \
 && apt-get clean

# Crea directorio de trabajo
WORKDIR /fineract

# Copia todos los archivos al contenedor
COPY . .

# Compila el .jar sin ejecutar pruebas
RUN chmod +x ./gradlew && ./gradlew -x test bootJar && \
    mv fineract-provider/build/libs/fineract-provider-*.jar fineract-provider/build/libs/fineract-provider.jar


# Exponer el puerto por defecto
EXPOSE 8443

# Comando de inicio
CMD ["java", "-jar", "fineract-provider/build/libs/fineract-provider.jar"]
