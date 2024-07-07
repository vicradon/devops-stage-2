# Full-Stack FastAPI and React Template with Docker Deployment

Welcome to the Full-Stack FastAPI and React template repository. This repository contains a sample frontend and backend project built with React.js and FastAPI respectively. It also contains a `compose.yaml` file that handles setup for testing and deployment purposes.

## Project Structure

The repository is organized into two main directories:

- **frontend**: Contains the ReactJS application.
- **backend**: Contains the FastAPI application and PostgreSQL database integration.

You can take a peak at the frontend project structure below:

```
frontend
├── biome.json
├── Dockerfile
├── index.html
├── modify-openapi-operationids.js
├── package.json
├── package-lock.json
├── public
│   └── assets
├── README.md
├── src
│   ├── client
│   ├── components
│   ├── hooks
│   ├── main.tsx
│   ├── routes
│   ├── routeTree.gen.ts
│   ├── theme.tsx
│   ├── utils.ts
│   └── vite-env.d.ts
├── tsconfig.json
├── tsconfig.node.json
└── vite.config.ts
```

The basic backend structure is also shown below:

```
backend
├── alembic.ini
├── app
│   ├── alembic
│   ├── api
│   ├── backend_pre_start.py
│   ├── core
│   ├── crud.py
│   ├── email-templates
│   ├── initial_data.py
│   ├── __init__.py
│   ├── main.py
│   ├── models.py
│   ├── tests
│   └── utils.py
├── Dockerfile
├── poetry.lock
├── prestart.sh
├── pyproject.toml
└── README.md
```

Each directory has its own README file with detailed instructions specific to that part of the application.

## Getting Started

To get started with this template, please follow the instructions in the respective directories:

- [Frontend README](./frontend/README.md)
- [Backend README](./backend/README.md)

## Host requirements

To run this repository, your device should have at least:

1. 5 GB of free space
2. 4 GB of RAM

## Components

This full-stack project consists of 5 components. Find below the components and their respective ports:

| Component            | Port(s)       |
| -------------------- | ------------- |
| Frontend             | 5173          |
| Backend              | 8000          |
| Postgresql DB        | 5432          |
| Adminer (PhpMyAdmin) | 8080          |
| Nginx Proxy Manager  | 8090, 80, 443 |

## Default Credentials

### Frontend Dashboard and Nginx Proxy Manager

For the proxy manager and frontend dashboard, they are:

**email**: devops@hng.tech \
**password**: devops#HNG11

### Adminer (PhpMyAdmin)

For adminer, set the system as PostgreSQL, then the other credentials as follows:

**Username**: app \
**Password**: humanslovedbs \
**Database**: app

This is shown in the image below:

![Adminer Credentials](https://github.com/vicradon/devops-stage-2/assets/40396070/08b721b6-60da-449e-9ab5-83aad6cc0789)

## Deployment Requirement

To run the frontend and backend with minimal setup, ensure you have both [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) installed. Then run the command below:

```sh
docker compose up -d
```

The command above will run the docker compose file `compose.yaml` on the root directory of this repository and set up the components.

## Deploying to cloud

You can deploy to a cloud virtual machine in the same way you did locally. Simply ensure you have docker and docker compose installed and run the compose up command.

## Setting up domain names

You can include domain names in this project to get it shown to the internet. If you already have an existing domain, you can utilize subdomains of that domain. You should have three subdomains, or two subdomains and one main domain. If you're only using subdomains, configure it like so:

| Subdomain                         | Service              | IP Address |
| --------------------------------- | -------------------- | ---------- |
| proxy.fullstackapp.yourdomain.ext | Nginx Proxy Manager  | your_vm_ip |
| db.fullstackapp.yourdomain.ext    | Adminer              | your_vm_ip |
| fullstackapp.yourdomain.ext       | Frontend and Backend | your_vm_ip |

If instead your using a new domain, then you only need to create two subdomain. Configure it like so:

| (sub)Domain          | Service              | IP Address |
| -------------------- | -------------------- | ---------- |
| proxy.yourdomain.ext | Nginx Proxy Manager  | your_vm_ip |
| db.yourdomain.ext    | Adminer              | your_vm_ip |
| yourdomain.ext       | Frontend and Backend | your_vm_ip |

## Proxying the backend to the frontend using Nginx Proxy Manager

The frontend and the backend will run on the same domain (or subdomain), so you must use Nginx proxy manager to handle the proxy setup. So after setting up your frontend + backend proxy host as shown below:

![Frontend and backend setup](https://github.com/vicradon/devops-stage-2/assets/40396070/697aeefd-d700-40dd-b1a0-b0baa54a0baa)

you should set the backend proxying in the custom locations tab:

![Proxying in the /api, /docs, and /redoc](https://github.com/vicradon/devops-stage-2/assets/40396070/59cf3231-882f-419a-a107-8414d1f7ad0c)

After doing this, modify the compose.yaml frontend service's VITE_API_URL environment variable to instead point to your subdomain

```yml
frontend:
  environment:
    VITE_API_URL: "https://fullstackapp.yourdomain.ext"
  build:
    context: ./frontend
    dockerfile: Dockerfile
  ports:
    - "5173:5173"
  depends_on:
    - backend
  restart: always
```

## All the proxied applications

After proxying all the components, your nginx proxy manager proxy dashboard will look like this:

![Nginx proxy manager dashboard](https://github.com/vicradon/devops-stage-2/assets/40396070/7ebfba1b-8e1c-4ba7-a69d-98886391b8d7)

## Proxying www to non-www

Some users enter www before entering your site name so you can handle redirects using the proxy manager. Simply create new subdomains that point to the IP address (A record) and then configure redirect in the advanced tab of the new proxy host. So you configure a new proxy host as normal and use www.yourdomain.ext as the domain. You can also configure SSL for this. And for the advanced tab, it will have the following snippet:

```conf
return 301 $forward_scheme://yourdomain.ext$request_uri;
```

In the end, you should have up to 6 proxy hosts
![proxy hosts](https://github.com/vicradon/devops-stage-2/assets/40396070/f4a48912-3987-4a63-9ddd-840fef326bd6)

