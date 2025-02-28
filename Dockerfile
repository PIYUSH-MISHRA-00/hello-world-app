# Use the official Node.js image.
FROM node:18

# Set the working directory.
WORKDIR /app

# Copy the package.json and package-lock.json.
COPY package*.json ./

# Install dependencies.
RUN npm install

# Copy the rest of the application.
COPY . .

# Build the React app.
RUN npm run build

# Serve the app using a simple server.
RUN npm install -g serve
CMD ["serve", "-s", "build"]

# Expose the port the app runs on.
EXPOSE 5000
