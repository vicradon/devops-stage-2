# Frontend - ReactJS with ChakraUI

This directory contains the frontend of the application built with ReactJS and ChakraUI.

## Prerequisites

- Node.js (version 14.x or higher)
- npm (version 6.x or higher)

## Setup Instructions

1. **Navigate to the frontend directory**:

   ```sh
   cd frontend
   ```

2. **Install dependencies**:

   ```sh
   npm install
   ```

3. **Run the development server**:

   ```sh
   npm run dev
   ```

4. **Configure API URL**:
   Ensure the API URL is correctly set in the `.env` file.

## Running via Docker

You can build and run the provided Dockerfile by running the command below:

```sh
docker build -t frontend .
docker run -dp 4000:5173 frontend
```

The command snippet above will build the frontend docker image with tag frontend and run it as a container on port 4000
