import http from "k6/http";

import { check } from "k6";

// const BASE_URL = "https://linkindemo.vercel.app";

const BASE_URL = "http://3.228.22.190/";
const username = "admin";
const password = "linkin123";
const cookieName = "linkin.auth";

const colorGen = () => "#" + ((Math.random() * 0xffffff) << 0).toString(16);

export let options = {
  // duration: "10s",
  stages: [
    { duration: "5m", target: 10 },
    { duration: "5m", target: 100 },
    { duration: "5m", target: 0 },
  ],
};

export default function () {
  let login = http.post(`${BASE_URL}/api/login`, { username, password });

  // console.log(JSON.stringify(login.cookies["linkin.auth"][0]["value"]));

  check(login, {
    "is status 200": (r) => r.status === 200,
    "is logged in ": (r) => r.cookies[cookieName][0]["value"] !== "",
  });

  const jar = http.cookieJar();

  jar.set(BASE_URL, cookieName, login.cookies["linkin.auth"][0]["value"]);

  let payload = JSON.stringify({
    pagedataid: 1,
    iconClass: "fas fa-fire-alt",
    displayText: "K6 testing",
    linkUrl: "https://k6.io/",
    bgColor: colorGen(),
    borderRadius: "15",
    textColor: colorGen(),
    accentColor: colorGen(),
    active: true,
  });

  let jsonHeaders = {
    headers: {
      "Content-Type": `application/json`,
    },
  };

  let insert = http.post(
    `${BASE_URL}/api/insertpagelinks`,
    payload,
    jsonHeaders
  );

  // console.log(JSON.stringify(insert));

  check(insert, {
    "is status 200": (r) => r.status === 200,
    "is insert page links ": (r) => r.json().success === true,
  });
}
