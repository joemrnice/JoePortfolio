#!/bin/bash
APP_PORT=${PORT:-8080}

echo "================================================"
echo " JoePortfolio — Starting on port $APP_PORT"
echo " DB Host     : ${MYSQL_HOST:-localhost}"
echo " DB Name     : ${MYSQL_DATABASE:-joe_portfolio}"
echo "================================================"

sed -i \
  "s/port=\"8080\"/port=\"${APP_PORT}\"/" \
  /usr/local/tomcat/conf/server.xml

echo "✔ Tomcat configured for port $APP_PORT"
echo "✔ Starting Catalina..."

exec catalina.sh run
