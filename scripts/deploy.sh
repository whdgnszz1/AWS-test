#!/usr/bin/env bash

REPOSITORY=/home/ubuntu/jonghun
FLASK_APP_DIR=/home/ubuntu/jonghun
LOG_PATH=$FLASK_APP_DIR/logs/gunicorn.log
cd $REPOSITORY

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

if [ -d "$FLASK_APP_DIR/venv" ]; then
    echo "> Activating existing virtual environment"
    source $FLASK_APP_DIR/venv/bin/activate
else
    echo "> Setting up new virtual environment"
    python3 -m venv $FLASK_APP_DIR/venv
    source $FLASK_APP_DIR/venv/bin/activate
    echo "> Installing dependencies"
    pip install -r $FLASK_APP_DIR/requirements.txt
fi

# Flask 앱 시작
echo "> Starting Flask app with gunicorn"
cd $FLASK_APP_DIR
source $FLASK_APP_DIR/venv/bin/activate
nohup gunicorn -w 4 app:app -b 0.0.0.0:5002 > $LOG_PATH 2>&1 &
