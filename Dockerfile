FROM golang:1.22-alpine AS builder  
WORKDIR /app  
COPY go.mod go.sum ./
RUN go mod download  
COPY . .  
RUN go build -o myapp .  
FROM alpine:latest
# Install curl to download glance.yml from repository
RUN apk add --no-cache curl  
WORKDIR /app  
# update the username and repository names to yours please
RUN curl -o glance.yml https://gist.githubusercontent.com/vishalkadam47/c37f3841ef38e0f54d38ff8594de4b1d/raw/8215253e1664af488b3b78a4adc458e844eaf0d6/glance.yml
COPY --from=builder /app/myapp /myapp  
ENTRYPOINT ["/myapp"]
