# --- ÉTAPE 1 : Compilation avec Maven et Java 21 ---
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# On copie le fichier de configuration Maven
COPY pom.xml .
# On copie tout le dossier src (ton code et tes JSP)
COPY src ./src

# On lance la compilation
RUN mvn clean package

# --- ÉTAPE 2 : Serveur Tomcat 10 ---
FROM tomcat:10.1-jdk21

# Nettoyage des applications par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# On copie le driver Postgres depuis ton dossier lib local
COPY lib/postgresql-42.7.9.jar /usr/local/tomcat/lib/

# On récupère le fichier .war généré à l'étape 1 pour le mettre dans Tomcat
# Maven nomme le fichier "ROOT.war" car nous l'avons précisé dans le pom.xml
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]