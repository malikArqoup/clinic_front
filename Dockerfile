# Stage 1: Build Angular frontend
FROM node:20 AS frontend-build
WORKDIR /app
COPY clinic-frontend/package*.json ./clinic-frontend/
RUN npm install -g @angular/cli@19.2.15
WORKDIR /app/clinic-frontend
RUN npm install --ignore-scripts
COPY clinic-frontend/ ./
RUN npm run build -- --configuration production

# Stage 2: Serve Angular app with Nginx
FROM nginx:alpine
COPY --from=frontend-build /app/clinic-frontend/dist/clinic-frontend /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
