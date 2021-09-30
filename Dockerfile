FROM node:alpine

WORKDIR /app
COPY package.json yarn.lock ./

RUN yarn install --production

COPY . .

RUN yarn mesh build

EXPOSE 4000

CMD ["yarn", "mesh", "start"]