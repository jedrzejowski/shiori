FROM golang:1.14-alpine AS builder

ADD . /go/src/shiori

WORKDIR /go/src/shiori

RUN apk add --no-cache build-base \
&& CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -v -ldflags '-s -w -linkmode external -extldflags "-static"' .

FROM busybox

COPY --from=builder /go/src/shiori/shiori /shiori

WORKDIR /srv/shiori
ENV SHIORI_DIR /srv/shiori/
EXPOSE 8080

ENTRYPOINT ["/shiori"]
CMD ["serve"]
