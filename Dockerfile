FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# 1. On copie le pom.xml seul
COPY pom.xml .

# 2. On télécharge les dépendances (cette couche sera mise en cache)
RUN mvn dependency:go-offline

# 3. On copie le reste du projet (le code source)
COPY src ./src

# 4. On compile (très rapide car les JARs sont déjà là !)
RUN mvn clean package

FROM tomcat:10.1-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY lib/postgresql-42.7.9.jar /usr/local/tomcat/lib/
COPY lib/urlrewritefilter-5.1.3.jar /usr/local/tomcat/lib/

# On récupère le fichier .war généré pour le mettre dans Tomcat
# Maven nomme le fichier "ROOT.war" car nous l'avons précisé dans le pom.xml
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]