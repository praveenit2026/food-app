# Stage 1: Compile and Build
FROM tomcat:10.1-jdk17 AS builder

WORKDIR /app

COPY src/ src/

RUN mkdir -p build/classes

RUN find src/main/java -name '*.java' > sources.txt && javac -d build/classes -cp /usr/local/tomcat/lib/servlet-api.jar:/usr/local/tomcat/lib/jsp-api.jar:src/main/webapp/WEB-INF/lib/mysql-connector-j-8.2.0.jar @sources.txt

RUN jar -cvf ROOT.war -C build/classes . -C src/main/webapp .

# Stage 2: Runtime
FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/examples /usr/local/tomcat/webapps/docs /usr/local/tomcat/webapps/host-manager /usr/local/tomcat/webapps/manager

COPY --from=builder /app/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
