FROM golang:1.22-alpine AS builder

WORKDIR /app

RUN apk add --no-cache gcc musl-dev

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o tracker .

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/tracker .

CMD ["./tracker"]