FROM golang:1.20-alpine as builder
WORKDIR /src
RUN apk update && apk add --no-cache git && rm -rf /var/cache/apk/*
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -o server main.go

FROM scratch
WORKDIR /
COPY --from=builder /src/server .
VOLUME /web
CMD ["./server"]
