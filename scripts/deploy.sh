REPOSITORY=/home/ubuntu/jonghun
NODE_APP_DIR=$REPOSITORY/node_level4-5_express
ENV_PATH=$NODE_APP_DIR/src/.env

cd $REPOSITORY

NODE_PID=$(pgrep -f "node")
if [ -z $NODE_PID ]
then
  echo "> 종료할 Node Express 애플리케이션이 없습니다."
else
  echo "> kill Node Express app with PID: $NODE_PID"
  kill -15 $NODE_PID
  sleep 5
fi

# .env 파일 존재 여부 확인
if [ -f $ENV_PATH ]; then
    echo "> .env 파일이 존재합니다."
    cat $ENV_PATH
    source $ENV_PATH
else
    echo "> .env 파일이 존재하지 않습니다."
fi

echo "> Installing dependencies"
cd $NODE_APP_DIR
pwd
yarn install

echo "> Starting Node Express app"
pwd
yarn start