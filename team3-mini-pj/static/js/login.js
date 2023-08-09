"use strict";

const loginBtn = document.querySelector("#login-button");

export const login = () => {
  const formData = new FormData();
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  formData.append("email", email);
  formData.append("password", password);

  fetch("/login", {
    method: "POST",
    body: formData,
  })
    .then((response) => {
      if(response.status === 401) {
        throw new Error('로그인 정보가 잘못되었습니다.')
      } else {    
        window.location.href = "/";
      }
    })
    .catch((error) => {
      alert(error.message)
    })
    ;
};

loginBtn.addEventListener("click", login);