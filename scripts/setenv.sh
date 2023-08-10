# scripts/set_env_vars.sh

#!/bin/bash

ENV_FILE="/home/ubuntu/jonghun/.env"

# .env 파일에 환경변수 저장
echo "MONGO_USER=${MONGO_USER}" > $ENV_FILE
echo "MONGO_PASS=${MONGO_PASS}" >> $ENV_FILE
echo "SECRET_KEY=${SECRET_KEY}" >> $ENV_FILE
echo "FLASK_SECRET_KEY=${FLASK_SECRET_KEY}" >> $ENV_FILE
echo "GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}" >> $ENV_FILE
echo "GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}" >> $ENV_FILE
echo "KAKAO_CLIENT_ID=${KAKAO_CLIENT_ID}" >> $ENV_FILE
