# Use the official Golang image as the base image
FROM golang:1.20

# Set the working directory inside the container
WORKDIR /app

# Copy the Go application code into the container
COPY hello.go .

# Build the Go application
RUN go build -o hello hello.go

# Set ENTRYPOINT and CMD to handle arguments properly
ENTRYPOINT ["./hello"]
CMD ["World"] # Default argument if none is provided
