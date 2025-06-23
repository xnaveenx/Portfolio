FROM node:latest as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# This Dockerfile builds a Node.js application and serves it with Nginx.
# It uses a multi-stage build to keep the final image small.
# The first stage installs dependencies and builds the app,