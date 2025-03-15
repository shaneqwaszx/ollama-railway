# Dockerfile at the root of your repo
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl build-essential git cmake libssl-dev pkg-config ca-certificates

# Install Go
RUN curl -OL https://go.dev/dl/go1.20.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz \
    && rm go1.20.3.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# Clone the Ollama repo (with submodules if any)
RUN git clone --recursive https://github.com/jmorganca/ollama.git /ollama-source

WORKDIR /ollama-source
RUN make

EXPOSE 11434
CMD ["./bin/ollama", "serve", "--port", "0.0.0.0:${PORT}"]
