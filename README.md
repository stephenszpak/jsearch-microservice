# JobHunt Microservice

This service aggregates job postings from multiple sources and exposes a simple REST API.

## Development

```bash
git clone <repo_url>
cd jsearch-microservice
cp .env.example .env
# edit .env with your DB credentials and cookies
docker compose up --build
```

Once running, query:

```
curl http://localhost:4000/jobs?keyword=elixir
```
