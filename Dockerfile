FROM gliderlabs/alpine:latest

MAINTAINER Paul Schoenfelder <paulschoenfelder@gmail.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2016-03-01
ENV LANG en_US.UTF-8
ENV HOME /root

# Install Erlang
RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'http://dl-4.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk --update add ncurses-libs ca-certificates \
                     erlang erlang-dev erlang-kernel erlang-hipe erlang-compiler \
                     erlang-stdlib erlang-erts erlang-tools erlang-syntax-tools erlang-sasl \
                     erlang-crypto erlang-public-key erlang-ssl erlang-ssh erlang-asn1 erlang-inets \
                     erlang-inets erlang-mnesia erlang-odbc \
                     erlang-erl-interface erlang-parsetools erlang-eunit && \
    rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
