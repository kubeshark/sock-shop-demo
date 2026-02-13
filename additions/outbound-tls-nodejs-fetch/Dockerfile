ARG NODEVERSION=16
FROM node:${NODEVERSION}

WORKDIR /app

COPY package-lock.json .
COPY package.json .
COPY main.js .

RUN npm install
