FROM elixir:1.16-alpine AS build
WORKDIR /app
ENV DB_NAME=job_hunt_prod \
    DB_USER=postgres \
    DB_PASS=postgres \
    DB_HOST=localhost \
    PORT=4000
COPY mix.exs mix.lock ./
COPY config ./config
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod
COPY lib ./lib
COPY priv ./priv
RUN MIX_ENV=prod mix release

FROM alpine:3.18 AS app
WORKDIR /app
RUN apk add --no-cache bash openssl ncurses-libs
COPY --from=build /app/_build/prod/rel/job_hunt ./
CMD ["./bin/job_hunt", "start"]
