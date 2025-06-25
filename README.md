# JobHunt Microservice

This application aggregates job postings from sites like LinkedIn, Indeed, Glassdoor and GitHub. It exposes a simple REST API that your own apps or scripts can query.

The service is written in [Elixir](https://elixir-lang.org) and is distributed using Docker. The steps below assume no prior Elixir knowledge.

## Prerequisites

Before you begin you will need the following installed:

- [Git](https://git-scm.com/) to clone the repository.
- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/) to build and run the containers.

## Getting the code

Clone this repository somewhere on your machine:

```bash
git clone <repo_url>
cd jsearch-microservice
```

## Configuring the environment

The application reads its configuration from environment variables. A sample file called `.env.example` is provided. Copy it to `.env` and update the values as needed:

```bash
cp .env.example .env
```

Open `.env` in your favourite editor and review the settings. By default the database credentials match the ones used by the `docker-compose.yml` file. You may also want to provide any authentication cookies for the job sites you intend to scrape.

## Starting the containers

Build and launch the containers with Docker Compose:

```bash
docker compose up --build
```

The first run can take a while as Docker downloads the base images and compiles the Elixir dependencies. When the command finishes you should have two containers running:

- **db** – a PostgreSQL instance used by the application
- **app** – the JobHunt application itself

The API will be available at `http://localhost:4000` once everything starts.

## Setting up the database

Inside the running application container you need to create the database and run the migrations:

```bash
docker compose exec app mix ecto.create
docker compose exec app mix ecto.migrate
```

These commands prepare the PostgreSQL database for storing job listings.

## Running the tests

If you would like to run the unit tests inside the container, execute:

```bash
docker compose exec app mix test
```

## Querying the API

You can now query for jobs using curl or any HTTP client:

```bash
curl "http://localhost:4000/jobs?keyword=elixir"
```

This should return a JSON array of jobs matching the provided keyword.

## Stopping the service

When you are finished you can stop the containers with:

```bash
docker compose down
```

This will shut down and remove the containers while leaving your database volume intact.
