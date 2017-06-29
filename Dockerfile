FROM ubuntu:17.04
RUN apt-get update && apt-get install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LC_MESSAGES POSIX

RUN mkdir /app
WORKDIR /app
RUN apt-get update && apt-get install -y libssl-dev
ADD _build/prod/rel/example_phx/releases/0.0.1/example_phx.tar.gz .
CMD ["/app/bin/example_phx", "foreground"]
