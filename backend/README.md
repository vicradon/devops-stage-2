# Backend - FastAPI with PostgreSQL

This directory contains the backend of the application built with FastAPI and a PostgreSQL database.

## Prerequisites

- Python 3.8 or higher
- Poetry (for dependency management)
- PostgreSQL (ensure the database server is running)

### Installing Poetry

To install Poetry, follow these steps:

```sh
curl -sSL https://install.python-poetry.org | python3 -
```

Add Poetry to your PATH (if not automatically added):

## Setup Instructions

1. **Navigate to the backend directory**:

   ```sh
   cd backend
   ```

2. **Install dependencies using Poetry**:

   ```sh
   poetry install
   ```

3. **Set up the database with the necessary tables**:

   ```sh
   poetry run bash ./prestart.sh
   ```

4. **Run the backend server**:

   ```sh
   poetry run uvicorn app.main:app --reload
   ```

5. **Update configuration**:
   Ensure you update the necessary configurations in the `.env` file, particularly the database configuration.

## Building and Running via Docker

Before attempting to run this project as a Docker container, ensure that you are running PostgreSQL on your host machine or on an internet routable machine. This is because as part of the setup, the app will attempt to create a database table and insert an admin user. If you wish to use your host machine and are on Linux, set the value of POSTGRES_SERVER to the host IP private address. If you are on Mac or Windows, use `host.docker.internal`. Ensure you have created the user app with password "changethis123" and has full access to database "app".

```.env
# Postgres
POSTGRES_SERVER=host.docker.internal # or 192.168.14.9 for linux
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=app
POSTGRES_PASSWORD=changethis123
```

After setting these values, build and run the app like so:

```sh
docker build -t backend .
docker run -dp 8000:8000 backend
```

The command snippet above will build the project as a Docker image and tag it as backend. It'll then run it as a Docker container on port 8000.
