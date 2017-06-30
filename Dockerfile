FROM elixir:1.4.5-slim
ENV DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/sh \
    LANG=en_US.UTF-8 \
    LC_ALL=${LANG} \
    LC_MESSAGES=POSIX \
    LANGUAGE=en_US:en \
    TERM=xterm
RUN \
  apt-get update -q \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends apt-utils curl git libssl-dev make wget \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /app

RUN \
  mix local.hex --force \
  && mix local.rebar --force

WORKDIR /app
ENV MIX_ENV=prod REPLACE_OS_VARS=true

COPY mix.exs mix.lock ./
COPY . .

RUN \
  echo "use Mix.Config" > config/prod.secret.exs \
  && mix do deps.get, deps.compile \
  && mix do phoenix.digest \
  && MIX_ENV=prod mix release --env=prod --verbose \
  && tar xvzf _build/prod/rel/example_phx/releases/0.0.1/example_phx.tar.gz \
  && ls -alrth /app/bin \
  && rm -rf _build \
  && rm -f mix.exs mix.lock vm.args

ENTRYPOINT ["/bin/sh"]
CMD ["/app/bin/example_phx", "foreground"]
