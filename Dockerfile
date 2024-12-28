FROM node:16-alpine

WORKDIR /app

COPY node_modules ./node_modules

COPY app.js ./

COPY package.json ./

COPY package-lock.json ./

RUN npm install

EXPOSE 5000

CMD ["npm", "start"]
