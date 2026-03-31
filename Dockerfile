FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /build

COPY src/       ./src/
COPY WebContent/ ./WebContent/

RUN mkdir -p ./WebContent/WEB-INF/classes

RUN find src -name "*.java" > sources.txt \
    && javac \
       -encoding UTF-8 \
       -cp "WebContent/WEB-INF/lib/*" \
       -d WebContent/WEB-INF/classes \
       @sources.txt \
    && echo "✔ Compilation successful"


RUN cd WebContent \
    && jar -cvf /build/ROOT.war . \
    && echo "✔ WAR created"


FROM tomcat:9.0-jdk17-temurin-jammy

LABEL maintainer="Code Zerra"
LABEL description="JoePortfolio — J2EE Portfolio App"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /build/ROOT.war \
     /usr/local/tomcat/webapps/ROOT.war

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

EXPOSE 8080

CMD ["/startup.sh"]
