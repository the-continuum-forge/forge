FROM golang:1.22.5-alpine
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o app .
# Install curl to download glance.yml
RUN apk add --no-cache curl
# Download glance.yml from the specified gist
ARG GLANCE_FILE
RUN curl -o glance.yml $GLANCE_FILE
EXPOSE 8080
ENTRYPOINT ["./app"]