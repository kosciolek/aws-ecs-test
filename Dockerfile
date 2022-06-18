FROM node:16.5 as dev

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn --frozen-lockfile

COPY ./ ./

RUN yarn build

FROM node:16.5 as prod

ENV NODE_ENV=production
WORKDIR /app

COPY --from=dev /app/dist /app/dist
COPY package.json .
COPY yarn.lock .

RUN yarn --production --frozen-lockfile

EXPOSE 3000

CMD [ "node", "dist/index.js" ]