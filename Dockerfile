# # Build Stage
FROM node:alpine AS builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
VOLUME [ "/app/node_modules",".:/app" ]
COPY . .
RUN npm run build

# Production Stage
FROM nginx
COPY  --from=builder '/app/build' '/usr/share/nginx/html'

# Optional: copy custom nginx config if needed
# COPY nginx.conf /etc/nginx/nginx.conf
