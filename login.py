from flask import request, jsonify, make_response, render_template, redirect, url_for, session
from flask_oauthlib.client import OAuth
from pymongo import MongoClient
from datetime import datetime, timedelta
import jwt
import certifi

# 환경변수 설정
import os
from dotenv import load_dotenv
load_dotenv()
MONGO_USER = os.environ.get('MONGO_USER')
MONGO_PASS = os.environ.get('MONGO_PASS')
SECRET_KEY = os.environ.get('SECRET_KEY')

 
# 몽고DB 연결  
ca = certifi.where()
client = MongoClient(f'mongodb+srv://{MONGO_USER}:{MONGO_PASS}@cluster0.ebm0gtg.mongodb.net/?retryWrites=true&w=majority', tlsCAFile=ca)
db = client.miniproject

# 로그인 함수
def user_login():
    email = request.form['email']
    password = request.form['password']

    user = db.users.find_one({'email': email})

    if not user:
        return jsonify({'message': '등록되지 않은 회원입니다.'}), 401

    if user['password'] != password:
        return jsonify({'message': '비밀번호가 일치하지 않습니다.'}), 401

    resp = make_response(render_template('index.html'))
    payload = {
        'email': email,
        'exp': datetime.utcnow() + timedelta(seconds=60 * 60 * 24)  # 로그인 24시간 유지
    }
    token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")
    resp.set_cookie("AccessToken", token)
    return resp


# 토큰 검증 함수
def verify_token():
    token = request.cookies.get('AccessToken')
    if not token:
        return jsonify({"message": "토큰이 존재하지 않습니다.", "authenticated": False}), 401

    try:
        # 토큰 검증
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return jsonify({"message": "OK", "authenticated": True}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({"message": "만료된 토큰입니다.", "authenticated": False}), 401
    except jwt.InvalidTokenError:
        return jsonify({"message": "올바르지 않은 토큰입니다.", "authenticated": False}), 401


# 로그아웃 함수
def user_logout():
    resp = make_response("로그아웃 완료")
    resp.set_cookie('AccessToken', '', expires=0)
    return resp

