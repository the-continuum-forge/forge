FROM golang:1.22.5-alpine
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o app .
# Install curl to download glance.yml
RUN apk add --no-cache curl
# Download glance.yml from the specified gist
RUN curl -o glance.yml https://gist.githubusercontent.com/vishalkadam47/890c6bcc912c2105ca52c80c717cdf72/raw/glance.yml
EXPOSE 8080
ENTRYPOINT ["./app"]