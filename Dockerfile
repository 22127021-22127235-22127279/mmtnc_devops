FROM node:16-alpine

WORKDIR /app

COPY packege*.json ./

RUN npm install

COPY . .
CMD ["npm", "start"]