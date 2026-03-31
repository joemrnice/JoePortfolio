FROM eclipse-temurin:21-jdk-jammy AS build

WORKDIR /build

COPY src/main/java/ ./src/
COPY src/main/webapp/ ./WebContent/

RUN wget -q -O javax.servlet-api.jar \
    "https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar"

RUN mkdir -p ./WebContent/WEB-INF/classes

RUN find src -name "*.java" > sources.txt \
    && javac \
       -encoding UTF-8 \
       -cp "WebContent/WEB-INF/lib/*:javax.servlet-api.jar" \
       -d WebContent/WEB-INF/classes \
       @sources.txt \
    && echo "✔ Compilation successful"


RUN cd WebContent \
    && jar -cvf /build/ROOT.war . \
    && echo "✔ WAR created"


FROM tomcat:10.1-jdk21-temurin-jammy

LABEL maintainer="Code Zerra"
LABEL description="JoePortfolio — J2EE Portfolio App"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /build/ROOT.war \
     /usr/local/tomcat/webapps/ROOT.war

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 8080

CMD ["/startup.sh"]

# Stage 1: Build the WAR file
# WORKDIR /app
#COPY . .
# Replace with ./gradlew build if using Gradle
#RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat

# Remove default webapps
#RUN rm -rf /usr/local/tomcat/webapps/*
# Copy war file from build stage to tomcat deployment directory
#COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

#EXPOSE 8080
#CMD ["catalina.sh", "run"]

