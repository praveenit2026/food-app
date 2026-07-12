# ── Stage 1: Build ────────────────────────────────────────────────
FROM tomcat:10.1-jdk17 AS builder

WORKDIR /app

COPY src/ src/

RUN mkdir -p build/classes

RUN find src/main/java -name '*.java' > sources.txt \
 && javac -d build/classes \
          -cp /usr/local/tomcat/lib/servlet-api.jar:/usr/local/tomcat/lib/jsp-api.jar:src/main/webapp/WEB-INF/lib/postgresql-42.7.3.jar \
          @sources.txt

RUN mkdir -p src/main/webapp/WEB-INF/classes \
 && cp -r build/classes/* src/main/webapp/WEB-INF/classes/ \
 && jar -cvf ROOT.war -C src/main/webapp .

# ── Stage 2: Runtime ──────────────────────────────────────────────
FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

COPY --from=builder /app/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Disable shutdown port (-1) to prevent Render health checks hitting it
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/' \
    /usr/local/tomcat/conf/server.xml

# Render.com sets $PORT - patch Tomcat's HTTP connector port at startup
ENTRYPOINT ["sh", "-c", \
  "PORT=${PORT:-8080}; \
   sed -i \"s/port=\\\"8080\\\"/port=\\\"$PORT\\\"/\" /usr/local/tomcat/conf/server.xml; \
   catalina.sh run"]

EXPOSE 8080