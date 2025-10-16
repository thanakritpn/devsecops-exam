# Use Node.js LTS version based on Alpine for smaller image size
FROM node:14-alpine

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy application files
COPY ratings.js .
COPY databases ./databases

# Expose port 8080
EXPOSE 8080

# Run the application without database (v1 mode)
CMD ["node", "ratings.js", "8080"]
