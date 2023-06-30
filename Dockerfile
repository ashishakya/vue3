FROM node:12

WORKDIR /vue3-app

COPY package*.json ./

RUN npm install

COPY . .

#EXPOSE 3000

CMD [ "npm", "run", "serve" ]



