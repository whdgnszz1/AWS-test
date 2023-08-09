#!/usr/bin/env bash

REPOSITORY=/home/ubuntu/jonghun
FLASK_APP_DIR=/home/ubuntu/jonghun
cd $REPOSITORY

JAR_NAME=$(ls $REPOSITORY/build/libs/ | grep 'SNAPSHOT.jar' | tail -n 1)
JAR_PATH=$REPOSITORY/build/libs/$JAR_NAME

# Flask 앱 인스턴스 종료
FLASK_PID=$(pgrep -f gunicorn)
if [ -z $FLASK_PID ]
then
  echo "> 종료할 Flask 애플리케이션이 없습니다."
else
  echo "> kill Flask app with PID: $FLASK_PID"
  kill -15 $FLASK_PID
  sleep 5
fi

# Java 애플리케이션 인스턴스 종료
JAVA_PID=$(pgrep -f $JAR_NAME)
if [ -z $JAVA_PID ]
then
  echo "> 종료할 Java 애플리케이션이 없습니다."
else
  echo "> kill Java app with PID: $JAVA_PID"
  kill -15 $JAVA_PID
  sleep 5
fi

echo "> Deploy - $JAR_PATH "
nohup java -jar $JAR_PATH > /dev/null 2> /dev/null < /dev/null &

# Flask 앱 시작
echo "> Starting Flask app with gunicorn"
cd $FLASK_APP_DIR
nohup gunicorn -w 4 app:app -b 0.0.0.0:5002 > /dev/null 2> /dev/null < /dev/null &
