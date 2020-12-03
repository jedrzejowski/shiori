FROM golang:1.14-alpine AS builder
RUN apk add --no-cache build-base
WORKDIR /src
COPY . .
RUN go build

FROM golang:1.14-alpine
COPY --from=builder /src/shiori /usr/local/bin/

WORKDIR /srv/shiori
ENV SHIORI_DIR /srv/shiori/
EXPOSE 8080

CMD ["/usr/local/bin/shiori", "serve"]
