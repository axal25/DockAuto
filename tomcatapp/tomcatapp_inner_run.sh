#! /bin/sh

echo "---------------------------------"
echo "pwd"
pwd

echo "---------------------------------"
echo "cd /"
cd /

echo "---------------------------------"
echo "
source /shell_functions.sh"
source /shell_functions.sh

#echo "---------------------------------"
#echo "
#/shell_functions.sh"
#/shell_functions.sh

echo "---------------------------------"
echo "git clone https://github.com/axal25/SecureApplicationPractices.git"
git clone https://github.com/axal25/SecureApplicationPractices.git

echo "---------------------------------"
echo "mvn clean install -f /SecureApplicationPractices/SecureAppPractices"
mvn dependency:go-offline -B -f /SecureApplicationPractices/SecureAppPractices
mvn clean install -f /SecureApplicationPractices/SecureAppPractices -DskipTests="true"

echo "---------------------------------"
echo "ls /SecureApplicationPractices/SecureAppPractices/target"
ls /SecureApplicationPractices/SecureAppPractices/target

echo "---------------------------------"
echo "java -jar /SecureApplicationPractices/SecureAppPractices/target/SecureAppPractices-0.0.1-SNAPSHOT.jar"
java -jar /SecureApplicationPractices/SecureAppPractices/target/SecureAppPractices-0.0.1-SNAPSHOT.jar

ls
ls /usr/local/tomcat

/usr/local/tomcat/bin/catalina.sh run
