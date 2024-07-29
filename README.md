# Hello World React App with Docker and Render

This project is a simple "Hello World" React application that is containerized using Docker and deployed using Render. It demonstrates how to integrate Docker, GitHub Actions, and Render for continuous deployment.

## Project Overview

- **React Application**: A basic React app displaying "Hello World."
- **Docker**: Containerizes the React application.
- **GitHub Actions**: Automates the build and deployment process.
- **Render**: Hosts the React application.

## Prerequisites

Before you start, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (version 18 or later)
- [Docker](https://www.docker.com/get-started)
- [Git](https://git-scm.com/)

## Setup Instructions

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/your-username/hello-world-react-app.git
    cd hello-world-react-app
    ```

2. **Install Dependencies:**

    ```bash
    npm install
    ```

3. **Build the React App:**

    ```bash
    npm run build
    ```

4. **Run Locally with Docker:**

    ```bash
    docker build -t hello-world-app .
    docker run -p 5000:5000 hello-world-app
    ```

    Open `http://localhost:5000` in your browser to see the application.

## GitHub Actions Workflow

The GitHub Actions workflow automates the build and deployment process. It builds the Docker image, pushes it to the Render Docker registry, and triggers the deployment.

### Workflow File

Located at `.github/workflows/deploy.yml`.

```yaml
name: Deploy to Render

on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Build Docker image
      run: docker build -t hello-world-app .

    - name: Log in to Render Docker Registry
      run: echo "${{ secrets.RENDER_API_KEY }}" | docker login registry.render.com --username your-username --password-stdin

    - name: Tag Docker image
      run: docker tag hello-world-app registry.render.com/your-username/hello-world-app:latest

    - name: Push Docker image to Render
      run: docker push registry.render.com/your-username/hello-world-app:latest

    - name: Trigger Render Deployment
      run: |
        curl -X POST "${{ secrets.RENDER_DEPLOY_HOOK_URL }}"
```

# Secrets Configuration

    RENDER_API_KEY: Your Render API key.
    RENDER_DEPLOY_HOOK_URL: The deploy hook URL from Render.

# Deployment

1. Set up Render:
Sign up or log in to Render.
Create a new service and link it to your Docker image repository.
Add Secrets to GitHub:
Go to GitHub repository settings.
Navigate to "Secrets and variables" > "Actions."
Add RENDER_API_KEY and RENDER_DEPLOY_HOOK_URL.

2. Push Changes to GitHub:
Any push to the main branch will trigger the GitHub Actions workflow to build, push, and deploy the Docker image.


### Instructions for Use:

1. **Replace Placeholder Text:**
   - Replace `your-username` with your actual GitHub and Render username.
   - Replace `your-email@example.com` with your actual email address.

2. **Deployment Details:**
   - Ensure your Render deployment setup aligns with the instructions provided.

Feel free to adjust any section based on the specifics of your project and deployment setup.

