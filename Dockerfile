FROM node:18-slim AS builder

WORKDIR /usr/src/app

COPY package*.json ./
COPY ./yarn.lock ./yarn.lock

RUN apt-get update

RUN yarn install

COPY . ./

ARG REACT_APP_STAGE
RUN yarn build
USER node

FROM node:18-slim

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/build ./build

RUN yarn add serve

CMD ["yarn", "serve", "-s", "build"]
