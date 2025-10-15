# Use an official lightweight web server image
FROM nginx:alpine

# Copy your web app files into the container
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
