# Stage 1: Build the Astro static site
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency definitions
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm ci || npm install

# Copy the source code
COPY . .

# Build the project (outputs to /app/dist)
RUN npm run build

# Stage 2: Serve the compiled static site with Nginx
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy static assets from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Overwrite the default Nginx configuration with our custom optimized config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Keep Nginx running in the foreground
CMD ["nginx", "-g", "daemon off;"]
