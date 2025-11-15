FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o tracker .

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/tracker .
COPY --from=builder /app/tracker.db ./

CMD ["./tracker"]