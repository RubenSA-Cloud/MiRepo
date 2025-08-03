FROM node:20-slim

WORKDIR /app

COPY api/package.json .
RUN npm install

COPY api/ .

CMD ["node", "index.js"]

