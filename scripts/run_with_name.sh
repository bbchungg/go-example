#!/bin/bash

NAME=""

# Wait until we get a valid name from the Buildkite metadata
until [ ${#NAME} -gt 0 ]; do
  echo "Waiting for user-provided name..."
  NAME=$(buildkite-agent meta-data get prompt_name)
  sleep 1
done

# Create a Dockerfile that will package the Go binary
cat <<EOF > ./tmp/Dockerfile
FROM alpine:latest
WORKDIR /app
COPY hello /app/hello
RUN chmod +x /app/hello
ENTRYPOINT ["/app/hello"]
EOF

# Build the Docker image
docker build -t hello-app ./tmp/

# Run the Docker container with the user-provided name
docker run --rm hello-app "$NAME"
