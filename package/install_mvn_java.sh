#!/bin/bash

# Usage: ./install_mvn_java.sh java <java_version> maven <maven_version>
# Example: ./install_mvn_java.sh java 17 maven 3.9.6

set -e

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    java)
      JAVA_VERSION="$2"
      shift 2
      ;;
    maven)
      MAVEN_VERSION="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Usage: ./install_mvn_java.sh java <version> maven <version>"
      exit 1
      ;;
  esac
done

# Derived variables
JAVA_PACKAGE="openjdk-${JAVA_VERSION}-jre-headless"
JAVA_HOME="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64"
MAVEN_INSTALL_DIR="/opt/mvn-${MAVEN_VERSION}"
MAVEN_DOWNLOAD_URL="https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz"

# Function: Install Java if not present
install_java() {
  echo " Checking for Java package: $JAVA_PACKAGE"
  if dpkg -s "$JAVA_PACKAGE" &> /dev/null; then
    echo "Java $JAVA_VERSION already installed."
  else
    echo " Installing Java $JAVA_VERSION..."
    sudo apt-get update
    sudo apt-get install -y "$JAVA_PACKAGE"
    echo " Java installed at $JAVA_HOME"
  fi
}

# Function: Install Maven if not present
install_maven() {
  echo " Checking for Maven in $MAVEN_INSTALL_DIR"
  if [[ -d "$MAVEN_INSTALL_DIR" ]]; then
    echo " Maven $MAVEN_VERSION already installed."
  else
    echo " Installing Maven $MAVEN_VERSION..."
    wget -q "$MAVEN_DOWNLOAD_URL" -O /tmp/maven.tar.gz
    sudo mkdir -p "$MAVEN_INSTALL_DIR"
    sudo tar -xzf /tmp/maven.tar.gz -C "$MAVEN_INSTALL_DIR" --strip-components=1
    rm /tmp/maven.tar.gz
    echo " Maven installed at $MAVEN_INSTALL_DIR"
  fi
}

# Function: Export environment variables
setup_env() {
  echo " Setting up environment variables..."
  export JAVA_HOME="$JAVA_HOME"
  export PATH="$MAVEN_INSTALL_DIR/bin:$PATH"
  echo "JAVA_HOME=$JAVA_HOME"
  echo "MAVEN_HOME=$MAVEN_INSTALL_DIR"
}

# Main execution
install_java
install_maven
setup_env
