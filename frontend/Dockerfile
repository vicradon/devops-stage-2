FROM node:20

WORKDIR /var/www/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

EXPOSE 5173

CMD [ "npx", "vite", "--host" ]
