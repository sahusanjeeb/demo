#stage 1
FROM node:latest as node
WORKDIR /app
COPY . .
ARG ENVIRONMENT
RUN if [ -z "$ENVIRONMENT" ]; then echo "Error: ENVIRONMENT argument is missing. Please provide it using --build-arg ENVIRONMENT=<environment-name>"; exit 1; fi
RUN npm install
RUN npm run build -- --configuration=$ENVIRONMENT

#stage 2
FROM nginx:alpine
EXPOSE 4200
COPY --from=node /app/dist/digital-ascender-web-app /usr/share/nginx/html/newportal
