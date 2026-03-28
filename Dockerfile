FROM tomcat:10.1.53-jdk21-bookworm

RUN rm -rf /usr/local/tomcat/webapps/*

COPY lib/postgres-42.7.9.jar /usr/local/tomcat/lib/

# Le fichier .war de votre application sera copié dans webapps
# COPY target/votre-app.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]