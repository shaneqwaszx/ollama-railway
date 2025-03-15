FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl
WORKDIR /app

# Download a precompiled Ollama release (example link, adjust version/URL)
RUN curl -L -o ollama.tar.gz "https://github.com/jmorganca/ollama/releases/download/v1.0.0/ollama-linux-x86_64.tar.gz"
RUN tar -xzf ollama.tar.gz -C /app
RUN rm ollama.tar.gz

EXPOSE 11434
CMD ["./ollama", "serve", "--port", "0.0.0.0:${PORT}"]