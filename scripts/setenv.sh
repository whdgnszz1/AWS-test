# scripts/set_env_vars.sh

#!/bin/bash

echo "export MONGO_USER=${MONGO_USER}" >> ~/.bashrc
echo "export MONGO_PASS=${MONGO_PASS}" >> ~/.bashrc
echo "export SECRET_KEY=${SECRET_KEY}" >> ~/.bashrc
echo "export FLASK_SECRET_KEY=${FLASK_SECRET_KEY}" >> ~/.bashrc
echo "export GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}" >> ~/.bashrc
echo "export GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}" >> ~/.bashrc
echo "export KAKAO_CLIENT_ID=${KAKAO_CLIENT_ID}" >> ~/.bashrc

# 환경 변수 적용
source ~/.bashrc
