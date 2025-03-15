FROM ubuntu:22.04

# Minimal dependencies
RUN apt-get update && apt-get install -y curl

# Create a working directory
WORKDIR /app

# 1) Download a prebuilt Ollama binary (skip building from source).
#    Replace with the correct link if there's an official release for Linux x86_64.
RUN curl -L -o ollama.tar.gz "https://github.com/jmorganca/ollama/releases/download/v0.0.0/ollama-linux-x86_64.tar.gz"
RUN tar -xzf ollama.tar.gz -C /app
RUN rm ollama.tar.gz

# Expose port for Ollama. We'll map it to $PORT on Railway.
EXPOSE 11434

# 2) Start Ollama server with qwen2.5:0.5b model
CMD ["./ollama", "serve", "--model", "qwen2.5:0.5b", "--port", "0.0.0.0:${PORT}"]
