REPOSITORY=/home/ubuntu/jonghun/node_level4-5_express
NODE_APP_DIR=/home/ubuntu/jonghun/node_level4-5_express
ENV_PATH=$NODE_APP_DIR/node_level4-5_express/src/.env
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

if [ -f $ENV_PATH ]; then
    source $ENV_PATH
fi

echo "> Installing dependencies"
cd $NODE_APP_DIR
yarn install

# Node Express 앱 시작
echo "> Starting Node Express app"
cd $NODE_APP_DIR
yarn start
