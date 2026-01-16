FROM node:18-alpine as node

FROM node as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 
RUN npm run build




FROM node as production

RUN adduser -D bookshop

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY --from=build /app/dist ./dist

RUN chown -R bookshop:bookshop /app

USER bookshop

CMD ["node", "dist/main.js"]

EXPOSE 3000