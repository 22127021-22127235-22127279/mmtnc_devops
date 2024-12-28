FROM node:16-alpine

WORKDIR /app

COPY packaage*.json ./

RUN npm install

COPY . .
CMD ["npm", "start"]