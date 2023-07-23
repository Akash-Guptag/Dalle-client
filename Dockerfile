# Stage 1: Build the React application
FROM node:14 AS build-stage

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files to the container
COPY . .

# Build the React application
RUN npm run build

# Stage 2: Serve the built static files using Nginx
FROM nginx:alpine as production-stage

# Copy the built static files from the build-stage to Nginx HTML root
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose the port on which Nginx listens (default is 80)
EXPOSE 80

# Nginx container runs the web server automatically, so no need for CMD or ENTRYPOINT
