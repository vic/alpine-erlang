# Erlang on Alpine Linux

This Dockerfile provides a full installation of Erlang on Alpine, intended for running Erlang releases,
so it has no build tools installed. The Erlang installation is provided so one can avoid cross-compiling
releases. The caveat of course is if one has NIFs which require a native compilation toolchain, but that is
left as an exercise for the reader.

## Usage

To boot straight to a prompt in the image:

```
$ docker run --rm -it bitwalker/alpine-erlang erl
Erlang/OTP 18 [erts-7.2.1] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Eshell V7.2.1  (abort with ^G)
1>
BREAK: (a)bort (c)ontinue (p)roc info (i)nfo (l)oaded
       (v)ersion (k)ill (D)b-tables (d)istribution
a
```

Extending for your own application:

```dockerfile
FROM bitwalker/alpine-erlang:1.0

# Set exposed ports
EXPOSE 5000
ENV PORT=5000

# Set your project's working directory
WORKDIR /app

ENV HOME=/app MIX_ENV=prod

RUN groupadd -r appuser -g 433 && \
    useradd -u 431 -r -g appuser -d /app -s /sbin/nologin -c "app user" appuser && \
    chown -R appuser:appuser /app

ADD yourapp.tar.gz ./
RUN tar -xzvf yourapp.tar.gz

CMD ./bin/yourapp foreground
```

## License

MIT
