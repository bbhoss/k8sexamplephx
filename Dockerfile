FROM ubuntu:17.04
RUN set -eu pipefail \
  && apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y git g++ locales curl wget make libssl-dev \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX \
  && mkdir -p /app
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV LC_MESSAGES=POSIX
ENV IFS=$'\n\t'
ENV HOME=/app

WORKDIR /app
COPY . .
RUN \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update -y \
  && apt-get install -y esl-erlang elixir \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix do deps.get, deps.compile \
  && mix do phoenix.digest \
  && MIX_ENV=prod mix release --env=prod --verbose \
  && tar xvzf _build/prod/rel/example_phx/releases/0.0.1/example_phx.tar.gz && ls -alrth /app/bin \
  && rm -rf .git \
  && rm -rf test \
  && rm -rf _build \
  && rm -f .gitignore Dockerfile mix.exs mix.lock vm.args
ENTRYPOINT ["/bin/bash"]
CMD ["/app/bin/example_phx", "foreground"]
