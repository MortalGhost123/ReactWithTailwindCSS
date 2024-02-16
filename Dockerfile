# Stage 1: Build the application
FROM node:alpine AS builder
 
WORKDIR /usr/src/app
 
COPY package*.json ./
RUN npm install
 
COPY . .
RUN npm run build
 
# Stage 2: Create the production image
FROM nginx:alpine
 
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
 
# Expose port 80 to the outside world
EXPOSE 80
 
# Command to run the application
CMD ["nginx", "-g", "daemon off;"]



