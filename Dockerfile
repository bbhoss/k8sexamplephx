FROM ubuntu:17.04
RUN apt-get update && apt-get install -y git g++ locales curl wget make
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LC_MESSAGES POSIX

RUN mkdir /app
WORKDIR /app
COPY . .
RUN \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && apt-get update && apt-get install -y libssl-dev esl-erlang elixir \
  && mix local.hex --force \
  && mix local.rebar --force \
  && mix do deps.get, deps.compile \
  && mix do phoenix.digest \
  && MIX_ENV=prod mix release --env=prod --verbose
ADD  _build/prod/rel/example_phx/releases/0.0.1/example_phx.tar.gz .
ENTRYPOINT ["/bin/bash"]
CMD ["/app/bin/example_phx", "foreground"]
