FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

FROM tomcat:10.1-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY lib/postgresql-42.7.9.jar /usr/local/tomcat/lib/

# On récupère le fichier .war généré pour le mettre dans Tomcat
# Maven nomme le fichier "ROOT.war" car nous l'avons précisé dans le pom.xml
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]