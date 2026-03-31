#!/bin/bash

# ==============================
# CONFIGURATION
# ==============================
PROJECT_DIR=$(pwd)
TOMCAT_DIR=/home/valisoa/Documents/apache-tomcat-10.1.28   # ⚠️ adapte ce chemin
BUILD_DIR=build
SRC_DIR=src/main/java
WEB_APP_FOLDER=src/main/webapp
WAR_NAME=mini_projet_web_design.war
LIB_DIR=lib

# ==============================
# NETTOYAGE
# ==============================
echo "🧹 Nettoyage..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/WEB-INF/classes"
mkdir -p "$BUILD_DIR/WEB-INF/lib"

# ==============================
# COMPILATION JAVA
# ==============================a
echo "🔨 Compilation des classes Java..."
# Compile toutes les classes Java du projet
javac -d "$BUILD_DIR/WEB-INF/classes" -cp "$LIB_DIR/servlet-api.jar" $(find "$SRC_DIR" -name "*.java")

if [ $? -ne 0 ]; then
    echo "❌ Erreur de compilation"
    exit 1
fi

# ==============================
# COPIE DES FICHIERS WEB
# ==============================
echo "📁 Copie des fichiers web..."
cp -r "$WEB_APP_FOLDER/"* "$BUILD_DIR/"

# ==============================
# COPIE DES LIBRAIRIES
# ==============================
echo "📦 Copie des librairies..."
cp "$LIB_DIR/"*.jar "$BUILD_DIR/WEB-INF/lib/"

# ==============================
# CREATION DU WAR
# ==============================
echo "📦 Création du WAR..."
cd "$BUILD_DIR" || exit
jar -cvf "$WAR_NAME" .
cd ..

# ==============================
# DEPLOIEMENT TOMCAT
# ==============================
echo "🛑 Arrêt de Tomcat..."
"$TOMCAT_DIR/bin/shutdown.sh"
sleep 3

echo "🧹 Nettoyage ancien déploiement..."
rm -rf "$TOMCAT_DIR/webapps/test_referencement"*
# ⚠️ Si tu veux mettre ton projet à la racine : 
# WAR_NAME=ROOT.war
# rm -rf "$TOMCAT_DIR/webapps/ROOT"

echo "📦 Copie du WAR dans Tomcat..."
cp "$BUILD_DIR/$WAR_NAME" "$TOMCAT_DIR/webapps/"

echo "🚀 Démarrage Tomcat..."
"$TOMCAT_DIR/bin/startup.sh"

echo "✅ Déploiement terminé !"