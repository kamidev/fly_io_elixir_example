
ARG MIX_ENV="prod"
# Find eligible builder and runner images on Docker Hub
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=alpine
# https://hub.docker.com/_/alpine?tab=tags
ARG BUILDER_IMAGE="hexpm/elixir:1.12.3-erlang-24.1.2-alpine-3.14.2"
ARG RUNNER_IMAGE="alpine:3.14.2"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apk add --no-cache build-base git python3 curl
# prepare build dir
WORKDIR /app

# extend hex timeout
ENV HEX_HTTP_TIMEOUT=20
# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

# set build ENV
ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/$MIX_ENV.exs config/
RUN mix deps.compile

COPY priv priv
COPY assets assets
COPY lib lib
RUN mix assets.deploy
# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/
# Copy our custom release configuration and build the release
COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

WORKDIR "/app"
RUN apk add --no-cache libstdc++ openssl ncurses-libs && chown nobody:nobody /app

ARG MIX_ENV
USER nobody:nobody

COPY --from=builder --chown=nobody:nobody /app/_build/"${MIX_ENV}"/rel/hello_elixir ./

ENV SECRET_KEY_BASE=nokey
ENV PORT=4000

CMD ["bin/hello_elixir", "start"]