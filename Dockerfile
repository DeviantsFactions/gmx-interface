FROM node:20-slim AS builder

WORKDIR /usr/src/app

COPY package*.json ./
COPY ./yarn.lock ./yarn.lock

# RUN apt-get update
# RUN apt-get -y install python3
# RUN apt-get -y install python
# RUN apt-get -y install python3-pip
# RUN apt-get -y install git
# RUN which python
# RUN which python3
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# To do: Only install production dependencies.
# RUN yarn install --frozen-lockfile
RUN yarn install

COPY . ./

RUN yarn build
USER node

FROM node:20-slim

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/build ./build
# COPY --from=builder /usr/src/app/start.sh ./start.sh
# RUN chmod 755 ./start.sh
# COPY --from=builder  /usr/src/app/serve.json ./build/serve.json
RUN yarn global add serve

CMD [ "serve", "-s", "dist" ]
# # ENTRYPOINT [ "/usr/src/app/start.sh" ]