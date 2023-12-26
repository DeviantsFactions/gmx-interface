FROM node:18-slim AS builder

WORKDIR /usr/src/app

COPY . ./

RUN apt-get update

RUN yarn install
RUN yarn build
USER node

CMD ["yarn", "serve", "-s", "build"]