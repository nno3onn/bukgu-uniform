import fetch from "node-fetch";
import apiRoutes from "./apiRoutes";

const getApi = async (url) => {
  const token = window.localStorage.getItem("x-access-token");
  const options = {
    method: "GET",
    headers: {
      "Content-type": "application/json",
      "x-access-token": token,
      "Access-Control-Allow-Origin": "*",
    },
  };

  const res = await fetch(url, options);

  return res.json();
};

const postApi = async (url, body) => {
  const token = window.localStorage.getItem("x-access-token");
  const options = {
    method: "POST",
    headers: {
      "Content-type": "application/json",
      "x-access-token": token,
      "Access-Control-Allow-Origin": "*",
    },
    body: JSON.stringify(body),
  };

  const res = await fetch(url, options);

  return res.json();
};

const putApi = async (url, body) => {
  const token = window.localStorage.getItem("x-access-token");
  const options = {
    method: "PUT",
    headers: {
      "Content-type": "application/json",
      "x-access-token": token,
      "Access-Control-Allow-Origin": "*",
    },
    body: JSON.stringify(body),
  };

  const res = await fetch(url, options);

  return res.json();
};

const deleteApi = async (url, data) => {
  const token = window.localStorage.getItem("x-access-token");
  const options = {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json",
      "x-access-token": token,
      "Access-Control-Allow-Origin": "*",
    },
  };

  try {
    const res = await fetch(`${url}/${data}`, options);
    return res.json();
  } catch (err) {
    return console.log(err);
  }
};

const postImageApi = async ({ files }) => {
  const token = window.localStorage.getItem("x-access-token");
  const options = {
    method: "PUT",
    headers: {
      "x-access-token": token,
      "Access-Control-Allow-Origin": "*",
    },
    body: JSON.stringify(files),
  };

  try {
    const res = await fetch(`${apiRoutes.SERVER_PATH}/uploads`, options);
    return res.json();
  } catch (err) {
    return console.log(err);
  }
};

const getImageFromServer = (src) => {
  if (src.slice(0, 4) === "http") return src;
  return `${apiRoutes.SERVER_PATH}/${src}`;
};

export default {
  getApi,
  postApi,
  putApi,
  deleteApi,
  getImageFromServer,
  postImageApi,
};
