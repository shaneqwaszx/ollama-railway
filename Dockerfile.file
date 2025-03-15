# Use an Ubuntu base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl build-essential git cmake libssl-dev pkg-config ca-certificates

# Install Go (required to build Ollama). 
# This uses version 1.20 as an example:
RUN curl -OL https://go.dev/dl/go1.20.3.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.20.3.linux-amd64.tar.gz \
    && rm go1.20.3.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# Build Ollama from source
RUN git clone https://github.com/jmorganca/ollama.git /ollama-source
WORKDIR /ollama-source
RUN make

# Expose port 11434
EXPOSE 11434

# Start the Ollama server
CMD ["./bin/ollama", "serve"]
