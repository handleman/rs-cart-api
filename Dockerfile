# Base
FROM node:12-alpine AS BUILD_IMAGE

WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm ci 

# Build
COPY . .
RUN npm run build

FROM node:12-alpine

WORKDIR /app
# copy only dist folder from build image
COPY --from=BUILD_IMAGE /app/dist ./dist

# Application
USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]
