# Use an Ubuntu base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl build-essential git cmake libssl-dev pkg-config ca-certificates

# Install Go (required to build Ollama).
RUN curl -OL https://go.dev/dl/go1.20.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz \
    && rm go1.20.3.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# Clone the Ollama repo
RUN git clone https://github.com/jmorganca/ollama.git /ollama-source

# Switch into the cloned folder
WORKDIR /ollama-source

# Build Ollama from source
RUN make

# Expose a port. We'll bind to $PORT at runtime.
EXPOSE 11434

# Start the Ollama server, listening on $PORT for Railway
CMD ["./bin/ollama", "serve", "--port", "0.0.0.0:${PORT}"]